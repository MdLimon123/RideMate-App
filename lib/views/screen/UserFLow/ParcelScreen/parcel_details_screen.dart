import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/home_controller.dart';
import 'package:radeef/controllers/UserController/user_profile_controller.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_dropdown.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/base/custom_text_field.dart';
import 'package:radeef/views/screen/Notification/notification_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/book_a_ride_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/user_profile_screen.dart';

class ParcelDetailsScreen extends StatefulWidget {
  const ParcelDetailsScreen({super.key});

  @override
  State<ParcelDetailsScreen> createState() => _ParcelDetailsScreenState();
}

class _ParcelDetailsScreenState extends State<ParcelDetailsScreen> {
  final _userProfileController = Get.put(UserProfileController());

  final _homeController = Get.put(HomeController());

  @override
  void initState() {
    _userProfileController.fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                        border: Border.all(color: Colors.grey),
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => CustomDropdown(
                          title: "Parcel Type",
                          options: _homeController.parcelType.toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _homeController.selectedParcelType.value = value;
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 12),
                      CustomTextField(
                        hintText: "Parcels Weight",
                        keyboardType: TextInputType.number,
                        controller: _homeController.parcelWeightController,
                      ),
                      SizedBox(height: 12),
                      CustomTextField(
                        hintText: "Parcels Amount",
                        keyboardType: TextInputType.number,
                        controller: _homeController.parcelAmount,
                      ),

                      SizedBox(height: 160),
                      CustomButton(
                        onTap: () {
                          Get.to(() => BookARideScreen());
                        },
                        text: "confirm".tr,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
