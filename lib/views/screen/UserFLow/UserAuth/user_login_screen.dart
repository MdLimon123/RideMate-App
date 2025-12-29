import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/user_auth_controller.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final _userAuthController = Get.put(UserAuthController());
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

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
              "login".tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 24),
            CustomTextField(
              controller: emailTextController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
              isEmail: true,
              hintText: "Enter your email",
            ),
            SizedBox(height: 12),
            CustomTextField(
              controller: passwordTextController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                } else if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
              hintText: "Enter Password",
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.offAllNamed(AppRoutes.userForgotPasswordScreen);
                },
                child: Text(
                  "forget".tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF345983),
                  ),
                ),
              ),
            ),
            SizedBox(height: 293),
            Obx(
              () => CustomButton(
                loading: _userAuthController.isLoading.value,
                onTap: () {
                  if (_fromKey.currentState!.validate()) {
                    _userAuthController.login(
                      email: emailTextController.text.trim(),
                      password: passwordTextController.text.trim(),
                    );
                  }
                },
                text: "login".tr,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "dontHaveAccount".tr,
                  style: TextStyle(
                    color: Color(0xFF5A5A5A),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: "signup".tr,
                      style: TextStyle(
                        color: Color(0xFF145788),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.offAllNamed(AppRoutes.userSignUpScreen);
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
