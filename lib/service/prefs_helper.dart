import 'dart:convert';

import 'package:radeef/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getString(key) ?? "";
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(key) ?? false;
  }

  static Future<void> setToken(String bearerToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(AppConstants.bearerToken, bearerToken);
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(AppConstants.bearerToken) ?? "";
  }

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  /// Save email and password if Remember Me is checked
  static Future<void> saveRememberedCredentials({
    required String email,
    required String password,
    required bool isRemember,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isRemember', isRemember);

    if (isRemember) {
      await preferences.setString('rememberedEmail', email);
      await preferences.setString('rememberedPassword', password);
    } else {
      await preferences.remove('rememberedEmail');
      await preferences.remove('rememberedPassword');
    }
  }

  /// Get Remember Me status
  static Future<bool> getRememberMeStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isRemember') ?? false;
  }

  /// Get remembered email
  static Future<String> getRememberedEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('rememberedEmail') ?? '';
  }

  /// Get remembered password
  static Future<String> getRememberedPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('rememberedPassword') ?? '';
  }

  static Future<void> setUserInfo(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userInfo', jsonEncode(data));
  }

  static Future<Map<String, dynamic>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('userInfo');
    return data != null ? jsonDecode(data) : {};
  }
}
