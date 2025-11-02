import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/earing_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/bottom_menu..dart';

class DriverEarnScreen extends StatefulWidget {
  const DriverEarnScreen({super.key});

  @override
  State<DriverEarnScreen> createState() => _DriverEarnScreenState();
}

class _DriverEarnScreenState extends State<DriverEarnScreen> {

  final _earingController = Get.put(EaringController());
  final List<Map<String, dynamic>> dummyTripList = [
    {

      "isParcel": false,
      "day": "Monday",
      "total Trip": 8,
      "time": "6.5h",
      "tripFare": 220.0,


    },
    {

      "isParcel": true,
      "day": "Monday",
      "total Trip": 8,
      "time": "6.5h",
      "tripFare": 220.0,


    },
    {

      "isParcel": false,
      "day": "Monday",
      "total Trip": 8,
      "time": "6.5h",
      "tripFare": 220.0,


    },
    {

      "isParcel": false,
      "day": "Monday",
      "total Trip": 8,
      "time": "6.5h",
      "tripFare": 220.0,


    },
    {

      "isParcel": false,
      "day": "Monday",
      "total Trip": 8,
      "time": "6.5h",
      "tripFare": 220.0,


    },

  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Earnings",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor
                    ),),
                  DropdownButton<String>(
                    menuWidth: 200,
                    value: _earingController.selectedOption.value,
                    icon:
                    const SizedBox.shrink(),
                    dropdownColor: Color(0xFFFEF7F6),
                    onChanged: (String? newValue) {
                      setState(() {
                        if (newValue != null) {
                          _earingController.changeOption(newValue);
                        }
                      });
                    },
                    items: _earingController.options
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Column(
                          children: [
                            Text(
                              value,
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),

                          ],
                        ),
                      );
                    }).toList(),
                    selectedItemBuilder: (BuildContext context) {
                      return _earingController.options
                          .map<Widget>((String item) {
                        return Row(
                          spacing: 6,
                          children: [
                            if (_earingController.selectedOption.value != "All")
                              Text(
                                item,
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14
                                ),
                              ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.textColor,
                              size: 18,
                            ),
                          ],
                        );
                      }).toList();
                    },
                  ),

                ],
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Color(0xFFE6EAF0),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Total Earnings",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor
                    ),),
                    SizedBox(height: 4,),
                    Text("\$847.25",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF012F64)
                    ),)
                  ],
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/cycle.svg'),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text("Total Trips",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF545454)
                              ),),
                              SizedBox(height: 4,),
                              Text("28",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
                      decoration: BoxDecoration(
                          color: Color(0xFFE6E6E6),
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/clock.svg'),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text("Online Time",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF545454)
                                ),),
                              SizedBox(height: 4,),
                              Text("100h 20m",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor
                                ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(0xFFE6E6E6),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(dummyTripList[index]["day"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor,
                                          fontSize: 16
                                      )),
                                  SizedBox(height: 4,),
                                  Row(
                                    children: [
                                      Text("8 trips",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF87878A)
                                        ),),
                                      SizedBox(width: 4,),
                                      Container(
                                        width: 1,
                                        height: 1,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF87878A)
                                        ),
                                      ),
                                      SizedBox(width: 4,),
                                      Text("6.5h",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF87878A)
                                        ),),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text("\$147.80",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF012F64)
                                ),)
                            ],
                          ),
                        );

                      },
                      separatorBuilder: (_,_)=> SizedBox(height: 8,),
                      itemCount: dummyTripList.length)
              )
            ],
          ),
        ),
      ),
     bottomNavigationBar: BottomMenu(2),
    );
  }
}
