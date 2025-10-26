import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/show_amount_screen.dart';

class BookARideScreen extends StatefulWidget {
  const BookARideScreen({super.key});

  @override
  State<BookARideScreen> createState() => _BookARideScreenState();
}

class _BookARideScreenState extends State<BookARideScreen> {
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
              TextFormField(

                onTap: (){},
                decoration: InputDecoration(
                    hint: Text("Aqua Tower, Mohakhali",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF676769)
                      ),),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/icons/pick.svg'),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFB5F5D7))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFB5F5D7))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFB5F5D7))),
                    filled: true,
                    fillColor: Color(0xFFE6E6E6).withValues(alpha: 0.24)

                ),
              ),
              SizedBox(height: 12,),
              TextFormField(

                onTap: (){},
                decoration: InputDecoration(
                    hint: Text("Aqua Tower, Mohakhali",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF676769)
                      ),),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/icons/location.svg'),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFB5F5D7))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFB5F5D7))),
                    filled: true,
                    fillColor: Color(0xFFE6E6E6).withValues(alpha: 0.24)

                ),
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
              SizedBox(height: 57,),
              CustomButton(
                color: Color(0xFF345983),
                  onTap: (){
                  Get.to(()=> ShowAmountScreen());
                  },
                  text: "Confirm"),
              SizedBox(height: 90,),
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
