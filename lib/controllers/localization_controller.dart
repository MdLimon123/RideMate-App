import 'dart:ui';

import 'package:get/get.dart';
import 'package:radeef/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;

  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(
    AppConstants.languages[0].languageCode,
    AppConstants.languages[0].countryCode,
  );
  bool _isLtr = true;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;

  void setLanguage(Locale locale) {
    _locale = locale;
    Get.updateLocale(locale); 
    _isLtr = true; 
    saveLanguage(locale);
    update();
  }

  void loadCurrentLanguage() {
    String? code = sharedPreferences.getString(AppConstants.LANGUAGE_CODE);
    String? country = sharedPreferences.getString(AppConstants.COUNTRY_CODE);

    if (code != null) {
      _locale = Locale(code, country ?? '');
      _isLtr = true;
      Get.updateLocale(_locale);
    }
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(
      AppConstants.LANGUAGE_CODE,
      locale.languageCode,
    );
    sharedPreferences.setString(
      AppConstants.COUNTRY_CODE,
      locale.countryCode ?? "",
    );
  }
}
