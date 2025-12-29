import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class DriverResetPasswordScreen extends StatefulWidget {
  const DriverResetPasswordScreen({super.key});

  @override
  State<DriverResetPasswordScreen> createState() => _DriverResetPasswordScreenState();
}

class _DriverResetPasswordScreenState extends State<DriverResetPasswordScreen> {

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 100,),
          Text("new_Password".tr,
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
            Get.offAllNamed(AppRoutes.driverLoginScreen);
          },
              text: "changeNow".tr)
        ],
      ),
    );
  }
}
