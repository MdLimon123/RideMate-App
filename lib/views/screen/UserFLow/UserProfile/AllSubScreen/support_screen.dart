import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radeef/views/base/custom_appbar.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Support",
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
        children: [
          Center(
            child: SvgPicture.asset("assets/icons/support.svg",height: 95,
            width: 96,
            color: Color(0xFF345983),),
          ),
          SizedBox(height: 20,),
          Center(
            child: Text("Shoot us your complain through email",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2A2A2A)
            ),),
          ),
          SizedBox(height: 8,),
          Center(
            child: Text("Support@approlling.com",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2A2A2A)
            ),),
          ),
          SizedBox(height: 46,),
          Row(
            children: [
              SvgPicture.asset("assets/icons/what.svg"),
              SizedBox(width: 8,),
              Text("Need Help?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333)
              ),),
              SizedBox(height: 12,),

            ],
          ),
          SizedBox(height: 12,),
          InkWell(
            onTap: (){
             // Get.to(()=> NeedHelpScreen());
            },
            child: Container(
              height: 52,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/chat.svg"),
                  SizedBox(width: 8,),
                  Text("Live Chat",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                        fontSize: 16
                    ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
