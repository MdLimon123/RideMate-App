import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/bottom_menu..dart';
import 'package:radeef/views/base/custom_switch.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/new_request_screen.dart';
import 'package:radeef/views/screen/Notification/notification_screen.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> with TickerProviderStateMixin{

  bool isSwitch = true;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.8041, 90.4152),
    zoom: 14.4746,
  );

  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _rotationController;

  late Animation<double> _xScale;
  late Animation<double> _yScale;
  late Animation<double> _rotation;

  @override
  void initState() {
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    /// Y-axis scale (faster 1s)
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    /// Rotation (slow, continuous)
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _xScale = Tween<double>(begin: 0.9, end: 1.15).animate(
      CurvedAnimation(parent: _xController, curve: Curves.easeInOut),
    );

    _yScale = Tween<double>(begin: 0.9, end: 1.15).animate(
      CurvedAnimation(parent: _yController, curve: Curves.easeInOut),
    );

    _rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );



    /// 🕐 Simulate searching for a driver (e.g., 5 seconds)
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
       // Get.to(()=> NewRequestScreen());
      }
    });

    super.initState();
  }


  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
              child: Row(
                children: [
                  Text( isSwitch ?"Online": "Offline",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textColor
                  ),),
                  SizedBox(width: 4,),
                  CustomSwitch(
                      value: isSwitch,
                      onChanged: (val){
                        setState(() {
                          isSwitch = val;
                        });
                      }),
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Get.to(()=> NotificationScreen());
                    },
                      child: SvgPicture.asset('assets/icons/notification.svg')),
                ],
              ),
            ),
            SizedBox(height: 20,),
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
                    bottom: -60, //
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
                             isSwitch?"We're searching a request for you!": 'You are now Offline',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 30),
                         isSwitch? Center(
                           child: AnimatedBuilder(
                             animation: Listenable.merge(
                                 [_xController, _yController, _rotationController]),
                             builder: (context, child) {
                               return Transform.scale(
                                 scaleX: _xScale.value,
                                 scaleY: _yScale.value,
                                 child: Transform.rotate(
                                   angle: _rotation.value * 6.28319, // 2π radians
                                   child: Container(
                                     decoration: BoxDecoration(
                                       boxShadow: [
                                         BoxShadow(
                                           color: Colors.white.withOpacity(0.4),
                                           blurRadius: 30,
                                           spreadRadius: 4,
                                         ),
                                       ],
                                     ),
                                     child: child,
                                   ),
                                 ),
                               );
                             },
                             child: SvgPicture.asset(
                               'assets/icons/search_fill.svg',
                               color: Colors.white,
                               width: 72,
                               height: 72,
                             ),
                           ),
                         ):  Center(
                            child: SvgPicture.asset('assets/icons/happy.svg'),
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Tips",
                                        style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    Text("Online",
                                        style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    Text("Earnings",
                                        style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("14",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF333333))),
                                    Text("3h 45m",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF333333))),
                                    Text("128.50 XAF",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF333333))),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(0),
    );
  }
}
