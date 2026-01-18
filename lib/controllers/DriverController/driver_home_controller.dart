import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/models/Driver/driver_home_model.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/service/notification_service.dart';
import 'package:radeef/views/base/custom_snackbar.dart';

class DriverHomeController extends GetxController {
  var homeModel = HomeModel().obs;

  Future<void> fetchHomeData() async {
    final response = await ApiClient.getData("/drivers");

    if (response.statusCode == 200 || response.statusCode == 201) {
      homeModel.value = HomeModel.fromJson(response.body);
    } else {
      debugPrint("soemthing we want wrong ======> ${response.statusText}");
    }
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
      showCustomSnackBar(response.statusText, isError: false);
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }

    print("OneSignal ID: $subscriptionId");
  }
}
