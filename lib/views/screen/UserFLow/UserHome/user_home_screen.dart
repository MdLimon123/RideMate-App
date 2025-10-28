import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/book_a_ride_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/parcel_details_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/user_profile_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Good morning",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF545454)
                      ),),
                      SizedBox(height: 5,),
                      Text("Alex",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF545454)
                      ),)
                    ],
                  ),
                  Spacer(),
                  SvgPicture.asset('assets/icons/notification.svg'),
                  SizedBox(width: 12,),
                  InkWell(
                    onTap: (){
                      Get.to(()=> UserProfileScreen());
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage('assets/images/demo.png',),
                        fit: BoxFit.cover)
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 24,),
              TextFormField(
                readOnly: true,
                onTap: (){},
                decoration: InputDecoration(
                  hint: Text("Where do you want to got?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF545454)
                  ),),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/icons/search.svg'),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color(0xFFE6E6E6)

                ),
              ),
              SizedBox(height: 28,),
              Row(
                children: [
                  /// Book a Ride Button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                        Get.to(()=> BookARideScreen());
                      },
                      child: Container(
                        width: double.infinity,
                        height: 64,
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? const Color(0xFF345983)
                              : const Color(0xFFE6E6E6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/bike.svg',
                                color: selectedIndex == 0
                                    ? Colors.white
                                    : const Color(0xFF333333)),
                            const SizedBox(width: 10),
                            Text(
                              "Book a Ride",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: selectedIndex == 0
                                    ? Colors.white
                                    : const Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Send Parcel Button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });
                        Get.to(()=> ParcelDetailsScreen());
                      },
                      child: Container(
                        width: double.infinity,
                        height: 64,
                        decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? const Color(0xFF345983)
                              : const Color(0xFFE6E6E6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/icons/box.svg',
                                color: selectedIndex == 1
                                    ? Colors.white
                                    : const Color(0xFF333333)),
                            const SizedBox(width: 10),
                            Text(
                              "Send Parcel",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: selectedIndex == 1
                                    ? Colors.white
                                    : const Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28,),
              Text("Recent Destination",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Color(0xFF545454)
              ),),
              SizedBox(height: 12,),
              ListView.separated(
                separatorBuilder: (_, _)=> SizedBox(height: 6,),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index){
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6).withValues(alpha: 0.24),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/icons/location.svg'),
                        SizedBox(width: 12,),
                        Text("2972 Westheimer Rd. Santa ",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF8A8A8A)
                          ),)
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 129,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFE6E6E6),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(

                  children: [
                    SvgPicture.asset('assets/icons/what.svg'),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Need Help?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333)
                        ),),
                        SizedBox(height: 10,),
                        Text("Chat with our support",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333)
                        ),)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
