import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_profile_controller.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/service/prefs_helper.dart';
import 'package:radeef/utils/app_constants.dart';
import 'package:radeef/views/base/bottom_menu.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_loading.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/screen/DriverFlow/DriverProfile/AllSubScreen/driver_edit_profile.dart';
import 'package:radeef/views/screen/DriverFlow/DriverProfile/AllSubScreen/driver_wallet_screen.dart';
import 'package:radeef/views/screen/Splash/select_role_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/AllSubScreen/about_us_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/AllSubScreen/change_password_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/AllSubScreen/support_screen.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  final _driverProfileController = Get.put(DriverProfileController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _driverProfileController.fetchDriverProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _driverProfileController.isLoading.value
            ? Center(child: CustomLoading())
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF333333),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Get.to(() => DriverEditProfileScreen());
                            },
                            child: SvgPicture.asset("assets/icons/edit.svg"),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: CustomNetworkImage(
                          imageUrl:
                              "${ApiConstant.imageBaseUrl}${_driverProfileController.driverProfileModel.value.avatar}",
                          boxShape: BoxShape.circle,
                          height: 80,
                          width: 80,
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Text(
                          "${_driverProfileController.driverProfileModel.value.name}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Center(
                        child: Text(
                          "${_driverProfileController.driverProfileModel.value.email}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF87878A),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: Container(
                          width: 158,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFFE6EAF0),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/cycle.svg"),
                              SizedBox(width: 4),
                              Text(
                                "Trip",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${_driverProfileController.driverProfileModel.value.tripGivenCount}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              SizedBox(width: 20),
                              Icon(Icons.star, color: Color(0xFF012F64)),
                              SizedBox(width: 4),
                              Text(
                                "${_driverProfileController.driverProfileModel.value.rating}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      _customTile(
                        onTap: () {
                          Get.to(() => DriverWalletScreen());
                        },
                        image: 'assets/icons/wallet_icon.svg',
                        title: 'RADEEF Wallet',
                      ),

                      // _customTile(
                      //     onTap: (){
                      //       Get.to(()=> TripHistoryScreen());
                      //     },
                      //     image: "assets/icons/cycle.svg",
                      //     title: "Trip History"),
                      _customTile(
                        onTap: () {
                          Get.to(() => ChangePasswordScreen());
                        },
                        image: "assets/icons/lock.svg",
                        title: "Change Password",
                      ),

                      _customTile(
                        onTap: () {
                          Get.to(() => AboutUsScreen());
                        },
                        image: "assets/icons/about.svg",
                        title: "About Us",
                      ),

                      _customTile(
                        onTap: () {
                          Get.to(() => SupportScreen());
                        },
                        image: "assets/icons/support.svg",
                        title: "Support",
                      ),

                      _customTile(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 32,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                    child: Text(
                                      "doYouHaveLogOut".tr,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () async {
                                            await PrefsHelper.remove(
                                              AppConstants.bearerToken,
                                            );
                                            await PrefsHelper.remove("id");
                                            await PrefsHelper.remove("role");
                                            Get.to(() => SelectRoleScreen());
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            height: 52,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFE6E6E6),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "logOut".tr,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF333333),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 33),
                                      Expanded(
                                        child: CustomButton(
                                          onTap: () {
                                            Get.back();
                                          },
                                          text: "cancel".tr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        image: "assets/icons/logout.svg",
                        title: "Log Out",
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: BottomMenu(3),
    );
  }

  ListTile _customTile({
    required String image,
    required String title,
    required Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(image),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF545454),
        ),
      ),
    );
  }
}
