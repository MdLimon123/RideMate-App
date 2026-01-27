import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:radeef/controllers/UserController/user_profile_controller.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/user_home_screen.dart';

class UserRatingScreen extends StatefulWidget {
  final String drivierImage;
  final String driverName;
  final int trip;
  final double rating;

  final TripModel tripModel;

  const UserRatingScreen({
    super.key,
    required this.drivierImage,
    required this.driverName,
    required this.trip,
    required this.rating,
 
    required this.tripModel,
  });

  @override
  State<UserRatingScreen> createState() => _RatePessengersScreenState();
}

class _RatePessengersScreenState extends State<UserRatingScreen> {
  final _userProfileController = Get.put(UserProfileController());

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
                          "${ApiConstant.imageBaseUrl}${widget.drivierImage}",
                      boxShape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      height: 48,
                      width: 48,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      widget.driverName,
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
                      width: 158,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
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
                            "${widget.trip}",
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
                            "${widget.rating}",
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
                  Obx(
                    () => Center(
                      child: RatingBar.builder(
                        initialRating: _userProfileController.rating.value,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: Color(0xFFFFFFFF)),
                        onRatingUpdate: (rating) {
                          _userProfileController.updateRating(rating);
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
                      Get.to(() => UserHomeScreen());
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
                          "Later",
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
                      loading: _userProfileController.isLaoding.value,
                      onTap: () {
                        _userProfileController.submitRating(
                          userId: _userProfileController
                              .userProfileModel
                              .value
                              .id
                              .toString(),

                          tripId: widget.tripModel.id.toString(),
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
