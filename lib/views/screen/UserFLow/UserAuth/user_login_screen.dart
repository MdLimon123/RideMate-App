import 'package:flutter/material.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {

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
          hintText: "Enter Password",
          isPassword: true,),
          SizedBox(height: 12,),
          Align(
            alignment: Alignment.centerRight,
            child: Text("Forget Password?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF345983)
            ),),
          ),
          SizedBox(height: 293,),
          CustomButton(onTap: (){},
              text: "Log In")

        ],
      ),
    );
  }
}
