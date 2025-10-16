import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/screen/UserFLow/SetupProfile/setup_personal_info_screen.dart';

class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: 134,),
          Center(
            child: SvgPicture.asset('assets/icons/ride2.svg')),
          SizedBox(height: 24,),
          Center(
            child: Text("Let’s Set Up Your User Profile",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor
            ),),
          ),
          SizedBox(height: 16,),
          Center(
            child: Text("A few quick steps to start earning with us",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor
            ),
            textAlign: TextAlign.center,),
          ),
          SizedBox(height: 230,),
          CustomButton(onTap: (){
            Get.to(()=> SetupPersonalInfoScreen());
          },
              text: "Next")
        ],
      ),
    );
  }
}
