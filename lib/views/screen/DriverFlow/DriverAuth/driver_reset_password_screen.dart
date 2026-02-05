import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_auth_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class DriverResetPasswordScreen extends StatefulWidget {
  const DriverResetPasswordScreen({super.key});

  @override
  State<DriverResetPasswordScreen> createState() =>
      _DriverResetPasswordScreenState();
}

class _DriverResetPasswordScreenState extends State<DriverResetPasswordScreen> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _driverAuthController = Get.put(DriverAuthController());
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _fromKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 100),
            Text(
              "new_Password".tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 32),
            CustomTextField(
              controller: newPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your new password";
                }
                return null;
              },
              hintText: "Set new password",
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: confirmPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your confirm password";
                }
                return null;
              },
              hintText: "Confirm new password",
            ),
            SizedBox(height: 309),
            Obx(
              () => CustomButton(
                loading: _driverAuthController.isResetLoading.value,
                onTap: () {
                  if (_fromKey.currentState!.validate()) {
                    _driverAuthController.resetPassword(
                      passwordText: newPasswordController.text,
                    );
                  }
                },
                text: "changeNow".tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
