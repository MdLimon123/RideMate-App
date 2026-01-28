import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/home_controller.dart';
import 'package:radeef/controllers/UserController/trip_socket_controller.dart';
import 'package:radeef/controllers/UserController/user_profile_controller.dart';
import 'package:radeef/controllers/parcel_controller.dart';

import 'package:radeef/service/api_constant.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/screen/Notification/notification_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/user_profile_screen.dart';

class ShowParcelAmountScreen extends StatefulWidget {
  final double showAmount;
  final double pickLat;
  final double pickLng;
  final double dropLat;
  final double dropLan;
  final int? weight;
  final int? amount;

  final String pickLocation;
  final String dropLocation;

  const ShowParcelAmountScreen({
    super.key,

    required this.showAmount,
    required this.pickLat,
    required this.pickLng,
    required this.dropLat,
    required this.dropLan,
    required this.pickLocation,
    required this.dropLocation,

    this.weight,
    this.amount,
  });

  @override
  State<ShowParcelAmountScreen> createState() => _ShowParcelAmountScreenState();
}

class _ShowParcelAmountScreenState extends State<ShowParcelAmountScreen> {
  final pickLocationController = TextEditingController();
  final dropLocationController = TextEditingController();
  final _userProfileController = Get.put(UserProfileController());
  final _homeController = Get.put(HomeController());
  final _tripSocketController = Get.put(TripSocketController());

  final _parcelController = Get.put(ParcelController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userProfileController.fetchUserInfo();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pickLocationController.text = widget.pickLocation;
    dropLocationController.text = widget.dropLocation;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good morning",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF545454),
                        ),
                      ),
                      SizedBox(height: 5),
                      Obx(
                        () => Text(
                          _userProfileController.userProfileModel.value.name ??
                              "",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF545454),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => NotificationScreen());
                    },
                    child: SvgPicture.asset('assets/icons/notification.svg'),
                  ),
                  SizedBox(width: 12),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        Get.to(() => UserProfileScreen());
                      },
                      child: CustomNetworkImage(
                        imageUrl:
                            "${ApiConstant.imageBaseUrl}${_userProfileController.userProfileModel.value.avatar}",
                        boxShape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1),
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      readOnly: true,
                      controller: pickLocationController,

                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset('assets/icons/pick.svg'),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE6E6E6).withValues(alpha: 0.24),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      readOnly: true,
                      controller: dropLocationController,

                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset('assets/icons/location.svg'),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE6E6E6).withValues(alpha: 0.24),
                      ),
                    ),
                    SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 75,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF345983),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          "${widget.showAmount} XAF",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 51),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              width: double.infinity,
                              height: 52,
                              decoration: BoxDecoration(
                                color: Color(0xFFE6E6E6),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              if (_userProfileController
                                      .userProfileModel
                                      .value
                                      .wallet!
                                      .balance! <
                                  widget.showAmount) {
                                Get.snackbar(
                                  "Insufficient Balance",
                                  "Please top up your wallet to proceed.",
                                  backgroundColor: Colors.redAccent,
                                  colorText: Colors.white,
                                );
                                return;
                              }
                              if (_homeController.selectedIndex.value == 0) {
                                _tripSocketController.requestForTrip({
                                  "pickup_lat": widget.pickLat,
                                  "pickup_lng": widget.pickLng,
                                  "pickup_address": widget.pickLocation,
                                  "dropoff_lat": widget.dropLat,
                                  "dropoff_lng": widget.dropLan,
                                  "dropoff_address": widget.dropLocation,
                                });
                              } else if (_homeController.selectedIndex.value ==
                                  1) {
                                _parcelController.requestForParcel({
                                  "weight": widget.weight!,
                                  "amount": widget.amount!,
                                  "pickup_lat": widget.pickLat,
                                  "pickup_lng": widget.pickLng,
                                  "pickup_address": widget.pickLocation,
                                  "dropoff_lat": widget.dropLat,
                                  "dropoff_lng": widget.dropLan,
                                  "dropoff_address": widget.dropLocation,
                                });

                               
                              }
                            },
                            text: "confirm".tr,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 74),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/what.svg'),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "needHelp".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "support".tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
