import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';

class DriverOtpVerifyScreen extends StatefulWidget {
  final String email;
  const DriverOtpVerifyScreen({super.key, required this.email});

  @override
  State<DriverOtpVerifyScreen> createState() => _DriverOtpVerifyScreenState();
}

class _DriverOtpVerifyScreenState extends State<DriverOtpVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 100),
          Text(
            "enterOTP".tr,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 32),
          OtpTextField(
            numberOfFields: 6,
            fieldWidth: 53,
            fieldHeight: 53,
            borderColor: Color(0xFFE6E6E6),
            enabledBorderColor: Color(0xFFE6E6E6),
            disabledBorderColor: Color(0xFFE6E6E6),
            focusedBorderColor: Color(0xFFE6E6E6),
            cursorColor: AppColors.primaryColor,
            filled: true,
            fillColor: Color(0xFFE6E6E6),
            onCodeChanged: (String code) {},
            onSubmit: (String verificationCode) {},
          ),
          SizedBox(height: 32),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Didn't receive the code? ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF5A5A5A),
                    ),
                  ),
                  TextSpan(
                    text: "Resend again",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 322),
          CustomButton(
            onTap: () {
              Get.offAllNamed(AppRoutes.driverResetPasswordScreen);
            },
            text: "verify".tr,
          ),
        ],
      ),
    );
  }
}
