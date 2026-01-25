import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:radeef/models/User/recent_destination.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/service/notification_service.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/show_amount_screen.dart';

enum LocationField { pick, drop, none }

class HomeController extends GetxController {
  final pickController = TextEditingController();
  final dropController = TextEditingController();

  final parcelTypeController = TextEditingController();
  final parcelWeightController = TextEditingController();
  final parcelAmount = TextEditingController();

  RxString selectedParcelType = "".obs;

  final box = GetStorage();

  RxList<String> parcelType = ["SMALL", "MEDIUM", "LARGE"].obs;

  var recentDestinations = <RecentDestination>[].obs;

  var isLoading = false.obs;
  var suggestions = <String>[].obs;

  var isShowAnountLoading = false.obs;

  var activeField = LocationField.none.obs;

  var pickCoordinates = <double>[].obs;
  var dropCoordinates = <double>[].obs;

  var pickAddress = ''.obs;
  var dropAddress = ''.obs;

  var selectedIndex = 0.obs;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchSuggestions(String input, LocationField field) async {
    activeField.value = field;

    if (input.isEmpty) {
      suggestions.clear();
      return;
    }

    isLoading(true);

    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConstant.googleBaseUrl}?input=$input&key=${ApiConstant.googleApiKey}',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        suggestions.value = (data['predictions'] as List)
            .map((e) => e['description'] as String)
            .toList();
      } else {
        suggestions.clear();
      }
    } catch (e) {
      suggestions.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<List<double>> _fetchLatLng(String place) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConstant.findPlaceApiUrl}?input=$place&inputtype=textquery&fields=geometry&key=${ApiConstant.googleApiKey}',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final loc = data['candidates'][0]['geometry']['location'];
      return [loc['lat'], loc['lng']];
    }
    return [];
  }

  Future<void> selectPick(String location) async {
    pickController.text = location;
    pickAddress.value = location;
    suggestions.clear();
    activeField.value = LocationField.none;
    pickCoordinates.value = await _fetchLatLng(location);
  }

  Future<void> selectDrop(String location) async {
    dropController.text = location;
    dropAddress.value = location;
    suggestions.clear();
    activeField.value = LocationField.none;
    final coords = await _fetchLatLng(location);
    if (coords.length < 2) return;

    dropCoordinates.value = coords;

    saveRecentDestination(
      RecentDestination(address: location, lat: coords[0], lng: coords[1]),
    );
  }

  void loadRecentDestinations() {
    final data = box.read<List>('recent_destinations') ?? [];

    recentDestinations.value = data
        .map((e) => RecentDestination.fromJson(e))
        .toList();
  }

  void saveRecentDestination(RecentDestination dest) {
    // remove duplicate
    recentDestinations.removeWhere((e) => e.address == dest.address);

    recentDestinations.insert(0, dest);

    if (recentDestinations.length > 5) {
      recentDestinations.removeLast();
    }

    box.write(
      'recent_destinations',
      recentDestinations.map((e) => e.toJson()).toList(),
    );
  }

  Future<void> calculateParcelAmount() async {
    if (pickCoordinates.length < 2 || dropCoordinates.length < 2) {
      showCustomSnackBar(
        "Please select pickup and drop location",
        isError: true,
      );
      return;
    }

    isShowAnountLoading(true);

    final body = {
      "pickup_lat": pickCoordinates[0],
      "pickup_lng": pickCoordinates[1],
      "dropoff_lat": dropCoordinates[0],
      "dropoff_lng": dropCoordinates[1],
      "pickup_address": pickAddress.value,
      "dropoff_address": dropAddress.value,
      "parcel_type": selectedParcelType.value,
      "weight": parcelWeightController.text,
      "amount": parcelAmount.text,
    };

    final response = await ApiClient.postData("/parcels/estimate-fare", body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(
        () => ShowAmountScreen(
          showAmount: response.body['estimated_fare'],
          weight: response.body['query']['weight'],
          amount: response.body['query']['amount'],
          pickLat: pickCoordinates[0],
          pickLng: pickCoordinates[1],
          dropLat: dropCoordinates[0],
          dropLan: dropCoordinates[1],
          pickLocation: pickAddress.value,
          dropLocation: dropAddress.value,
        ),
      );
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
  }

  Future<void> calculateAccount() async {
    if (pickCoordinates.length < 2 || dropCoordinates.length < 2) {
      showCustomSnackBar(
        "Please select pickup and drop location",
        isError: true,
      );
      return;
    }

    isShowAnountLoading(true);

    final body = {
      "pickup_lat": pickCoordinates[0],
      "pickup_lng": pickCoordinates[1],
      "dropoff_lat": dropCoordinates[0],
      "dropoff_lng": dropCoordinates[1],
      "pickup_address": pickAddress.value,
      "dropoff_address": dropAddress.value,
    };

    final response = await ApiClient.postData("/trips/estimate-fare", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(
        () => ShowAmountScreen(
          showAmount: response.body['estimated_fare'].toDouble(),
          pickLat: pickCoordinates[0],
          pickLng: pickCoordinates[1],
          dropLat: dropCoordinates[0],
          dropLan: dropCoordinates[1],
          pickLocation: pickAddress.value,
          dropLocation: dropAddress.value,
        ),
      );
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isShowAnountLoading(false);
  }

  Future<void> subscribleId() async {
    String? subscriptionId = await OneSignalHelper.getSubscriptionId();

    if (subscriptionId == null || subscriptionId.isEmpty) {
      print("OneSignal ID not available");
    }

    final response = await ApiClient.postData("/profile/onesignal-id", {
      "onesignal_id": subscriptionId,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }

    print("OneSignal ID: $subscriptionId");
  }
}
