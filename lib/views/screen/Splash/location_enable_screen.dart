import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_select_language_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/select_language_screen.dart';

class LocationEnableScreen extends StatefulWidget {
  final String role;
  const LocationEnableScreen({super.key, required this.role});

  @override
  State<LocationEnableScreen> createState() => _LocationEnableScreenState();
}

class _LocationEnableScreenState extends State<LocationEnableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 164),
            Center(child: SvgPicture.asset('assets/icons/location_enable.svg')),
            SizedBox(height: 44),
            Center(
              child: Text(
                "Enable Your Location",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            SizedBox(height: 12),

            Center(
              child: Text(
                "Chose your location to start find the request around you",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF545454),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 280),

            CustomButton(
              onTap: () {
                if (widget.role == "USER") {
                  Get.to(() => SelectUserLanguageScreen());
                } else if (widget.role == "DRIVER") {
                  Get.to(() => DriverSelectUserLanguageScreen());
                }
              },
              text: "Enable Location",
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
