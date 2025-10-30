import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({super.key});

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.8041, 90.4152),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 30,),
            SizedBox(
              height: 500,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),

                  // Send button
                  Positioned(
                    top: 35,
                    right: 25,
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/icons/send.svg',
                          color: const Color(0xFF545454),
                        ),
                      ),
                    ),
                  ),


                  Positioned(
                    bottom: -60,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: const Color(0xFF345983),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, -3),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                             "New Ride Request",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 8,),
                          Center(
                            child: Text("5 min ETA",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF)
                            ),),
                          ),

                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/pick.svg'),
                                    SizedBox(width: 12,),
                                    Expanded(
                                      child: Text("Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textColor
                                      ),
                                      overflow: TextOverflow.ellipsis,),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12,),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/location.svg',
                                    color: AppColors.textColor,),
                                    SizedBox(width: 12,),
                                    Expanded(
                                      child: Text("Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor
                                        ),
                                        overflow: TextOverflow.ellipsis,),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12,),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/location.svg',
                                      color: AppColors.textColor,),
                                    SizedBox(width: 12,),
                                    Text( "28",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF012F64)
                                      ),
                              ),
                                    SizedBox(width: 4,),
                                    Text("(XAF)",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      color: AppColors.textColor
                                    ),)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 130,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.circular(24)
                      ),
                      child: Center(
                        child: Text("Decline",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor
                        ),),
                      ),
                    ),
                  ),
                  SizedBox(width: 22,),
                  Expanded(
                    child: CustomButton(onTap: (){},
                        text: "Accept"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
