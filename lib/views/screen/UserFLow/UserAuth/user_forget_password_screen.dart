import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/user_auth_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class UserForgetPasswordScreen extends StatefulWidget {
  const UserForgetPasswordScreen({super.key});

  @override
  State<UserForgetPasswordScreen> createState() =>
      _UserForgetPasswordScreenState();
}

class _UserForgetPasswordScreenState extends State<UserForgetPasswordScreen> {
  final _userAuthController = Get.put(UserAuthController());
  final emailTextController = TextEditingController();
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
              "Forget Password",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor,
              ),
            ),
            SizedBox(height: 32),
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
            SizedBox(height: 404),
            Obx(
              () => CustomButton(
                loading: _userAuthController.isForgetLoading.value,
                onTap: () {
                  if (_fromKey.currentState!.validate()) {
                    _userAuthController.forgetPassword(
                      email: emailTextController.text,
                    );
                  }
                },
                text: "Send OTP",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
