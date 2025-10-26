import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_appbar.dart';
import 'package:radeef/views/base/custom_button.dart';

class VerifySuccessScreen extends StatefulWidget {
  const VerifySuccessScreen({super.key});

  @override
  State<VerifySuccessScreen> createState() => _VerifySuccessScreenState();
}

class _VerifySuccessScreenState extends State<VerifySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Center(
            child: SvgPicture.asset('assets/icons/success.svg'),
          ),
          SizedBox(height: 24,),
          Center(
            child: Text("Verification Successful",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor
            ),
            textAlign: TextAlign.center,),
          ),
          SizedBox(height: 10,),
          Text("Under the review your account, When admin approve then to the Home",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textColor
          ),),
          SizedBox(height: 160,),
          CustomButton(onTap: (){
            Get.offAllNamed(AppRoutes.userHomeScreen);
          },
              text: "Try To Take A Trip / Percel")
        ],
      ),
    );
  }
}
