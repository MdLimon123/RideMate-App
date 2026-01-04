import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radeef/models/Driver/rider_history_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_appbar.dart';
import 'package:radeef/views/base/custom_network_image.dart';

class DriverRiderDetailsScreen extends StatefulWidget {
  final bool isParcel;
  final RiderHistoryItem? riderHistoryItem;

  const DriverRiderDetailsScreen({
    super.key,
    required this.isParcel,
    this.riderHistoryItem,
  });

  @override
  State<DriverRiderDetailsScreen> createState() =>
      _DriverRiderDetailsScreenState();
}

class _DriverRiderDetailsScreenState extends State<DriverRiderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final totalCost = widget.riderHistoryItem?.totalCost ?? 0;
    final radeefFee = (totalCost * 0.02).toInt();
    final driverEarn = totalCost - radeefFee;

    return Scaffold(
      backgroundColor: Color(0xFFE6EAF0),
      appBar: CustomAppbar(title: "Ride Details"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          widget.isParcel ? SizedBox(height: 10) : SizedBox(height: 186),
          widget.isParcel
              ? Container(
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
                              "${ApiConstant.imageBaseUrl}${widget.riderHistoryItem?.user?.avatar}",
                          height: 48,
                          width: 48,
                          boxShape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: Text(
                          "${widget.riderHistoryItem?.user?.name}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Picture for end trip",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textColor,
                                    ),
                                  ),

                                  CustomNetworkImage(
                                    imageUrl:
                                        "${ApiConstant.imageBaseUrl}${widget.riderHistoryItem?.deliveryProofFiles}",
                                    border: Border.all(
                                      color: Color(0xFF11DF7F),
                                      width: 0.5,
                                    ),
                                    height: 28,
                                    borderRadius: BorderRadius.circular(4),
                                    width: 28,
                                  ),
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
                                    widget.riderHistoryItem?.pickupAddress ??
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
                                    widget.riderHistoryItem?.dropoffAddress ??
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
                            widget.isParcel
                                ? Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/box.svg"),
                                      SizedBox(width: 12),
                                      Text(
                                        "\$${widget.riderHistoryItem?.totalCost}",
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
                                  'assets/icons/box.svg',
                                  color: AppColors.textColor,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  "${widget.riderHistoryItem?.amount}",
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
                )
              : Center(
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
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl:
                                  "${ApiConstant.imageBaseUrl}${widget.riderHistoryItem?.user?.avatar}",
                              border: Border.all(
                                color: Color(0xFF11DF7F),
                                width: 0.5,
                              ),
                              height: 48,
                              borderRadius: BorderRadius.circular(4),
                              width: 48,
                            ),
                            const SizedBox(width: 12),
                            Center(
                              child: Text(
                                "${widget.riderHistoryItem?.user?.name}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 34),

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
                                      widget.riderHistoryItem?.pickupAddress ??
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
                                      widget.riderHistoryItem?.dropoffAddress ??
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
                                    'assets/icons/box.svg',
                                    color: AppColors.textColor,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    widget.riderHistoryItem?.totalCost
                                            .toString() ??
                                        "",
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
          SizedBox(height: 20),
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
                  child: Text(
                    "Your earn of this trip",
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
                    width: 187,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "$driverEarn (XAF)",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF012F64),
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Radeef ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(width: 6),
                    SvgPicture.asset("assets/icons/percentige.svg"),
                    SizedBox(width: 4),
                    Text(
                      "$radeefFee",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "(XAF)",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
