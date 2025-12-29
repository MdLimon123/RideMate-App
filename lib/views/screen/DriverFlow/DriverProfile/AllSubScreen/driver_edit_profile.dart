import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_profile_controller.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/views/base/custom_appbar.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class DriverEditProfileScreen extends StatefulWidget {
  const DriverEditProfileScreen({super.key});

  @override
  State<DriverEditProfileScreen> createState() =>
      _DriverEditProfileScreenState();
}

class _DriverEditProfileScreenState extends State<DriverEditProfileScreen> {
  final nameController = TextEditingController();
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
    nameController.text =
        _driverProfileController.driverProfileModel.value.name ?? "";
    return Scaffold(
      appBar: CustomAppbar(title: "Edit Profile"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Obx(
                () => _driverProfileController.driverProfileImage.value != null
                    ? Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(
                              _driverProfileController
                                  .driverProfileImage
                                  .value!,
                            ),

                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withValues(alpha: 0.30),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      )
                    : CustomNetworkImage(
                        imageUrl:
                            "${ApiConstant.baseUrl}${_driverProfileController.driverProfileModel.value.avatar}",
                        height: 110,
                        boxShape: BoxShape.circle,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withValues(alpha: 0.30),
                          BlendMode.darken,
                        ),
                        width: 110,
                      ),
              ),
              Positioned(
                bottom: 5,
                right: 145,
                child: InkWell(
                  onTap: () {
                    _driverProfileController.pickDriverProfileImage();
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF012F64),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SvgPicture.asset('assets/icons/camera.svg'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          CustomTextField(
            controller: nameController,
            hintText: "Enter full name",
          ),
          SizedBox(height: 62),
          Obx(
            () => CustomButton(
              loading: _driverProfileController.uploadProfileLoading.value,
              onTap: () {
                _driverProfileController.updateProfile(
                  imagePath:
                      _driverProfileController.driverProfileImage.value!.path,
                  name: nameController.text,
                );
              },
              text: "save".tr,
            ),
          ),
        ],
      ),
    );
  }
}
