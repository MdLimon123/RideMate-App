import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/user_setup_profile_controller.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_dropdown.dart';
import 'package:radeef/views/base/custom_text_field.dart';

class SetupPersonalInfoScreen extends StatefulWidget {
  const SetupPersonalInfoScreen({super.key});

  @override
  State<SetupPersonalInfoScreen> createState() =>
      _SetupPersonalInfoScreenState();
}

class _SetupPersonalInfoScreenState extends State<SetupPersonalInfoScreen> {
  final _userSetupProfileController = Get.put(UserSetupProfileController());
  final nameTextController = TextEditingController();
  final dateOfBirthTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "2 Of 4",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF012F64),
                ),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(
                    () =>
                        _userSetupProfileController.userProfileImage.value !=
                            null
                        ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: Image.file(
                                _userSetupProfileController
                                    .userProfileImage
                                    .value!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                  ),
                  Positioned(
                    right: 1,
                    bottom: 4,
                    child: InkWell(
                      onTap: () {
                        _userSetupProfileController.pickCoachImage();
                      },
                      child: Container(
                        height: 28,
                        width: 28,
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
            ),
            SizedBox(height: 24),

            CustomTextField(
              controller: nameTextController,
              hintText: "Enter Full Name",
            ),
            SizedBox(height: 12),
            CustomTextField(
              controller: dateOfBirthTextController,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icons/calender.svg"),
              ),
              hintText: "Date Of birth",
            ),
            SizedBox(height: 12),
            CustomDropdown(
              title: "Gender",
              options: _userSetupProfileController.genderMap.values.toList(),
              onChanged: (val) {
                _userSetupProfileController.selectedGender.value = val!;
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
                              "Upload (Front Part)",
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
                                  final image = _userSetupProfileController
                                      .frontImage
                                      .value;
                                  return Container(
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
                                  );
                                }),

                                Obx(() {
                                  return _userSetupProfileController
                                              .frontImage
                                              .value ==
                                          null
                                      ? Positioned(
                                          child: InkWell(
                                            onTap: () {
                                              _userSetupProfileController
                                                  .pickFrontImage();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                5.0,
                                              ),
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
                              "Upload (Back Part)",
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
                                  final image = _userSetupProfileController
                                      .backImage
                                      .value;
                                  return Container(
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
                                  );
                                }),

                                Obx(() {
                                  return _userSetupProfileController
                                              .backImage
                                              .value ==
                                          null
                                      ? Positioned(
                                          child: InkWell(
                                            onTap: () {
                                              _userSetupProfileController
                                                  .pickBackImage();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                5.0,
                                              ),
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
            SizedBox(height: 62),
            Obx(
              () => CustomButton(
                loading: _userSetupProfileController.isLoading.value,
                onTap: () {
                  _userSetupProfileController.setupUserProfile(
                    avatar: _userSetupProfileController
                        .userProfileImage
                        .value!
                        .path,
                    nIdFornt:
                        _userSetupProfileController.frontImage.value!.path,
                    nIdBack: _userSetupProfileController.backImage.value!.path,
                    name: nameTextController.text.trim(),
                    dateOfBirth: dateOfBirthTextController.text.trim(),
                    gender: _userSetupProfileController.selectedGender.value,
                  );
                },
                text: "Confrim".tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
