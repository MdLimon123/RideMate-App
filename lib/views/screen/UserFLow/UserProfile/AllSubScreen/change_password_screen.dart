import 'package:flutter/material.dart';
import 'package:radeef/views/base/custom_appbar.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Change Password",
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        children: [
          CustomTextField(
            hintText: "Old Password",
          ),
          SizedBox(height: 8,),
          CustomTextField(
            hintText: "New Password",
          ),
          SizedBox(height: 8,),
          CustomTextField(
            hintText: "Confirm Password",
          ),
          SizedBox(height: 84,),
          CustomButton(onTap: (){},
              text: "Change Now")
        ],
      ),
    );
  }
}
