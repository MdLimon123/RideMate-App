import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_profile_setup_controller.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_dropdown.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class DriverPersonalInfoScreen extends StatefulWidget {
  const DriverPersonalInfoScreen({super.key});

  @override
  State<DriverPersonalInfoScreen> createState() =>
      _DriverPersonalInfoScreenState();
}

class _DriverPersonalInfoScreenState extends State<DriverPersonalInfoScreen> {
  final _driverSetupController = Get.put(DriverProfileSetupController());
  final nameController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.arrow_back_ios, color: Color(0xFF676769)),
            Text(
              "2 Of 4",
              style: TextStyle(
                color: Color(0xFF012F64),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Obx(
                () => Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image:
                          _driverSetupController.driverProfileImage.value !=
                              null
                          ? FileImage(
                              _driverSetupController.driverProfileImage.value!,
                            )
                          : AssetImage('assets/images/demo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 130,
                child: InkWell(
                  onTap: () {
                    _driverSetupController.pickDriverImage();
                  },
                  child: Container(
                    height: 34,
                    width: 34,
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
            hintText: "Enter Full Name",
            controller: nameController,
          ),
          SizedBox(height: 12),
          CustomTextField(
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime(2006, 1, 1),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (pickedDate != null) {
                
                String formattedDate =
                    "${pickedDate.year.toString().padLeft(4, '0')}-"
                    "${pickedDate.month.toString().padLeft(2, '0')}-"
                    "${pickedDate.day.toString().padLeft(2, '0')}";

                dateOfBirthController.text = formattedDate;
              }
            },
            hintText: "Date Of birth",
            controller: dateOfBirthController,
          ),
          SizedBox(height: 12),
          CustomDropdown(
            title: "Gender",
            options: _driverSetupController.genderMap.values.toList(),
            onChanged: (val) {
              _driverSetupController.selectedGender.value = val!;
            },
          ),
          SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xFFE6E6E6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "National ID / Passport",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF545454),
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upload (Front Side)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF545454),
                            ),
                          ),

                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                final image =
                                    _driverSetupController.nIdfrontImage.value;
                                return InkWell(
                                  onTap: () {
                                    _driverSetupController.pickNIDFrontImage();
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: image != null
                                            ? const Color(0xFF11DF7F)
                                            : const Color(0xFF012F64),
                                        width: 0.5,
                                      ),
                                      color: image == null
                                          ? const Color(0xFFE6E6E6)
                                          : null,
                                    ),
                                    child: image != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            child: Image.file(
                                              image,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : null,
                                  ),
                                );
                              }),

                              Obx(() {
                                return _driverSetupController
                                            .nIdfrontImage
                                            .value ==
                                        null
                                    ? Positioned(
                                        child: InkWell(
                                          onTap: () {
                                            _driverSetupController
                                                .pickNIDFrontImage();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/camera.svg',
                                              color: const Color(0xFF012F64),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Uplaod (Back Side)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF545454),
                            ),
                          ),

                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                final image =
                                    _driverSetupController.nIdbackImage.value;
                                return InkWell(
                                  onTap: () {
                                    _driverSetupController.pickNIDBackImage();
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: image != null
                                            ? const Color(0xFF11DF7F)
                                            : const Color(0xFF012F64),
                                        width: 0.5,
                                      ),
                                      color: image == null
                                          ? const Color(0xFFE6E6E6)
                                          : null,
                                    ),
                                    child: image != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            child: Image.file(
                                              image,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : null,
                                  ),
                                );
                              }),

                              Obx(() {
                                return _driverSetupController
                                            .nIdbackImage
                                            .value ==
                                        null
                                    ? Positioned(
                                        child: InkWell(
                                          onTap: () {
                                            _driverSetupController
                                                .pickNIDBackImage();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/camera.svg',
                                              color: const Color(0xFF012F64),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xFFE6E6E6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Driving License (Optional)",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF545454),
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upload (Front Side)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF545454),
                            ),
                          ),

                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                final image =
                                    _driverSetupController.frontImage.value;
                                return InkWell(
                                  onTap: () {
                                    _driverSetupController.pickFrontImage();
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: image != null
                                            ? const Color(0xFF11DF7F)
                                            : const Color(0xFF012F64),
                                        width: 0.5,
                                      ),
                                      color: image == null
                                          ? const Color(0xFFE6E6E6)
                                          : null,
                                    ),
                                    child: image != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            child: Image.file(
                                              image,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : null,
                                  ),
                                );
                              }),

                              Obx(() {
                                return _driverSetupController
                                            .frontImage
                                            .value ==
                                        null
                                    ? Positioned(
                                        child: InkWell(
                                          onTap: () {
                                            _driverSetupController
                                                .pickFrontImage();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/camera.svg',
                                              color: const Color(0xFF012F64),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upload (Back Side)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF545454),
                            ),
                          ),

                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() {
                                final image =
                                    _driverSetupController.backImage.value;
                                return InkWell(
                                  onTap: () {
                                    _driverSetupController.pickBackImage();
                                  },
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: image != null
                                            ? const Color(0xFF11DF7F)
                                            : const Color(0xFF012F64),
                                        width: 0.5,
                                      ),
                                      color: image == null
                                          ? const Color(0xFFE6E6E6)
                                          : null,
                                    ),
                                    child: image != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                            child: Image.file(
                                              image,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : null,
                                  ),
                                );
                              }),

                              Obx(() {
                                return _driverSetupController.backImage.value ==
                                        null
                                    ? Positioned(
                                        child: InkWell(
                                          onTap: () {
                                            _driverSetupController
                                                .pickBackImage();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: SvgPicture.asset(
                                              'assets/icons/camera.svg',
                                              color: const Color(0xFF012F64),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 40),
          Obx(
            () => CustomButton(
              loading: _driverSetupController.isLoading.value,
              onTap: () {
                _driverSetupController.setupUserProfile(
                  avatar: _driverSetupController.driverProfileImage.value!.path,
                  drivingLicenseFront:
                      _driverSetupController.frontImage.value!.path,
                  drivingLicenseBack:
                      _driverSetupController.backImage.value!.path,
                  nIdFornt: _driverSetupController.nIdfrontImage.value!.path,
                  nIdBack: _driverSetupController.nIdbackImage.value!.path,
                  name: nameController.text,
                  dateOfBirth: dateOfBirthController.text,
                  gender: _driverSetupController.selectedGender.value,
                );
              },
              text: "Save Now",
            ),
          ),
        ],
      ),
    );
  }
}
