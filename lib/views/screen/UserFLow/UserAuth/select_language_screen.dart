import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/localization_controller.dart';
import 'package:radeef/controllers/language_controller.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/utils/app_constants.dart';
import 'package:radeef/views/base/custom_appbar.dart';
import 'package:radeef/views/base/custom_button.dart';

class SelectUserLanguageScreen extends StatefulWidget {
  const SelectUserLanguageScreen({super.key});

  @override
  State<SelectUserLanguageScreen> createState() =>
      _SelectUserLanguageScreenState();
}

class _SelectUserLanguageScreenState extends State<SelectUserLanguageScreen> {
  final LanguageController _languageController = Get.put(LanguageController());

  final LocalizationController _localizationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              "choose".tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 4),
            Text(
              "select".tr,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF333333),
              ),
            ),
            SizedBox(height: 32),
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _languageController.isExpanded.toggle(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6EAF0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _languageController.selectedLanguage.value,
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(
                            _languageController.isExpanded.value
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_languageController.isExpanded.value) ...[
                    SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFE6EAF0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: _languageController.languages.map((lang) {
                          return GestureDetector(
                            onTap: () {
                              _languageController.selectLanguage(lang);
                              final selectedLangModel = AppConstants.languages
                                  .firstWhere(
                                    (language) => language.languageName == lang,
                                    orElse: () => AppConstants.languages[0],
                                  );
                              _localizationController.setLanguage(
                                Locale(
                                  selectedLangModel.languageCode,
                                  selectedLangModel.countryCode,
                                ),
                              );
                              _languageController.isExpanded.value = false;
                            },
                            child: ListTile(title: Text(lang)),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ],
              );
            }),
            SizedBox(height: 205),
            CustomButton(
              onTap: () {
                Get.offAllNamed(AppRoutes.userLoginScreen);
              },
              text: "next".tr,
            ),
          ],
        ),
      ),
    );
  }
}
