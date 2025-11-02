import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_rider_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/bottom_menu..dart';
import 'package:radeef/views/screen/DriverFlow/DriverRides/driver_rider_details_screen.dart';

class DriverRidersScreen extends StatefulWidget {
  const DriverRidersScreen({super.key});

  @override
  State<DriverRidersScreen> createState() => _DriverRidersScreenState();
}

class _DriverRidersScreenState extends State<DriverRidersScreen> {

  final _driverRiderController = Get.put(DriverRiderController());

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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
          child: Column(

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Ride History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor
                  ),),
                DropdownButton<String>(
                  menuWidth: 200,
                  value: _driverRiderController.selectedOption.value,
                  icon:
                  const SizedBox.shrink(),
                  dropdownColor: Color(0xFFFEF7F6),
                  onChanged: (String? newValue) {
                    setState(() {
                      if (newValue != null) {
                        _driverRiderController.changeOption(newValue);
                      }
                    });
                  },
                  items: _driverRiderController.options
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
                    return _driverRiderController.options
                        .map<Widget>((String item) {
                      return Row(
                        spacing: 6,
                        children: [
                          if (_driverRiderController.selectedOption.value != "All")
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
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          Get.to(()=> DriverRiderDetailsScreen(
                            isParcel: dummyTripList[index]["isParcel"],
                          ));
                        },
                        child: Container(
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
      bottomNavigationBar: BottomMenu(1),
    );
  }
}
