import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/chat_controller.dart';
import 'package:radeef/controllers/UserController/user_profile_controller.dart';
import 'package:radeef/models/User/driver_model.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/utils/location_utils.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/screen/Notification/notification_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/user_rating_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserProfile/user_profile_screen.dart';

class EndTripScreen extends StatefulWidget {
  final DriverModel driver;
  final TripModel trip;
  const EndTripScreen({super.key, required this.driver, required this.trip});

  @override
  State<EndTripScreen> createState() => _EndTripScreenState();
}

class _EndTripScreenState extends State<EndTripScreen> {
  final codeController = TextEditingController(text: "");

  final _chatController = Get.put(ChatController());

  final _userProfileController = Get.put(UserProfileController());

  double driverLat = 0;
  double driverLng = 0;

  int etaMin = 0;
  double distance = 0;

  @override
  void initState() {
    _userProfileController.fetchUserInfo();
    driverLat = widget.driver.locationLat;
    driverLng = widget.driver.locationLng;
    _calculateEta();
    _listenDriverLocation();
    super.initState();
  }

  void _listenDriverLocation() {
    SocketService().on('driver:location:update', (data) {
      final newLat = (data['location_lat'] ?? 0).toDouble();
      final newLng = (data['location_lng'] ?? 0).toDouble();

      if (newLat == 0 || newLng == 0) return;

      setState(() {
        driverLat = newLat;
        driverLng = newLng;
      });

      _calculateEta();

      debugPrint("📡 Driver moved → $newLat , $newLng");
    });
  }

  void _calculateEta() {
    final userLat = widget.trip.pickupLat;
    final userLng = widget.trip.pickupLng;

    if (driverLat == 0 || driverLng == 0 || userLat == 0 || userLng == 0) {
      setState(() {
        etaMin = 0;
        distance = 0;
      });
      return;
    }

    final d = LocationUtils.distanceKm(
      lat1: driverLat,
      lng1: driverLng,
      lat2: userLat,
      lng2: userLng,
    );

    final eta = LocationUtils.etaMinutes(distanceKm: d);

    setState(() {
      distance = d;
      etaMin = eta;
    });

    debugPrint("📍 Distance KM: ${d.toStringAsFixed(2)}");
    debugPrint("⏱ ETA Minutes: $eta");
  }

  @override
  void dispose() {
    SocketService().off('driver:location:update');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    codeController.text = widget.trip.slug;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                  InkWell(
                    onTap: () {
                      Get.to(() => UserProfileScreen());
                    },
                    child: Obx(
                      () => CustomNetworkImage(
                        imageUrl:
                            "${ApiConstant.imageBaseUrl}${_userProfileController.userProfileModel.value.avatar}",
                        boxShape: BoxShape.circle,
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
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 28,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Color(0xFF345983),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CustomNetworkImage(
                              imageUrl:
                                  "${ApiConstant.imageBaseUrl}${widget.driver.avatar}",
                              boxShape: BoxShape.circle,
                              border: Border.all(color: Color(0xFFFFFFFF)),
                              height: 48,
                              width: 48,
                            ),
                          ),
                          SizedBox(height: 12),
                          Center(
                            child: Text(
                              widget.driver.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${widget.driver.vehicleBrand} ${widget.driver.vehicleModel}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                etaMin == 0
                                    ? "-- min away"
                                    : "$etaMin min away",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: Container(
                              width: 158,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/icons/cycle.svg"),
                                  SizedBox(width: 4),
                                  Text(
                                    "Trip",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "${widget.driver.tripGivenCount}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Icon(Icons.star, color: Color(0xFF012F64)),
                                  SizedBox(width: 4),
                                  Text(
                                    "${widget.driver.ratingCount}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/pick.svg'),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        widget.trip.pickupAddress,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF333333),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/location.svg',
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        widget.trip.dropoffAddress,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF333333),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    SvgPicture.asset('assets/icons/dollar.svg'),
                                    SizedBox(width: 12),
                                    Text(
                                      "${widget.trip.totalCost}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "(XAF)",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                        color: Color(0xFF333333),
                                        fontStyle: FontStyle.italic,
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
                    SizedBox(height: 17),
                    TextFormField(
                      controller: codeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: codeController.text),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Copied to clipboard!')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset('assets/icons/copy.svg'),
                          ),
                        ),

                        fillColor: Color(0xFFE6EAF0),
                        filled: true,
                        hint: Text(
                          widget.trip.slug,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 98),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFE6EAF0),
                          ),
                          child: SvgPicture.asset('assets/icons/phone.svg'),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () async {
                            await _chatController.createChatRoom(
                              userId: widget.driver.id.toString(),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFE6EAF0),
                            ),
                            child: SvgPicture.asset('assets/icons/message.svg'),
                          ),
                        ),
                        SizedBox(width: 22),

                        InkWell(
                          onTap: () {
                            _payTrip();
                          },
                          child: Container(
                            height: 46,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Color(0xFFE6EAF0),
                            ),
                            child: Center(
                              child: Text(
                                "Pay Now ",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
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
      ),
    );
  }

  void _payTrip() {
    if (!SocketService().isConnected) {
      _showErrorPopup("Socket not connected");
      return;
    }
    SocketService().emit(
      "trip:pay",
      data: {"trip_id": widget.trip.id},
      ack: (response) {
        if (response['status'] == 'success') {
          final balance = response['balance'] ?? 0;
          _showSuccessPopup(
            balance,
            widget.driver.avatar,
            widget.driver.name,
            widget.driver.tripGivenCount,
            widget.driver.ratingCount.toDouble(),
            widget.driver,
            widget.trip,
          );
        } else {
          final message = response['message'] ?? "Payment failed";
          _showErrorPopup(message);
        }
      },
    );
  }

  void _showSuccessPopup(
    int balance,
    String avatar,
    String name,
    int trip,
    double rating,
    final DriverModel driver,
    final TripModel tripModel,
  ) {
    Get.dialog(
      AlertDialog(
        title: const Text("Payment Successful"),
        content: Text("Current Balance: \$$balance"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.to(
                () => UserRatingScreen(
                  drivierImage: driver.avatar,
                  driverName: driver.name,
                  trip: driver.tripGivenCount,
                  rating: driver.ratingCount.toDouble(),
                  driver: driver,
                  tripModel: tripModel,
                ),
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _showErrorPopup(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text("Payment Failed"),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("OK")),
        ],
      ),
    );
  }
}
