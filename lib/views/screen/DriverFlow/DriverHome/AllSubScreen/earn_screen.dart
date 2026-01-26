import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/models/Driver/parcel_request_model.dart';
import 'package:radeef/models/Driver/trip_request_model.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';

class EarnScreen extends StatefulWidget {
  final double amount;
  final double vat; 

  const EarnScreen({
    super.key,
    required this.amount,
    required this.vat,  
  });

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            SizedBox(height: 154),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: const Color(0xFF345983),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Your earn of this trip",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 187,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "${widget.amount} (XAF)",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF012F64),
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Radeef ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      SizedBox(width: 6),
                      SvgPicture.asset("assets/icons/percentige.svg"),
                      SizedBox(width: 4),
                     
                      Text(
                        "(XAF)",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 108),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: CustomButton(
                onTap: () {
                  Get.to(() => DriverHomeScreen());
                },
                text: "Close",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
