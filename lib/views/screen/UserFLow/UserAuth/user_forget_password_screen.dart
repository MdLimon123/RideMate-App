import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class UserForgetPasswordScreen extends StatefulWidget {
  const UserForgetPasswordScreen({super.key});

  @override
  State<UserForgetPasswordScreen> createState() => _UserForgetPasswordScreenState();
}

class _UserForgetPasswordScreenState extends State<UserForgetPasswordScreen> {

  final emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 100,),
          Text("Forget Password",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor
          ),),
          SizedBox(height: 32,),
          CustomTextField(controller: emailTextController,
            isEmail: true,
            hintText: "Enter your email",),
          SizedBox(height: 404,),
          CustomButton(onTap: (){
            Get.offAllNamed(AppRoutes.userOtpVerifyScreen);
          },
              text: "Send OTP")
        ],
      ),
    );
  }
}
