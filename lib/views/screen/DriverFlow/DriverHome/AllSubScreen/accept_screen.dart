import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/confirmation_screen.dart';
import 'trip_map_screen.dart';

class AcceptScreen extends StatefulWidget {

  final bool isParcel;

  const AcceptScreen({super.key, required this.isParcel});

  @override
  State<AcceptScreen> createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.8041, 90.4152),
    zoom: 14.4746,
  );

  bool tripStarted = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 30),
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
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                                image: const DecorationImage(
                                  image: AssetImage('assets/images/demo.png'),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                           Center(
                            child: Text(
                             "Sergio Romasis",
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
                              width: 158,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icons/cycle.svg"),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "Trip",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF333333)),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "4",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF333333)),
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFF012F64),
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    "4.6",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF333333)),
                                  )
                                ],
                              ),
                            ),
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
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        "Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown ",
                                        style:  TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/location.svg',
                                        color: AppColors.textColor),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        "Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown Pizza Burge Main St, Maintown ",
                                        style:  TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.textColor),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12,),
                                widget.isParcel ? Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/box.svg"),
                                      SizedBox(width: 12,),
                                      Text( "228",
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
                                    ]): SizedBox(),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/location.svg',
                                        color: AppColors.textColor),
                                    const SizedBox(width: 12),
                                    const Text(
                                      "28",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF012F64)),
                                    ),
                                    const SizedBox(width: 4),
                                     Text(
                                      "(XAF)",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200,
                                          color: AppColors.textColor),
                                    )
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
            const SizedBox(height: 130),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: const Color(0xFFE6EAF0)),
                    child: SvgPicture.asset('assets/icons/phone.svg'),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: const Color(0xFFE6EAF0)),
                      child: SvgPicture.asset('assets/icons/message.svg'),
                    ),
                  ),
                  const SizedBox(width: 22),
                  InkWell(
                    onTap: () {
                      Get.to(() => const TripMapScreen());
                    },
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color(0xFFE6EAF0)),
                      child: Center(
                          child: Text(
                            "Navigate",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor),
                          )),
                    ),
                  ),

                  /// Start/End Trip button

                  // Start Trip button
              widget.isParcel
                  ? InkWell(
                onTap: () async {
                  if (!tripStarted) {
                    /// Start delivery
                    tripStarted = true;
                    setState(() {});

                    /// Navigate to TripMapScreen
                    final result = await Get.to(() => const TripMapScreen());

                    /// When trip ends in TripMapScreen
                    if (result == 'tripEnded') {
                      tripStarted = false;
                      setState(() {});

                      /// Navigate to ConfirmScreen after delivery ends
                      Get.to(() =>  ConfirmationScreen(
                        isParcel: widget.isParcel,
                      ));
                    }
                  }
                },
                child: Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xFF345983),
                  ),
                  child: Center(
                    child: Text(
                      tripStarted ? "Picked Parcel" : "Deliver Parcel",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
                  : InkWell(
                onTap: () async {
                  if (!tripStarted) {
                    /// Start trip
                    tripStarted = true;
                    setState(() {});

                    /// Navigate to TripMapScreen
                    final result = await Get.to(() => const TripMapScreen());

                    /// When trip ends
                    if (result == 'tripEnded') {
                      tripStarted = false;
                      setState(() {});

                      /// Navigate to ConfirmScreen after trip ends
                      Get.to(() =>  ConfirmationScreen(
                        isParcel: widget.isParcel,
                      ));
                    }
                  }
                },
                child: Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Color(0xFF345983),
                  ),
                  child: Center(
                    child: Text(
                      tripStarted ? "End Trip" : "Start Trip",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
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
