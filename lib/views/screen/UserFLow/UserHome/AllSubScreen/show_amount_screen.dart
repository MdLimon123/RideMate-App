import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radeef/views/base/custom_button.dart';

class ShowAmountScreen extends StatefulWidget {
  const ShowAmountScreen({super.key});

  @override
  State<ShowAmountScreen> createState() => _ShowAmountScreenState();
}

class _ShowAmountScreenState extends State<ShowAmountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:Column(
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
                        borderSide: BorderSide(color: Color(0xFFB5F5D7))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Color(0xFFB5F5D7))
                      ),
                    filled: true,
                    fillColor: Color(0xFFE6E6E6).withValues(alpha: 0.24)

                ),
              ),
              SizedBox(height: 32,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 75),
                decoration: BoxDecoration(
                  color: Color(0xFF345983),
                  borderRadius: BorderRadius.circular(24)
                ),
                child: Center(
                  child: Text("28 XAF",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),),
                ),
              ),
              SizedBox(height: 51,),
              Row(
                children: [
                 Expanded(child:  Container(
                   width: double.infinity,
                   height: 52,
                   decoration: BoxDecoration(
                       color: Color(0xFFE6E6E6),
                       borderRadius: BorderRadius.circular(24)
                   ),
                   child: Center(
                     child: Text("Cancel",
                       style: TextStyle(
                           fontWeight: FontWeight.w500,
                           color: Color(0xFF333333),
                           fontSize: 16
                       ),),
                   ),
                 )),
                  SizedBox(width: 12,),
                  Expanded(
                    child: CustomButton(onTap: (){},
                        text: "Confirm"),
                  )
                ],
              ),
              SizedBox(height: 74,),
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
