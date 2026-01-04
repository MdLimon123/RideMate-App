import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/models/Driver/parcel_request_model.dart';
import 'package:radeef/models/Driver/trip_request_model.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/utils/image_utils.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/earn_screen.dart';

class DriverParcelController extends GetxController {
  var isLoading = false.obs;
  var isLodading = false.obs;
  Rx<File?> parcelImage = Rx<File?>(null);

  final RxDouble rating = 0.0.obs;

  void updateRating(double value) {
    rating.value = value;
  }

  Future<void> pickParcelImage({bool fromCamera = true}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      parcelImage.value = pickedFile;
    }
  }

  Future<List<String>?> uplaodParcelImage({required String imagePath}) async {
    isLodading(true);

    final List<MultipartBody> multipartBody = [];
    if (imagePath.isNotEmpty) {
      multipartBody.add(MultipartBody('files', File(imagePath)));
    }

    final response = await ApiClient.postMultipartData(
      "/upload-media",
      {},
      multipartBody: multipartBody,
    );

    isLodading(false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);

      //  JSON decode if String
      final body = response.body is String
          ? jsonDecode(response.body)
          : response.body;

      if (body is List) {
        // response already List<String>
        return body.map((e) => e.toString()).toList();
      } else if (body is Map && body['files'] != null) {
        final filesData = body['files'];
        if (filesData is List) {
          return filesData.map((e) => e.toString()).toList();
        } else if (filesData is String) {
          return [filesData];
        }
      }

      return null;
    } else {
      showCustomSnackBar(response.statusText, isError: true);
      return null;
    }
  }

  Future<void> submitRating({
    required bool isParcel,
    required String userId,
    String? parcelId,
    String? tripId,
    ParcelRequestModel? parcel,
    ParcelUserModel? parcelUserModel,
    TripRequestModel? trip,
    TripUserModel? tripUserModel,
  }) async {
    isLoading(true);

    final Map<String, dynamic> body = {
      "user_id": userId,
      "rating": rating.value.toInt(),
      "comment": "Good",
    };

    if (isParcel) {
      body["ref_parcel_id"] = parcelId;
    } else {
      body["ref_trip_id"] = tripId;
    }

    final response = await ApiClient.postData("/reviews/give-review", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(
        () => EarnScreen(
          isParcel: isParcel,
          tripUserModel: tripUserModel,
          trip: trip,
          parcel: parcel,
          parcelUserModel: parcelUserModel,
        ),
      );
    } else {
      debugPrint(response.body);
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLoading(false);
  }
}
