import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/models/Driver/driver_profile_model.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/utils/image_utils.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverProfileController extends GetxController {
  var isLoading = false.obs;
  var driverProfileModel = DriverProfileModel().obs;

  var isWithdrawLoading = false.obs;

  var isConnectLoading = false.obs;

  var changePasswordLoading = false.obs;

  var uploadProfileLoading = false.obs;

  Rx<File?> driverProfileImage = Rx<File?>(null);

  /// Pick image from camera or gallery
  Future<void> pickDriverProfileImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      driverProfileImage.value = pickedFile;
    }
  }

  Future<void> fetchDriverProfile() async {
    isLoading(true);

    final response = await ApiClient.getData("/profile");

    if (response.statusCode == 200 || response.statusCode == 201) {
      driverProfileModel.value = DriverProfileModel.fromJson(response.body);
    } else {
      debugPrint("soemthing we want wrong ======> ${response.statusText}");
    }
    isLoading(false);
  }

  Future<void> updateProfile({
    required String imagePath,
    required String name,
  }) async {
    uploadProfileLoading(true);
    List<MultipartBody> multipartBody = [];

    if (imagePath.isNotEmpty) {
      multipartBody.add(MultipartBody('avatar', File(imagePath)));
    }

    Map<String, String> fromData = {"name": name};

    final response = await ApiClient.patchMultipartData(
      "/profile/edit",
      fromData,
      multipartBody: multipartBody,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      fetchDriverProfile();
      Get.back();
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    uploadProfileLoading(false);
  }

  Future<void> connectStripeAccount() async {
    isConnectLoading(true);

    final response = await ApiClient.getData("/profile/connect-stripe");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final stripeUrl = response.body['url'];

      if (stripeUrl != null && stripeUrl.isNotEmpty) {
        // Launch the URL in the browser
        await _openPayementUrl(stripeUrl);
        fetchDriverProfile();
      } else {
        showCustomSnackBar("Stripe URL not found", isError: true);
      }
    } else {
      showCustomSnackBar("Try Again", isError: true);
    }
    isConnectLoading(false);
  }

  Future<void> _openPayementUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      showCustomSnackBar("Could not launch payment URL", isError: true);
    }
  }

  Future<void> withdrawFunds({required String amount}) async {
    isWithdrawLoading(true);

    final body = {"amount": amount};

    final response = await ApiClient.postData("/payments/withdraw", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      fetchDriverProfile();
      Get.back();
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isWithdrawLoading(false);
  }
}
