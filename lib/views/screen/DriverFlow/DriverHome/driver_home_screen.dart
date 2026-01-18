import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_home_controller.dart';
import 'package:radeef/models/Driver/parcel_request_model.dart';
import 'package:radeef/models/Driver/trip_request_model.dart';
import 'package:radeef/service/notification_service.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/bottom_menu.dart';
import 'package:radeef/views/base/custom_switch.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/new_request_screen.dart';
import 'package:radeef/views/screen/Notification/notification_screen.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen>
    with TickerProviderStateMixin {
  final _driverHomeController = Get.put(DriverHomeController());

  bool isSwitch = true;
  bool _activeRequestExists = false;

  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _rotationController;

  late Animation<double> _xScale;
  late Animation<double> _yScale;
  late Animation<double> _rotation;

  @override
  void initState() {
    _driverHomeController.fetchHomeData();
    isSwitch = true;
    toggleOnlineStatus(isSwitch);
    subscribleId();

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _xScale = Tween<double>(
      begin: 0.9,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _xController, curve: Curves.easeInOut));

    _yScale = Tween<double>(
      begin: 0.9,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _yController, curve: Curves.easeInOut));

    _rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    SocketService().on('parcel:request', (data) {
      final socketModel = ParcelRequestSocketModel.fromJson(data);

      if (_activeRequestExists) return;

      if (socketModel.parcel != null) {
        _activeRequestExists = true;
        Get.to(
          () => NewRequestScreen(
            isParcel: true,
            parcel: socketModel.parcel,
            parcelUserModel: socketModel.user,
          ),
        )?.then((value) {
          _activeRequestExists = false;
        });
      }
    });

    SocketService().on('trip:request', (data) {
      final socketModel = TripRequestSocketModel.fromJson(data);

      if (_activeRequestExists) return;

      if (socketModel.trip != null) {
        _activeRequestExists = true;
        Get.to(
          () => NewRequestScreen(
            isParcel: false,
            trip: socketModel.trip,
            tripUserModel: socketModel.user,
          ),
        )?.then((value) {
          _activeRequestExists = false;
        });
      }
    });

    super.initState();
  }

  void toggleOnlineStatus(bool status) {
    SocketService().emit('driver:toggle_online', data: {'online': status});

    print('Online status ===========>: $status');
  }

  void subscribleId() async {
    await _driverHomeController.subscribleId();
    OneSignalHelper.optIn();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _rotationController.dispose();
    //SocketService().socket?.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
              child: Row(
                children: [
                  Text(
                    isSwitch ? "Online" : "Offline",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(width: 4),
                  CustomSwitch(
                    value: isSwitch,
                    onChanged: (val) {
                      setState(() {
                        isSwitch = val;
                        toggleOnlineStatus(isSwitch);
                      });
                    },
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => NotificationScreen());
                    },
                    child: SvgPicture.asset('assets/icons/notification.svg'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 500,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset("assets/images/maps.png"),

                  Positioned(
                    bottom: -60, //
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF345983),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              isSwitch
                                  ? "We’re searching a request for you!"
                                  : 'You are Now Offline',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 30),
                          isSwitch
                              ? Center(
                                  child: AnimatedBuilder(
                                    animation: Listenable.merge([
                                      _xController,
                                      _yController,
                                      _rotationController,
                                    ]),
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scaleX: _xScale.value,
                                        scaleY: _yScale.value,
                                        child: Transform.rotate(
                                          angle: _rotation.value * 6.28319,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.4),
                                                  blurRadius: 30,
                                                  spreadRadius: 4,
                                                ),
                                              ],
                                            ),
                                            child: child,
                                          ),
                                        ),
                                      );
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/search_fill.svg',
                                      color: Colors.white,
                                      width: 72,
                                      height: 72,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/happy.svg',
                                  ),
                                ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Tips",
                                      style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "Earnings",
                                      style: TextStyle(
                                        color: Color(0xFF333333),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Obx(
                                  () => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _driverHomeController
                                            .homeModel
                                            .value
                                            .totalCount
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                      Text(
                                        _driverHomeController
                                            .homeModel
                                            .value
                                            .totalTime
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                      Text(
                                        "${_driverHomeController.homeModel.value.totalEarnings} XAF",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF333333),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomMenu(0),
    );
  }
}
