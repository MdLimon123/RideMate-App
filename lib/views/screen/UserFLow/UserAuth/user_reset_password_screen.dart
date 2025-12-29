import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/user_auth_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class UserResetPasswordScreen extends StatefulWidget {
  const UserResetPasswordScreen({super.key});

  @override
  State<UserResetPasswordScreen> createState() =>
      _UserResetPasswordScreenState();
}

class _UserResetPasswordScreenState extends State<UserResetPasswordScreen> {
  final _userAuthController = Get.put(UserAuthController());
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
              hintText: "Set new password",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                } else if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            CustomTextField(
              controller: confirmPasswordController,
              hintText: "Confirm new password",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                } else if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),
            SizedBox(height: 309),
            Obx(
              () => CustomButton(
                loading: _userAuthController.isResetLoading.value,
                onTap: () {
                  if (_fromKey.currentState!.validate()) {
                    _userAuthController.resetPassword(
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
