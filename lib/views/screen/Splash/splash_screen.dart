import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/data_controller.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/service/prefs_helper.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_login_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';
import 'package:radeef/views/screen/Splash/select_role_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/user_login_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/user_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _dataController = Get.put(DataController());

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      _checkLogin();
    });

    super.initState();
  }

  void _checkLogin() async {
    await _dataController.getData();

    final token = await PrefsHelper.getToken();

    print("role ==============> ${_dataController.role.value}");
    print("active ==============> ${_dataController.isActive.value}");

    if (token != null && token.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_dataController.isActive.value) {
          if (_dataController.role.value == 'USER') {
            Get.offAll(() => UserHomeScreen());
          } else if (_dataController.role.value == 'DRIVER') {
            Get.offAll(() => DriverHomeScreen());
          } else {
            Get.offAll(() => SelectRoleScreen());
          }
        } else {
          if (_dataController.role.value == "USER") {
            Get.offAll(() => UserLoginScreen());
          } else if (_dataController.role.value == 'DRIVER') {
            Get.offAll(() => DriverLoginScreen());
          }
        }
      });
    } else {
      Get.offAllNamed(AppRoutes.selectRole);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/app_logo.png')),
    );
  }
}
