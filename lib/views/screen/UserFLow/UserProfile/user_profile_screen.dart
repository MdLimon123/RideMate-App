import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/screen/Splash/select_role_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/need_help_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/AllSubScreen/about_us_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/AllSubScreen/change_password_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/AllSubScreen/edit_profile_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/AllSubScreen/support_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/AllSubScreen/trip_history_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/AllSubScreen/wallet_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios,
                  color: Color(0xFF676769),),
                  SizedBox(width: 20,),
                  Text("Profile",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333)
                  ),),
                  Spacer(),
                  InkWell(
                  onTap: (){
                    Get.to(()=> EditProfileScreen());
                  },
                  child: SvgPicture.asset("assets/icons/edit.svg"))
                ],
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/images/demo.png'),
                    fit: BoxFit.cover)
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Center(
                child: Text("John Deo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000)
                ),),
              ),
              SizedBox(height: 4,),
              Center(
                child: Text("jhon.deo@gmail.com",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF87878A)
                  ),),
              ),
              SizedBox(height: 8,),
              Center(
                child: Container(
                  width: 158,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Color(0xFFE6EAF0),
                      borderRadius: BorderRadius.circular(16)
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/cycle.svg"),
                      SizedBox(width: 4,),
                      Text("Trip",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF333333)
                        ),),
                      SizedBox(width: 4,),
                      Text("4",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF333333)
                        ),),
                      SizedBox(width: 20,),
                      Icon(Icons.star,
                        color: Color(0xFF012F64),),
                      SizedBox(width: 4,),
                      Text("4.6",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF333333)
                        ),)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              _customTile(
                onTap: (){
                  Get.to(()=> WalletScreen());
                },
                image: 'assets/icons/wallet_icon.svg',
                title: 'RADEEF Wallet'
              ),

              _customTile(
                  onTap: (){
                    Get.to(()=> TripHistoryScreen());
                  },
                  image: "assets/icons/cycle.svg",
                  title: "Trip History"),

              _customTile(
                  onTap: (){
                    Get.to(()=> ChangePasswordScreen());
                  },
                  image: "assets/icons/lock.svg",
                  title: "Change Password"),

              _customTile(
                  onTap: (){
                    Get.to(()=> AboutUsScreen());
                  },
                  image: "assets/icons/about.svg",
                  title: "About Us"),

              _customTile(
                  onTap: (){
                    Get.to(()=> SupportScreen());
                  },
                  image: "assets/icons/support.svg",
                  title: "Support"),

              _customTile(
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF)
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text("Do you have Log Out ?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF333333)
                              ),),
                            ),
                            SizedBox(height: 24,),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      Get.to(()=> SelectRoleScreen());
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE6E6E6),
                                        borderRadius: BorderRadius.circular(24)
                                      ),
                                      child: Center(
                                        child: Text("Log out",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF333333)
                                        ),),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 33,),
                                Expanded(child: CustomButton(
                                    onTap: (){
                                      Get.back();
                                    },
                                    text: "Cancel"))
                              ],
                            )
                          ],
                        ),
                      )
                    );
                  },
                  image: "assets/icons/logout.svg",
                  title: "Log Out"),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _customTile({required String image, required String title, required Function()? onTap}) {
    return ListTile(
            onTap: onTap,
              leading: SvgPicture.asset(image),
              title: Text(title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF545454)
              ),),
            );
  }
}
