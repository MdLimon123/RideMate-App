import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:radeef/controllers/DriverController/driver_rider_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_appbar.dart';
import 'package:radeef/views/base/custom_loading.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  final _driverRiderController = Get.put(DriverRiderController());

  @override
  void initState() {
    _driverRiderController.fetchRiderHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Trip History"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ride History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF333333),
                  ),
                ),

                Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _driverRiderController.selectedOption.value.isEmpty
                          ? null
                          : _driverRiderController.selectedOption.value,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF333333),
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF333333),
                      ),
                      items: _driverRiderController.optionsMap.keys.map((
                        String value,
                      ) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF333333),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue == null) return;
                        _driverRiderController.changeOption(newValue);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(
              () => _driverRiderController.isLoading.value
                  ? Center(child: CustomLoading(color: AppColors.primaryColor))
                  : _driverRiderController.riderHistoryList.isEmpty
                  ? Center(
                      child: Text(
                        "No ride history available.",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8A8A8A),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          final item =
                              _driverRiderController.riderHistoryList[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 13,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFE6EAF0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.completedAt != null
                                      ? DateFormat(
                                          'yyyy-MM-dd',
                                        ).format(item.completedAt!)
                                      : item.date ?? 'N/A',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/icons/pick.svg'),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        "From: ${item.pickupAddress} ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF8A8A8A),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      "${item.totalCost} XAF",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF012F64),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/location.svg',
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        "${item.dropoffAddress}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF8A8A8A),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },

                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount:
                            _driverRiderController.riderHistoryList.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
