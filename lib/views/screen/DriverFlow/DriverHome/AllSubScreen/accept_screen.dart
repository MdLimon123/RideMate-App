import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_chat_controller.dart';
import 'package:radeef/controllers/UserController/trip_socket_controller.dart';
import 'package:radeef/controllers/UserController/tripstate_controller.dart';
import 'package:radeef/models/Driver/parcel_request_model.dart';
import 'package:radeef/models/Driver/trip_request_model.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'trip_map_screen.dart';

class AcceptScreen extends StatefulWidget {
  final ParcelRequestModel? parcel;
  final TripModel? trip;
  final ParcelUserModel? parcelUserModel;
  final bool isParcel;

  const AcceptScreen({
    super.key,
    required this.isParcel,
    this.parcel,
    this.trip,
    this.parcelUserModel,
  });

  @override
  State<AcceptScreen> createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
  final _driverChatController = Get.put(DriverChatController());
  final TripSocketController _tripSocketController = Get.put(
    TripSocketController(),
  );

  @override
  Widget build(BuildContext context) {
    _tripSocketController.isTripStarted.value = widget.trip!.status == TripStatus.STARTED;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 30),
            SizedBox(
              height: 500,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset("assets/images/maps.png"),
                  Positioned(
                    bottom: -60,
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
                            child: CustomNetworkImage(
                              imageUrl:
                                  "${ApiConstant.imageBaseUrl}${widget.isParcel ? widget.parcelUserModel!.avatar : widget.trip!.user!.avatar}",
                              boxShape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              height: 48,
                              width: 48,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Text(
                              widget.isParcel
                                  ? widget.parcelUserModel!.name
                                  : widget.trip!.user!.name ?? "",
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
                                    "${widget.isParcel ? widget.parcelUserModel!.tripReceivedCount : widget.trip!.user!.tripReceivedCount}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFF012F64),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${widget.isParcel ? widget.parcelUserModel!.ratingCount : widget.trip!.user!.ratingCount}",
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
                                  children: [
                                    SvgPicture.asset('assets/icons/pick.svg'),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        widget.isParcel
                                            ? widget.parcel!.pickupAddress
                                            : widget.trip!.pickupAddress ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/location.svg',
                                      color: AppColors.textColor,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        widget.isParcel
                                            ? widget.parcel!.dropoffAddress
                                            : widget.trip!.dropoffAddress ?? "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                widget.isParcel
                                    ? Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/box.svg",
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            "${widget.isParcel ? widget.parcel!.totalCost : widget.trip!.totalCost}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF012F64),
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            "(XAF)",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w200,
                                              color: AppColors.textColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/dollar_fill.svg',
                                      color: AppColors.textColor,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      "${widget.isParcel ? widget.parcel!.amount : widget.trip!.totalCost}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF012F64),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "(XAF)",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                        color: AppColors.textColor,
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
                ],
              ),
            ),
            const SizedBox(height: 130),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFE6EAF0),
                    ),
                    child: SvgPicture.asset('assets/icons/phone.svg'),
                  ),

                  InkWell(
                    onTap: () async {
                      await _driverChatController.createChatRoom(
                        userId: widget.isParcel
                            ? widget.parcel!.userId
                            : widget.trip!.userId ?? "",
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE6EAF0),
                      ),
                      child: SvgPicture.asset('assets/icons/message.svg'),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Get.to(
                        () => TrackDriverMapScreen(
                          isParcel: widget.isParcel,

                          parcel: widget.isParcel ? widget.parcel : null,
                          parcelUserModel: widget.isParcel
                              ? widget.parcelUserModel
                              : null,
                          trip: widget.isParcel ? null : widget.trip,
                        ),
                      );
                    },
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFE6EAF0),
                      ),
                      child: Center(
                        child: Text(
                          "View Map",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (_tripSocketController.isTripStarted.value) {
                          _tripSocketController.tripEnded(widget.trip!.id);
                          return;
                        }
                        _tripSocketController.tripStarted(
                          tripId: widget.trip!.id,
                          onTripStarted: () {
                            Get.to(
                              () => TrackDriverMapScreen(
                                isParcel: widget.isParcel,

                                parcel: widget.isParcel ? widget.parcel : null,
                                parcelUserModel: widget.isParcel
                                    ? widget.parcelUserModel
                                    : null,

                                trip: widget.isParcel ? null : widget.trip,
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 46,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: const Color(0xFF345983),
                        ),
                        child: Center(
                          child: Text(
                            _tripSocketController.isTripStarted.value
                                ? "End Trip"
                                : "Start Trip",
                            style: TextStyle(
                              fontSize: widget.isParcel ? 12 : 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
