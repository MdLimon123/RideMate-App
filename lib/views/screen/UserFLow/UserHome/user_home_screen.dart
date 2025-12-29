import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/home_controller.dart';
import 'package:radeef/controllers/UserController/user_profile_controller.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/screen/Notification/notification_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/book_a_ride_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/parcel_details_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/user_profile_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int selectedIndex = 0;

  final _userProfileController = Get.put(UserProfileController());
  final _homeController = Get.put(HomeController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userProfileController.fetchUserInfo();
      _homeController.loadRecentDestinations();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        readOnly: true,
                        onTap: () {},
                        decoration: InputDecoration(
                          hint: Text(
                            "Where do you want to got?",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF545454),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset('assets/icons/search.svg'),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFE6E6E6),
                        ),
                      ),
                      SizedBox(height: 28),

                      // Row(
                      //   children: [
                      //     /// Book a Ride Button
                      //     Expanded(
                      //       child: InkWell(
                      //         onTap: () {
                      //           setState(() {
                      //             selectedIndex = 0;
                      //           });
                      //           Get.to(() => BookARideScreen());
                      //         },
                      //         child: Container(
                      //           width: double.infinity,
                      //           height: 64,
                      //           decoration: BoxDecoration(
                      //             color: selectedIndex == 0
                      //                 ? const Color(0xFF345983)
                      //                 : const Color(0xFFE6E6E6),
                      //             borderRadius: BorderRadius.circular(12),
                      //           ),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               SvgPicture.asset(
                      //                 'assets/icons/bike.svg',
                      //                 color: selectedIndex == 0
                      //                     ? Colors.white
                      //                     : const Color(0xFF333333),
                      //               ),
                      //               const SizedBox(width: 10),
                      //               Text(
                      //                 "bookRide".tr,
                      //                 style: TextStyle(
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: selectedIndex == 0
                      //                       ? Colors.white
                      //                       : const Color(0xFF333333),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 20),

                      //     /// Send Parcel Button
                      //     Expanded(
                      //       child: InkWell(
                      //         onTap: () {
                      //           setState(() {
                      //             selectedIndex = 1;
                      //           });
                      //           Get.to(() => ParcelDetailsScreen());
                      //         },
                      //         child: Container(
                      //           width: double.infinity,
                      //           height: 64,
                      //           decoration: BoxDecoration(
                      //             color: selectedIndex == 1
                      //                 ? const Color(0xFF345983)
                      //                 : const Color(0xFFE6E6E6),
                      //             borderRadius: BorderRadius.circular(12),
                      //           ),
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               SvgPicture.asset(
                      //                 'assets/icons/box.svg',
                      //                 color: selectedIndex == 1
                      //                     ? Colors.white
                      //                     : const Color(0xFF333333),
                      //               ),
                      //               const SizedBox(width: 10),
                      //               Text(
                      //                 "sendParcel".tr,
                      //                 style: TextStyle(
                      //                   fontSize: 18,
                      //                   fontWeight: FontWeight.w500,
                      //                   color: selectedIndex == 1
                      //                       ? Colors.white
                      //                       : const Color(0xFF333333),
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: 28),
                      // Text(
                      //   "recentDestination".tr,
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: 24,
                      //     color: Color(0xFF545454),
                      //   ),
                      // ),
                      // SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _homeController.updateSelectedIndex(
                                  0,
                                ); // Update index to 0 for Book a Ride
                                Get.to(() => BookARideScreen());
                              },
                              child: Container(
                                width: double.infinity,
                                height: 64,
                                decoration: BoxDecoration(
                                  color:
                                      _homeController.selectedIndex.value == 0
                                      ? const Color(0xFF345983)
                                      : const Color(0xFFE6E6E6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/bike.svg',
                                      color:
                                          _homeController.selectedIndex.value ==
                                              0
                                          ? Colors.white
                                          : const Color(0xFF333333),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "bookRide".tr,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            _homeController
                                                    .selectedIndex
                                                    .value ==
                                                0
                                            ? Colors.white
                                            : const Color(0xFF333333),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),

                          // Send Parcel Button
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                _homeController.updateSelectedIndex(
                                  1,
                                ); // Update index to 1 for Send Parcel
                                Get.to(() => ParcelDetailsScreen());
                              },
                              child: Container(
                                width: double.infinity,
                                height: 64,
                                decoration: BoxDecoration(
                                  color:
                                      _homeController.selectedIndex.value == 1
                                      ? const Color(0xFF345983)
                                      : const Color(0xFFE6E6E6),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/box.svg',
                                      color:
                                          _homeController.selectedIndex.value ==
                                              1
                                          ? Colors.white
                                          : const Color(0xFF333333),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "sendParcel".tr,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            _homeController
                                                    .selectedIndex
                                                    .value ==
                                                1
                                            ? Colors.white
                                            : const Color(0xFF333333),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _homeController.recentDestinations.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 6),
                          itemBuilder: (context, index) {
                            final dest =
                                _homeController.recentDestinations[index];

                            return InkWell(
                              onTap: () {
                                _homeController.dropController.text =
                                    dest.address;
                                _homeController.dropAddress.value =
                                    dest.address;
                                _homeController.dropCoordinates.value = [
                                  dest.lat,
                                  dest.lng,
                                ];
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFE6E6E6,
                                  ).withValues(alpha: 0.24),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/location.svg',
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        dest.address,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF8A8A8A),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // ListView.separated(
                      //   separatorBuilder: (_, _) => SizedBox(height: 6),
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemCount: 5,
                      //   itemBuilder: (context, index) {
                      //     return Container(
                      //       width: double.infinity,
                      //       padding: EdgeInsets.all(10),
                      //       decoration: BoxDecoration(
                      //         color: Color(0xFFE6E6E6).withValues(alpha: 0.24),
                      //         borderRadius: BorderRadius.circular(12),
                      //       ),
                      //       child: Row(
                      //         children: [
                      //           SvgPicture.asset('assets/icons/location.svg'),
                      //           SizedBox(width: 12),
                      //           Text(
                      //             "2972 Westchester Rd. Santa ",
                      //             style: TextStyle(
                      //               fontSize: 14,
                      //               fontWeight: FontWeight.w400,
                      //               color: Color(0xFF8A8A8A),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      SizedBox(height: 129),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
