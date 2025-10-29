import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radeef/views/base/custom_appbar.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {

  String selectedValue = 'This Week';

  final List<String> options = ['This Week', 'This Month', 'This Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Trip History",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 23),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ride History",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333)
                ),),

                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    icon: const Icon(Icons.arrow_drop_down,
                    color: Color(0xFF333333),),
                    style: const TextStyle(   fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333)),
                    items: options.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF333333)
                        ),),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                  ),
                )

              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index){
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 13),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6EAF0),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Monday",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF333333)
                          ),),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/pick.svg'),
                              SizedBox(width: 12,),
                              Text("Pizza Burge Main St, Maintown ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF8A8A8A)
                              ),),
                              SizedBox(width: 30,),
                              Text("47.80 XAF",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF012F64)
                              ),)
                            ],
                          ),
                          SizedBox(height: 4,),
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/location.svg'),
                              SizedBox(width: 12,),
                              Text("456 Oak Ave, Sometown (7.00 km)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF8A8A8A)
                              ),)
                            ],
                          )
                        ],
                      ),
                    );
                  },

                  separatorBuilder: (context, index)=> SizedBox(height: 8,),
                  itemCount: 5),
            )
          ],
        ),
      ),
    );
  }
}
