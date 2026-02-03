import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_auth_controller.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class DriverForgetPasswordScreen extends StatefulWidget {
  const DriverForgetPasswordScreen({super.key});

  @override
  State<DriverForgetPasswordScreen> createState() =>
      _DriverForgetPasswordScreenState();
}

class _DriverForgetPasswordScreenState
    extends State<DriverForgetPasswordScreen> {
  final emailTextController = TextEditingController();
  final _driverAuthController = Get.put(DriverAuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 100),
          Text(
            "forget".tr,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 32),
          CustomTextField(
            controller: emailTextController,
            isEmail: true,
            hintText: "Enter your email",
          ),
          SizedBox(height: 404),
          Obx(
            () => CustomButton(
              loading: _driverAuthController.isForgetLoading.value,
              onTap: () {
                _driverAuthController.forgetPassword(
                  email: emailTextController.text,
                );
              },
              text: "sendOTP".tr,
            ),
          ),
        ],
      ),
    );
  }
}
