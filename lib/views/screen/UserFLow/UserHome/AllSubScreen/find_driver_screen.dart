import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/need_help_screen.dart';

class FindDriverScreen extends StatefulWidget {
  const FindDriverScreen({super.key});

  @override
  State<FindDriverScreen> createState() => _FindDriverScreenState();
}

class _FindDriverScreenState extends State<FindDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage('assets/images/demo.png',),
                            fit: BoxFit.cover)
                    ),
                  )
                ],
              ),
              SizedBox(height: 24,),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Color(0xFF345983)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xFFFFFFFF)),
                                image: DecorationImage(image: AssetImage('assets/images/demo.png'))
                              ),

                            ),
                          ),
                          SizedBox(height: 12,),
                          Center(
                            child: Text("Sergio Romasis",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFFFFFF)
                            ),),
                          ),
                          SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Hero Honda 100 cc /",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF)
                              ),),
                              SizedBox(width: 8,),
                              Text("2 min away",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF)
                              ),)
                            ],
                          ),
                          SizedBox(height: 16,),
                          Center(
                            child: Container(
                              width: 158,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
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
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(16)
                            
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/pick.svg'),
                                    SizedBox(width: 12,),
                                    Text("Pizza Burge Main St, Maintown ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF333333)
                                    ),)
                                  ],
                                ),
                                SizedBox(height: 12,),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/location.svg'),
                                    SizedBox(width: 12,),
                                    Text("456 Oak Ave, Sometown (7.00 km)",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF333333)
                                      ),)
                                  ],
                                ),
                                SizedBox(height: 12,),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/dollar.svg'),
                                    SizedBox(width: 12,),
                                    Text("20",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF333333)
                                      ),),
                                    SizedBox(width: 4,),
                                    Text("(XAF)",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      color:Color(0xFF333333),
                                      fontStyle: FontStyle.italic
                                    ),)
                                  ],
                                ),

                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 17,),
                    TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:  BorderSide.none
                          ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset('assets/icons/copy.svg'),
                            ),
                          fillColor: Color(0xFFE6EAF0),
                          filled: true,
                          hint: Text('dsfgjhsdokj3jejfkld fdjfk',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF333333)
                          ),)
                        ),
                    ),
                    SizedBox(height: 98,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE6EAF0)
                          ),
                          child: SvgPicture.asset('assets/icons/phone.svg'),
                        ),
                        SizedBox(width: 16,),
                        InkWell(
                          onTap: (){
                            Get.to(()=> NeedHelpScreen());
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFE6EAF0)
                            ),
                            child: SvgPicture.asset('assets/icons/message.svg'),
                          ),
                        ),
                        SizedBox(width: 22,),
                        Container(
                          height: 46,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                              color: Color(0xFFE6EAF0)
                          ),
                          child: Text("Track diver"),
                        ),
                        Container(
                          height: 46,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Color(0xFFE6EAF0)
                          ),
                          child: Text("Pay Now"),
                        ),
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
