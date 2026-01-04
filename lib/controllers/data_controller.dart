import 'package:get/get.dart';
import 'package:radeef/utils/common_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController {
  var id = "".obs;
  var name = "".obs;
  var profileImage = "".obs;
  var email = "".obs;
  var role = "".obs;
  var isActive = false.obs;

  late SharedPreferences preferences;

  /// Get Data From Shared Preferences
  getData() async {
    preferences = await SharedPreferences.getInstance();
    id.value = preferences.getString(CommonData.id) ?? "";
    role.value = preferences.getString(CommonData.role) ?? "";
    isActive.value = preferences.getBool(CommonData.isActive) ?? false;
    name.value = preferences.getString(CommonData.name) ?? "";
  }

  setProfileData({
    required String nameD,
    required String roleD,
    required String idD,
    required bool isActiveD,
  }) async {
    // Update reactive variables

    name.value = nameD;
    role.value = roleD;
    isActive.value = isActiveD;
    id.value = idD;

    // Save to SharedPreferences
    preferences = await SharedPreferences.getInstance();

    await preferences.setString(CommonData.name, nameD);

    await preferences.setString(CommonData.role, roleD);
    await preferences.setString(CommonData.id, idD);
    await preferences.setBool(CommonData.isActive, isActiveD);
  }
}
