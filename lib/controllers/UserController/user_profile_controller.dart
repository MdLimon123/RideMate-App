import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/models/User/user_profile_model.dart';
import 'package:radeef/models/about_us_model.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/utils/image_utils.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileController extends GetxController {
  var userProfileModel = UserProfileModel().obs;

  var aboutUsModel = AboutUsModel().obs;

  var isLaoding = false.obs;
  var changePasswordLoading = false.obs;

  var isTopUpLoading = false.obs;

  var isConnectLoading = false.obs;

  var isWithdrawLoading = false.obs;

  var uploadProfileLoading = false.obs;

  Rx<File?> userProfileImage = Rx<File?>(null);

  Future<void> pickUserProfileImage({bool fromCamera = false}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );

    if (pickedFile != null) {
      userProfileImage.value = pickedFile;
    }
  }

  Future<void> fetchUserInfo() async {
    isLaoding(true);

    final response = await ApiClient.getData("/profile");
    if (response.statusCode == 200) {
      userProfileModel.value = UserProfileModel.fromJson(response.body);
    } else {
      debugPrint("soemting we want wrong ======> ${response.statusText}");
    }
    isLaoding(false);
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
      fetchUserInfo();
      Get.back();
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    uploadProfileLoading(false);
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    changePasswordLoading(true);

    final body = {"oldPassword": oldPassword, "newPassword": newPassword};

    final response = await ApiClient.postData("/profile/change-password", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.back();
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    changePasswordLoading(false);
  }

  Future<void> topUpWallet({required String amount}) async {
    isTopUpLoading(true);

    final body = {"amount": amount};

    final response = await ApiClient.postData("/payments/topup", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final paymentUrl = response.body['url'];

      if (paymentUrl != null && paymentUrl.isNotEmpty) {
        // Launch the URL in the browser
        await _openPayementUrl(paymentUrl);
        fetchUserInfo();
      } else {
        showCustomSnackBar("Payment URL not found", isError: true);
      }
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isTopUpLoading(false);
  }

  Future<void> _openPayementUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      showCustomSnackBar("Could not launch payment URL", isError: true);
    }
  }

  Future<void> connectStripeAccount() async {
    isConnectLoading(true);

    final response = await ApiClient.getData("/profile/connect-stripe");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final stripeUrl = response.body['url'];

      if (stripeUrl != null && stripeUrl.isNotEmpty) {
        // Launch the URL in the browser
        await _openPayementUrl(stripeUrl);
        fetchUserInfo();
      } else {
        showCustomSnackBar("Stripe URL not found", isError: true);
      }
    } else {
      showCustomSnackBar("Try Again", isError: true);
    }
    isConnectLoading(false);
  }

  Future<void> withdrawFunds({required String amount}) async {
    isWithdrawLoading(true);

    final body = {"amount": amount};

    final response = await ApiClient.postData("/payments/withdraw", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      fetchUserInfo();
      Get.back();
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isWithdrawLoading(false);
  }

  Future<void> fetchAboutUsInfo() async {
    isLaoding(true);

    final response = await ApiClient.getData("/context-pages/about-us");
    if (response.statusCode == 200) {
      aboutUsModel.value = AboutUsModel.fromJson(response.body);
    } else {
      debugPrint("soemting we want wrong ======> ${response.statusText}");
    }
    isLaoding(false);
  }
}
