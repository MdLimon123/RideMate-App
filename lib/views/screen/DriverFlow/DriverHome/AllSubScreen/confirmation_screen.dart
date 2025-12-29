import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_chat_controller.dart';
import 'package:radeef/controllers/DriverController/driver_parcel_controller.dart';
import 'package:radeef/models/Driver/parcel_request_model.dart';
import 'package:radeef/models/Driver/trip_request_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/rate_pessengers_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  final bool isParcel;
  final ParcelRequestModel? parcel;
  final TripRequestModel? trip;
  final ParcelUserModel? parcelUserModel;
  final TripUserModel? tripUserModel;
  const ConfirmationScreen({
    super.key,
    required this.isParcel,
    this.parcel,
    this.trip,
    this.parcelUserModel,
    this.tripUserModel,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final _driverParcelController = Get.put(DriverParcelController());

  final _driverChatController = Get.put(DriverChatController());

  @override
  void initState() {
    super.initState();
  }

  void _handleTripPaymentConfirmation() {
    SocketService().on('trip:paid', (data) {
      print("🟡 Trip paid: $data");
      final trip = data['trip'];
      final transaction = data['transaction'];

      bool paymentSuccess =
          transaction['amount'] == trip['total_cost'] &&
          transaction['payment_method'] == 'WALLET';

      if (paymentSuccess) {
        Get.to(
          () => ConfirmationScreen(
            isParcel: widget.isParcel,
            parcel: widget.isParcel ? widget.parcel : null,
            parcelUserModel: widget.isParcel ? widget.parcelUserModel : null,
            trip: widget.isParcel ? null : widget.trip,
            tripUserModel: widget.isParcel ? null : widget.tripUserModel,
          ),
        );
      } else {
        _showPaymentError();
      }
    });
  }

  void _showPaymentError() {
    Get.snackbar(
      'Payment Error',
      'Payment failed. Please try again.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                        "${ApiConstant.imageBaseUrl}${widget.isParcel ? widget.parcelUserModel!.avatar : widget.tripUserModel!.avatar}",
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
                        : widget.tripUserModel!.name,
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
                          widget.isParcel
                              ? widget.parcelUserModel!.tripReceivedCount
                                    .toString()
                              : widget.tripUserModel!.tripReceivedCount
                                    .toString(),
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
                          widget.isParcel
                              ? widget.parcelUserModel!.rating.toString().substring(0, 3)
                              : widget.tripUserModel!.rating.toString(),
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
                widget.isParcel
                    ? Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Take a picture for end trip",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textColor,
                              ),
                            ),

                            Obx(() {
                              final image =
                                  _driverParcelController.parcelImage.value;
                              return InkWell(
                                onTap: () {
                                  _driverParcelController.pickParcelImage(
                                    fromCamera: true,
                                  );
                                },
                                child: Container(
                                  height: 28,
                                  width: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Color(0xFF11DF7F),
                                      width: 0.5,
                                    ),
                                  ),
                                  child: image != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          child: Image.file(
                                            image,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : null,
                                ),
                              );
                            }),
                          ],
                        ),
                      )
                    : SizedBox(),

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
                                SvgPicture.asset("assets/icons/box.svg"),
                                SizedBox(width: 12),
                                Text(
                                  widget.parcel!.totalCost.toString(),
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
                            widget.isParcel
                                ? widget.parcel!.amount.toString()
                                : widget.trip!.totalCost.toString(),
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
          SizedBox(height: 50),
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
                const SizedBox(width: 16),
                InkWell(
                  onTap: () async {
                    await _driverChatController.createChatRoom(
                      userId: widget.isParcel
                          ? widget.parcel!.userId
                          : widget.trip!.userId,
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
                const SizedBox(width: 22),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     height: 40,
                //     padding: const EdgeInsets.symmetric(horizontal: 10),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(24),
                //       color: const Color(0xFFE6E6E6).withValues(alpha: 0.50),
                //     ),
                //     child: Center(
                //       child: Text(
                //         "Navigate",
                //         style: TextStyle(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w500,
                //           color: AppColors.textColor,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                // Start Trip button
                InkWell(
                  onTap: () {
                    if (widget.isParcel) {
                      /// socket emit hobe image upload korte hobe
                      // final files = await _driverParcelController
                      //     .uplaodParcelImage(
                      //       imagePath:
                      //           _driverParcelController.parcelImage.value!.path,
                      //     );

                      // if (files != null && files.isNotEmpty) {
                      //   SocketService().emit('parcel:deliver', {
                      //     'parcel_id': widget.parcel!.id,
                      //     'files': files,
                      //     'delivery_lat': widget.parcel!.dropoffLat,
                      //     'delivery_lng': widget.parcel!.dropoffLng,
                      //   });

                      deliverParcel();
                    } else {
                      _handleTripPaymentConfirmation();

                      Get.to(
                        () => RatePessengersScreen(
                          isParcel: widget.isParcel,
                          parcel: widget.isParcel ? widget.parcel : null,
                          parcelUserModel: widget.isParcel
                              ? widget.parcelUserModel
                              : null,
                          trip: widget.isParcel ? null : widget.trip,
                          tripUserModel: widget.isParcel
                              ? null
                              : widget.tripUserModel,
                        ),
                      );
                      debugPrint("payent ===========>");
                    }
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Color(0xFF345983),
                    ),
                    child: Center(
                      child: Text(
                        widget.isParcel ? "Deliver Parcel" : "Confirm",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
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
    );
  }

  Future<void> deliverParcel() async {
    // Upload first
    final files = await _driverParcelController.uplaodParcelImage(
      imagePath: _driverParcelController.parcelImage.value!.path,
    );

    if (files != null && files.isNotEmpty) {
      // Ensure socket is connected
      if (SocketService().isConnected) {
        SocketService().emit('parcel:deliver', data: {
          'parcel_id': widget.parcel!.id,
          'files': files,
          'delivery_lat': widget.parcel!.dropoffLat,
          'delivery_lng': widget.parcel!.dropoffLng,
        });
        onDeliveryCompleted(context);
      } else {
        debugPrint('❌ Socket not connected');
      }
    }
  }

  void onDeliveryCompleted(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Delivery Complete 🎉',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor,
            ),
          ),
          content: Text(
            'Parcel delivery has been completed successfully.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            CustomButton(
              onTap: () {
                Get.to(
                  () => RatePessengersScreen(
                    isParcel: widget.isParcel,
                    parcel: widget.isParcel ? widget.parcel : null,
                    parcelUserModel: widget.isParcel
                        ? widget.parcelUserModel
                        : null,
                    trip: widget.isParcel ? null : widget.trip,
                    tripUserModel: widget.isParcel
                        ? null
                        : widget.tripUserModel,
                  ),
                );
              },
              text: "Next",
            ),
          ],
        );
      },
    );
  }
}
