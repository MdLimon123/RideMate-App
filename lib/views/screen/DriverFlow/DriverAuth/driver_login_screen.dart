import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/user_home_screen.dart';

class DriverLoginScreen extends StatefulWidget {
  const DriverLoginScreen({super.key});

  @override
  State<DriverLoginScreen> createState() => _DriverLoginScreenState();
}

class _DriverLoginScreenState extends State<DriverLoginScreen> {

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 100,),
          Text("Log In",
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
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: (){
                Get.offAllNamed(AppRoutes.driverForgotPasswordScreen);
              },
              child: Text("Forget Password?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF345983)
              ),),
            ),
          ),
          SizedBox(height: 293,),
          CustomButton(onTap: (){
            Get.offAllNamed(AppRoutes.driverHomeScreen);
          },
              text: "Log In"),
          SizedBox(height: 20,),
          Center(
            child: RichText(
              text: TextSpan(
                text: "Don’t have account? ",
                style: TextStyle(
                    color: Color(0xFF5A5A5A),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: TextStyle(
                        color: Color(0xFF145788),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                      Get.offAllNamed(AppRoutes.driverSignUpScreen);
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
