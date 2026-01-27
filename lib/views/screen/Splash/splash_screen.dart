import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/trip_socket_controller.dart';
import 'package:radeef/controllers/UserController/tripstate_controller.dart';
import 'package:radeef/controllers/data_controller.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/service/prefs_helper.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_login_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';
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

    final role = _dataController.role.value;
    final isActive = _dataController.isActive.value;

    print("token ======> $token");
    print("role ======> $role");
    print("active ====> $isActive");

    if (token.isEmpty) {
      Get.offAllNamed(AppRoutes.selectRole);
      return;
    } else {
      await _bootstrap(role);
    }

    // if (!isActive) {
    //   if (role == 'USER') {
    //     Get.offAll(() => UserLoginScreen());
    //   } else if (role == 'DRIVER') {
    //     Get.offAll(() => DriverLoginScreen());
    //   } else {
    //     Get.offAllNamed(AppRoutes.selectRole);
    //   }
    //   return;
    // }
    // if (role == 'USER') {
    //   Get.offAll(() => UserHomeScreen());
    // } else if (role == 'DRIVER') {
    //   Get.offAll(() => DriverHomeScreen());
    // } else {
    //   Get.offAllNamed(AppRoutes.selectRole);
    // }
  }

  Future<void> _bootstrap(String role) async {
    final isDriver = role == 'DRIVER';

    // Set user/driver role
    TripStateController.to.setRole(driver: isDriver);
    var tripSocketController = Get.put(TripSocketController(), permanent: true);

    // Init socket listener after login check
    if (isDriver) {
      tripSocketController.allDriverListeners();
    } else {
      tripSocketController.allUserListeners();
    }
    await tripSocketController.recoverTripData();

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/app_logo.png')),
    );
  }
}
