import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class DriverSignupScreen extends StatefulWidget {
  const DriverSignupScreen({super.key});

  @override
  State<DriverSignupScreen> createState() => _DriverSignupScreenState();
}

class _DriverSignupScreenState extends State<DriverSignupScreen> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 100,),
          Text("Sign Up",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.textColor
            ),),
          SizedBox(height: 24,),
          CustomTextField(controller: emailTextController,
            isEmail: true,
            hintText: "Enter your email",),
          SizedBox(height: 12,),
          CustomTextField(controller: passwordTextController,
            hintText: "Enter Password",),
          SizedBox(height: 12,),
          CustomTextField(controller: confirmPasswordController,
            hintText: "Confirm Password",),

          SizedBox(height: 293,),
          CustomButton(onTap: (){
            Get.offAllNamed(AppRoutes.driverTermsConditionScreen);
          },
              text: "Sign Up"),
          SizedBox(height: 20,),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: TextStyle(
                    color: Color(0xFF5A5A5A),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: "Log In",
                    style: TextStyle(
                        color: Color(0xFF145788),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                      Get.offAllNamed(AppRoutes.driverLoginScreen);
                      },
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
