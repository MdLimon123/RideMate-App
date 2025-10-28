import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_text_field.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/book_a_ride_screen.dart';

class ParcelDetailsScreen extends StatefulWidget {
  const ParcelDetailsScreen({super.key});

  @override
  State<ParcelDetailsScreen> createState() => _ParcelDetailsScreenState();
}

class _ParcelDetailsScreenState extends State<ParcelDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
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
              SizedBox(height: 32,),

              CustomTextField(
                hintText: "Parcels Type",
              ),
              SizedBox(height: 12,),
              CustomTextField(
                hintText: "Parcels Weight",
              ),
              SizedBox(height: 12,),
              CustomTextField(
                hintText: "Parcels Amount",
              ),

              SizedBox(height: 160,),
              CustomButton(onTap: (){
                Get.to(()=> BookARideScreen());
              },
                  text: "Confirm")
            ],
          ),
        ),
      ),
    );
  }
}
