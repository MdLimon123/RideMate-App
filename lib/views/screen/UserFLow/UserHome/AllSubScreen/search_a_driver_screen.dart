import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/user_profile_controller.dart';
import 'package:radeef/models/User/driver_model.dart';
import 'package:radeef/models/User/parcel_response_model.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/screen/Notification/notification_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/find_driver_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/find_parcel_driver_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/user_profile_screen.dart';

class SearchADriverScreen extends StatefulWidget {
  final String pickLocation;
  final String dropLocation;
  final String? parcelId;
  final String? tripId;

  const SearchADriverScreen({
    super.key,
    required this.pickLocation,
    required this.dropLocation,
    this.parcelId,
    this.tripId,
  });

  @override
  State<SearchADriverScreen> createState() => _SearchADriverScreenState();
}

class _SearchADriverScreenState extends State<SearchADriverScreen>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _rotationController;

  late Animation<double> _xScale;
  late Animation<double> _yScale;
  late Animation<double> _rotation;

  final pickLocationController = TextEditingController();
  final dropLocationController = TextEditingController();

  final _userProfileController = Get.put(UserProfileController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _userProfileController.fetchUserInfo();
    });

    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    /// Y-axis scale (faster 1s)
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    /// Rotation (slow, continuous)
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

    debugPrint('📌 SearchADriverScreen opened');
    debugPrint('🔌 Socket connected? => ${SocketService().isConnected}');

    if (!SocketService().isConnected) {
      debugPrint('⚠️ Socket NOT connected yet');
    } else {
      debugPrint('🟢 Socket already connected');
    }

    // Handling 'trip:accepted' event
    SocketService().on('trip:accepted', (data) {
      if (!mounted) return;

      final driver = DriverModel.fromJson(data['driver']);
      final trip = TripModel.fromJson(data['trip']);

      // Navigate to FindDriverScreen
      Get.off(() => FindDriverScreen(driver: driver, trip: trip));
    });

    // Handling 'parcel:accepted' event
    SocketService().on('parcel:accepted', (data) {
      if (!mounted) return;
      final parcelDriverModel = ParcelDriverModel.fromJson(data['driver']);
      final parcel = ParcelModel.fromJson(data['parcel']);

      Get.off(
        () => FindParcelDriverScreen(driver: parcelDriverModel, parcel: parcel),
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    // 🔴 STOP animations first
    _xController.stop();
    _yController.stop();
    _rotationController.stop();

    // 🔴 Dispose ALL controllers
    _xController.dispose();
    _yController.dispose();
    _rotationController.dispose();

    // 🔴 Remove socket listener
    SocketService().off('trip:accepted');
    SocketService().off('parcel:accepted');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pickLocationController.text = widget.pickLocation;
    dropLocationController.text = widget.dropLocation;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good morning",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF545454),
                        ),
                      ),
                      SizedBox(height: 5),
                      Obx(
                        () => Text(
                          _userProfileController.userProfileModel.value.name ??
                              "",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF545454),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => NotificationScreen());
                    },
                    child: SvgPicture.asset('assets/icons/notification.svg'),
                  ),
                  SizedBox(width: 12),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        Get.to(() => UserProfileScreen());
                      },
                      child: CustomNetworkImage(
                        imageUrl:
                            "${ApiConstant.imageBaseUrl}${_userProfileController.userProfileModel.value.avatar}",
                        boxShape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1),
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      controller: pickLocationController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hint: Text(
                          "Aqua Tower, Mohakhali",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF676769),
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset('assets/icons/pick.svg'),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE6E6E6).withValues(alpha: 0.24),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: dropLocationController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hint: Text(
                          "Aqua Tower, Mohakhali",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF676769),
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset('assets/icons/location.svg'),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFB5F5D7)),
                        ),
                        filled: true,
                        fillColor: Color(0xFFE6E6E6).withValues(alpha: 0.24),
                      ),
                    ),
                    SizedBox(height: 32),

                    Container(
                      height: 260,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF345983),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                "28 XAF",
                                style: TextStyle(
                                  color: Color(0xFF012F64),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          /// 🔥 Animated Search Icon
                          AnimatedBuilder(
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
                                          color: Colors.white.withValues(
                                            alpha: 0.4,
                                          ),
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

                          const SizedBox(height: 15),

                          Text(
                            "searching".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),

                    CustomButton(
                      onTap: () {
                        if (widget.parcelId != null) {
                          SocketService().emit(
                            'parcel:cancel',
                            data: {"parcel_id": widget.parcelId!},
                          );
                          debugPrint("Parcel declined: ${widget.parcelId}");
                        } else if (widget.tripId != null) {
                          SocketService().emit(
                            'trip:cancel',
                            data: {"trip_id": widget.tripId!},
                          );
                          debugPrint("Trip canceled: ${widget.tripId}");
                        } else {
                          debugPrint("Nothing to cancel");
                          return;
                        }

                        Get.back();
                      },
                      text: "cancel".tr,
                    ),

                    SizedBox(height: 90),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/what.svg'),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "needHelp".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "support".tr,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ],
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
    );
  }
}
