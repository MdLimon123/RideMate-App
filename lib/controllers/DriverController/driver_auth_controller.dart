import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/trip_socket_controller.dart';
import 'package:radeef/controllers/UserController/tripstate_controller.dart';
import 'package:radeef/controllers/data_controller.dart';
import 'package:radeef/controllers/parcel_controller.dart';
import 'package:radeef/models/User/user_info_model.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/service/prefs_helper.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/utils/app_constants.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_login_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_otp_verify_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_reset_password_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_terms_condition_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';
import 'package:radeef/views/screen/DriverFlow/SetupDriverProfile/driver_verify_success_screen.dart';

class DriverAuthController extends GetxController {
  var isLoading = false.obs;

  var isForgetLoading = false.obs;
  var isForgetOtp = "".obs;
  var isVerify = false.obs;
  var isResetLoading = false.obs;
  final _dataController = Get.put(DataController());

  Future<void> signup({required String email, required String password}) async {
    isLoading(true);

    final body = {"email": email, "password": password, "role": "DRIVER"};
    var headers = {'Content-Type': 'application/json'};

    final response = await ApiClient.postData(
      "/auth/register",
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(
        AppConstants.bearerToken,
        response.body['access_token'],
      );
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => DriverTermsConditionScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLoading(false);
  }

  Future<void> login({required String email, required String password}) async {
    isLoading(true);

    final body = {"email": email, "password": password};

    var headers = {'Content-Type': 'application/json'};

    final response = await ApiClient.postData(
      "/auth/login",
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final userInfo = UserInfoModel.fromJson(response.body);

      final token = response.body['access_token'];

      await PrefsHelper.setString(AppConstants.bearerToken, token);
      await PrefsHelper.setUserInfo(response.body);

      /// Socket connection
      SocketService().connect(token);
      TripStateController.to.setRole(driver: true);

      // Init socket (if not already)
      var tripSocketController = Get.put(TripSocketController());
      var _parcelController = Get.put(ParcelController());

      tripSocketController.allUserListeners();
      _parcelController.allParcelUserListeners();

      _dataController.setProfileData(
        isActiveD: response.body['user']['is_active'],
        idD: response.body['user']['id'],
        nameD: response.body['user']['name'],
        roleD: response.body['user']['role'],
      );
      showCustomSnackBar(response.statusText, isError: false);

      debugPrint("User info =========> $userInfo");

      Future.delayed(const Duration(milliseconds: 300), () {
        if (userInfo.user.isActive) {
          Get.offAll(() => DriverHomeScreen());
        } else {
          Get.offAll(() => DriverVerifySuccessScreen());
        }
      });
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isLoading(false);
  }

  Future<void> forgetPassword({required String email}) async {
    isForgetLoading(true);

    final body = {"email": email};

    var headers = {'Content-Type': 'application/json'};

    final resposne = await ApiClient.postData(
      "/auth/forgot-password",
      body,
      headers: headers,
    );

    if (resposne.statusCode == 200 || resposne.statusCode == 201) {
      showCustomSnackBar(resposne.statusText, isError: false);

      Get.to(() => DriverOtpVerifyScreen(email: email));
    } else {
      showCustomSnackBar(resposne.statusText, isError: true);
    }
    isForgetLoading(false);
  }

  Future<void> otpForgetVerify({required String email}) async {
    isVerify(true);
    final body = {"email": email, "otp": isForgetOtp.value};

    var headers = {'Content-Type': 'application/json'};

    final response = await ApiClient.postData(
      "/auth/forgot-password/otp-verify",
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(
        AppConstants.bearerToken,
        response.body['reset_token'],
      );
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => DriverResetPasswordScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isVerify(false);
  }

  Future<void> resendOtpVerify({required String email}) async {
    final body = {"email": email};
    var headers = {'Content-Type': 'application/json'};

    final response = await ApiClient.postData(
      "/auth/account-verify/otp-send",
      body,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
  }

  Future<void> resetPassword({required String passwordText}) async {
    isResetLoading(true);

    final body = {"password": passwordText};

    final response = await ApiClient.postData("/auth/reset-password", body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      showCustomSnackBar(response.statusText, isError: false);
      Get.to(() => DriverLoginScreen());
    } else {
      showCustomSnackBar(response.statusText, isError: true);
    }
    isResetLoading(false);
  }
}
