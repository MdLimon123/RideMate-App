import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/driver_parcel_controller.dart';
import 'package:radeef/controllers/parcel_state.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_button.dart';
import 'package:radeef/views/base/custom_network_image.dart';
import 'package:radeef/views/screen/DriverFlow/parcel/driver_payment_wating_screen.dart';

class DriverParcelConfirmationScreen extends StatefulWidget {
  const DriverParcelConfirmationScreen({super.key});

  @override
  State<DriverParcelConfirmationScreen> createState() =>
      _DriverParcelConfirmationScreenState();
}

class _DriverParcelConfirmationScreenState
    extends State<DriverParcelConfirmationScreen> {
  final _parcelStateController = Get.put(ParcelStateController());

  final _driverParcelController = Get.put(DriverParcelController());

  @override
  void initState() {
    super.initState();
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
                        "${ApiConstant.imageBaseUrl}${_parcelStateController.parcel.value?.user?.avatar ?? ''}",
                    boxShape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    height: 48,
                    width: 48,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    _parcelStateController.parcel.value?.user?.name ?? '',
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
                          _parcelStateController
                                  .parcel
                                  .value
                                  ?.user
                                  ?.tripReceivedCount!
                                  .toString() ??
                              '0',
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
                          _parcelStateController.parcel.value?.user?.rating!
                                  .toStringAsFixed(1) ??
                              '0',
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

                InkWell(
                  onTap: () {
                    _driverParcelController.pickParcelImage(fromCamera: true);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                      borderRadius: BorderRadius.circular(4),
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
                              _parcelStateController
                                      .parcel
                                      .value
                                      ?.pickupAddress ??
                                  "",
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
                              _parcelStateController
                                      .parcel
                                      .value
                                      ?.dropoffAddress ??
                                  "",
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
                          SvgPicture.asset("assets/icons/kg.svg"),
                          SizedBox(width: 12),

                          Text(
                            "${_parcelStateController.parcel.value!.weight} Kg",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/dollar_fill.svg',
                            color: AppColors.textColor,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _parcelStateController.parcel.value?.totalCost
                                    .toString() ??
                                "0",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF012F64),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "(£)",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w200,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Row(
                      //   children: [
                      //     SvgPicture.asset(
                      //       'assets/icons/dollar_fill.svg',
                      //       color: AppColors.textColor,
                      //     ),
                      //     const SizedBox(width: 12),
                      //     Text(
                      //       _parcelStateController.parcel.value?.amount
                      //               .toString() ??
                      //           "0",
                      //       style: TextStyle(
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w500,
                      //         color: Color(0xFF012F64),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 4),
                      //     Text(
                      //       "(£)",
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w200,
                      //         color: AppColors.textColor,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),

          //     CustomButton(
          //       onTap: () async {
          //         // _driverParcelController
          //         //     .uplaodParcelImage(
          //         //       imagePath: _driverParcelController.parcelImage.value!.path,
          //         //     )
          //         //     .then((value) {
          //         //       _parcelController.parcelEnded(
          //         //         parcelId: _parcelStateController.parcel.value!.id,
          //         //         imageFile: _driverParcelController.parcelImage.value,
          //         //       );
          //         //     });

          //         try {

          //           await _driverParcelController.uplaodParcelImage(
          //             imagePath: _driverParcelController.parcelImage.value!.path,
          //           ).then((_) {

          //             _parcelController.parcelEnded(
          //             parcelId: _parcelStateController.parcel.value!.id,
          //             imageFile: _driverParcelController.parcelImage.value,
          //              onCompleted: (success) {
          // if (success) {
          //   Get.snackbar("Success", "Parcel confirmed successfully");
          // } else {
          //   Get.snackbar("Error", "Parcel confirmation failed");
          // }
          //           );

          //           });

          //           Get.snackbar("Success", "Parcel confirmed successfully");
          //         } catch (e) {

          //           Get.snackbar("Error", "Failed to confirm parcel: $e");
          //         }
          //       },
          //       text: "Confirm",
          //     ),
          Obx(
            () => CustomButton(
              loading: _driverParcelController.isLoading.value,
              onTap: () {
                final parcelImage = _driverParcelController.parcelImage.value;

                if (parcelImage == null) {
                  Get.snackbar("Error", "Please select a parcel image first");
                  return;
                }

                _driverParcelController
                    .uplaodParcelImage(
                      imagePath: parcelImage.path,
                      parcelId: _parcelStateController.parcel.value!.id
                          .toString(),
                    )
                    .then((_) {
                      // Get.offAll(FinalParcelEarn());
                      DriverPaymentWatingScreen();
                    });
              },
              text: "Confirm",
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         height: 40,
          //         width: 40,
          //         padding: const EdgeInsets.all(8),
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: const Color(0xFFE6EAF0),
          //         ),
          //         child: SvgPicture.asset('assets/icons/phone.svg'),
          //       ),
          //       const SizedBox(width: 16),
          //       InkWell(
          //         onTap: () async {
          //           await _driverChatController.createChatRoom(
          //             userId: _parcelStateController.parcel.value?.userId.toString() ?? "",
          //           );
          //         },
          //         child: Container(
          //           height: 40,
          //           width: 40,
          //           padding: const EdgeInsets.all(8),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: const Color(0xFFE6EAF0),
          //           ),
          //           child: SvgPicture.asset('assets/icons/message.svg'),
          //         ),
          //       ),
          //       const SizedBox(width: 22),

          //     ],
          //   ),
          // ),
        ],
      ),
    );
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
          actions: [],
        );
      },
    );
  }
}
