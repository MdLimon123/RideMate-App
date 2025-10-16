import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class UserResetPasswordScreen extends StatefulWidget {
  const UserResetPasswordScreen({super.key});

  @override
  State<UserResetPasswordScreen> createState() => _UserResetPasswordScreenState();
}

class _UserResetPasswordScreenState extends State<UserResetPasswordScreen> {

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 100,),
          Text("Set New Password",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor
          ),),
          SizedBox(height: 32,),
          CustomTextField(controller: newPasswordController,
          hintText: "Set new password",),
          SizedBox(height: 16,),
          CustomTextField(controller: confirmPasswordController,
          hintText: "Confirm new password",),
          SizedBox(height: 309,),
          CustomButton(onTap: (){
            Get.offAllNamed(AppRoutes.userLoginScreen);
          },
              text: "Change Now")
        ],
      ),
    );
  }
}
