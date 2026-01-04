import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/models/Driver/parcel_request_model.dart';
import 'package:radeef/models/Driver/trip_request_model.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/accept_screen.dart';

class NewRequestScreen extends StatefulWidget {
  final bool isParcel;
  final ParcelRequestModel? parcel;
  final TripRequestModel? trip;
  final ParcelUserModel? parcelUserModel;
  final TripUserModel? tripUserModel;

  const NewRequestScreen({
    super.key,
    required this.isParcel,
    this.parcel,
    this.trip,
    this.parcelUserModel,
    this.tripUserModel,
  });
  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {




  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            child: Text(
                              widget.isParcel
                                  ? "New Parcel Request"
                                  : "newRideRequest".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              "5 min ETA",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFFFFFFF),
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
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        widget.isParcel
                                            ? widget.parcel!.pickupAddress
                                            : widget.trip!.pickupAddress,
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
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/location.svg',
                                      color: AppColors.textColor,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        widget.isParcel
                                            ? widget.parcel!.dropoffAddress
                                            : widget.trip!.dropoffAddress,
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
                                            "${widget.parcel!.amount}",
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

                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/dollar_fill.svg',
                                      color: AppColors.textColor,
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
            SizedBox(height: 130),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (widget.isParcel) {
                          //  Parcel accept
                          SocketService().emit(
                            'parcel:driver_cancel',
                            data: {"parcel_id": widget.parcel!.id},
                          );

                          debugPrint("Parcel decline: ${widget.parcel!.id}");

                          Get.back();
                        } else {
                          //  Trip accept
                          SocketService().emit(
                            'trip:cancel',
                            data: {"trip_id": widget.trip!.id},
                          );

                          debugPrint("Trip cancel: ${widget.trip!.id}");

                          Get.back();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Color(0xFFE6E6E6),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Center(
                          child: Text(
                            "decline".tr,
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
                    child: CustomButton(
                      onTap: () {
                        if (widget.isParcel) {
                          //  Parcel accept
                          SocketService().emit(
                            'parcel:accept',
                            data: {"parcel_id": widget.parcel!.id},
                          );

                          debugPrint("Parcel accepted: ${widget.parcel!.id}");

                          //  Parcel model pass
                          Get.to(
                            () => AcceptScreen(
                              isParcel: true,
                              parcel: widget.parcel,
                              parcelUserModel: widget.parcelUserModel,
                            ),
                          );
                        } else {
                          //  Trip accept
                          SocketService().emit(
                            'trip:accept',
                            data: {"trip_id": widget.trip!.id},
                          );

                          debugPrint("Trip accepted: ${widget.trip!.id}");

                          //  Trip model pass
                          Get.to(
                            () => AcceptScreen(
                              isParcel: false,
                              trip: widget.trip,
                              tripUserModel: widget.tripUserModel,
                            ),
                          );
                        }
                      },
                      text: "accept".tr,
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
