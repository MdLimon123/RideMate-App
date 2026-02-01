import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_parcel_controller.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';

class RatePessengersScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String userImage;
  final double rating;
  final int totalTrips;
  final String tripId;
  const RatePessengersScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.totalTrips,
    required this.tripId,
  });

  @override
  State<RatePessengersScreen> createState() => _RatePessengersScreenState();
}

class _RatePessengersScreenState extends State<RatePessengersScreen> {
  final _driverController = Get.put(DriverParcelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 22),
          children: [
            SizedBox(height: 162),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                    child: CustomNetworkImage(
                      imageUrl:
                          "${ApiConstant.imageBaseUrl}${widget.userImage}",
                      boxShape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      height: 48,
                      width: 48,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      widget.userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                  
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                         mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icons/cycle.svg"),
                          const SizedBox(width: 4),
                          const Text(
                            "Trip",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.totalTrips.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333),
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Icon(Icons.star, color: Color(0xFF012F64)),
                          const SizedBox(width: 4),
                          Text(
                            widget.rating.toStringAsFixed(1),
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
                  SizedBox(height: 34),
                  Center(
                    child: Text(
                      "Rate the Passengers",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Obx(
                      () => RatingBar.builder(
                        initialRating: _driverController.rating.value,
                        minRating: 1,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (value) {
                          _driverController.updateRating(value);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 68),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.offAll(() => DriverHomeScreen());
                    },
                    child: Container(
                      height: 52,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 22),
                Expanded(
                  child: Obx(
                    () => CustomButton(
                      loading: _driverController.isLoading.value,
                      onTap: () {
                        _driverController.submitRating(
                          userId: widget.userId,
                          tripId: widget.tripId,
                        );
                      },
                      text: "Rate Now",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
