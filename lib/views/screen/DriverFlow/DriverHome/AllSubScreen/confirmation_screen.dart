// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:radeef/controllers/DriverController/driver_chat_controller.dart';
// import 'package:radeef/models/User/trip_model.dart';

// import 'package:radeef/service/api_constant.dart';
// import 'package:radeef/utils/app_colors.dart';
// import 'package:radeef/views/base/custom_network_image.dart';

// class ConfirmationScreen extends StatefulWidget {
//   final TripModel tripData;
//   const ConfirmationScreen({super.key, required this.tripData});

//   @override
//   State<ConfirmationScreen> createState() => _ConfirmationScreenState();
// }

// class _ConfirmationScreenState extends State<ConfirmationScreen> {
//   final _driverChatController = Get.put(DriverChatController());

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         children: [
//           SizedBox(height: 162),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             decoration: BoxDecoration(
//               color: const Color(0xFF345983),
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.1),
//                   blurRadius: 10,
//                   offset: const Offset(0, -3),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: CustomNetworkImage(
//                     imageUrl:
//                         "${ApiConstant.imageBaseUrl}${widget.tripData.user?.avatar ?? ''}",
//                     boxShape: BoxShape.circle,
//                     border: Border.all(color: Colors.white, width: 2),
//                     height: 48,
//                     width: 48,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Center(
//                   child: Text(
//                     widget.tripData.user?.name ?? 'N/A',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Center(
//                   child: Container(
//                     width: 158,
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Row(
//                       children: [
//                         SvgPicture.asset("assets/icons/cycle.svg"),
//                         const SizedBox(width: 4),
//                         const Text(
//                           "Trip",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFF333333),
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           widget.tripData.user?.ratingCount.toString() ?? '0',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFF333333),
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         const Icon(Icons.star, color: Color(0xFF012F64)),
//                         const SizedBox(width: 4),
//                         Text(
//                           widget.tripData.user?.rating!.toStringAsFixed(1) ??
//                               '0',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFF333333),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 34),

//                 const SizedBox(height: 20),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 12,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           SvgPicture.asset('assets/icons/pick.svg'),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               widget.tripData.pickupAddress ?? "",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.textColor,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             'assets/icons/location.svg',
//                             color: AppColors.textColor,
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Text(
//                               widget.tripData.dropoffAddress ?? "",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppColors.textColor,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             'assets/icons/dollar_fill.svg',
//                             color: AppColors.textColor,
//                           ),
//                           const SizedBox(width: 12),
//                           Text(
//                             widget.tripData.totalCost?.toString() ?? "0",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xFF012F64),
//                             ),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             "(XAF)",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w200,
//                               color: AppColors.textColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 50),

//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: 20),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       Container(
//           //         height: 40,
//           //         width: 40,
//           //         padding: const EdgeInsets.all(8),
//           //         decoration: BoxDecoration(
//           //           shape: BoxShape.circle,
//           //           color: const Color(0xFFE6EAF0),
//           //         ),
//           //         child: SvgPicture.asset('assets/icons/phone.svg'),
//           //       ),
//           //       const SizedBox(width: 16),
//           //       InkWell(
//           //         onTap: () async {
//           //           await _driverChatController.createChatRoom(
//           //             userId: widget.tripData.userId.toString(),
//           //           );
//           //         },
//           //         child: Container(
//           //           height: 40,
//           //           width: 40,
//           //           padding: const EdgeInsets.all(8),
//           //           decoration: BoxDecoration(
//           //             shape: BoxShape.circle,
//           //             color: const Color(0xFFE6EAF0),
//           //           ),
//           //           child: SvgPicture.asset('assets/icons/message.svg'),
//           //         ),
//           //       ),
//           //       const SizedBox(width: 22),

//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
