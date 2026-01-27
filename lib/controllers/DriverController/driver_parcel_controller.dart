import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:radeef/service/api_client.dart';
import 'package:radeef/utils/image_utils.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';

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

  Future<void> submitRating({required String userId, String? tripId}) async {
    isLoading(true);
    final Map<String, dynamic> body = {
      "user_id": userId,
      "rating": rating.value.toInt(),
      "comment": "Good",
      "ref_trip_id": tripId,
    };

    final response = await ApiClient.postData("/reviews/give-review", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar("Review Submitted", isError: false);
      // Get.to(
      //   () => EarnScreen(amount: 2.5, vat: 0.0),
      // );
      Get.offAll(() => DriverHomeScreen());
    } else {
      debugPrint(response.body);
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLoading(false);
  }
}
