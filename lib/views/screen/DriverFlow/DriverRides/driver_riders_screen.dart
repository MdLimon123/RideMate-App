import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:radeef/controllers/DriverController/driver_rider_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/bottom_menu.dart';
import 'package:radeef/views/base/custom_loading.dart';
import 'package:radeef/views/screen/DriverFlow/DriverRides/driver_rider_details_screen.dart';

class DriverRidersScreen extends StatefulWidget {
  const DriverRidersScreen({super.key});

  @override
  State<DriverRidersScreen> createState() => _DriverRidersScreenState();
}

class _DriverRidersScreenState extends State<DriverRidersScreen> {
  final _driverRiderController = Get.put(DriverRiderController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _driverRiderController.fetchRiderHistory(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
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
                      color: AppColors.textColor,
                    ),
                  ),

                  Obx(
                    () => DropdownButton<String>(
                      value: _driverRiderController.selectedOption.value.isEmpty
                          ? null
                          : _driverRiderController.selectedOption.value,

                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.textColor,
                      ),
                      underline: SizedBox(),
                      dropdownColor: const Color(0xFFFEF7F6),
                      onChanged: (String? newValue) {
                        if (newValue == null) return;
                        _driverRiderController.changeOption(newValue);
                      },
                      items: _driverRiderController.optionsMap.keys
                          .map(
                            (value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Obx(() {
                if (_driverRiderController.isLoading.value) {
                  return Center(
                    child: CustomLoading(color: AppColors.primaryColor),
                  );
                }

                if (_driverRiderController.riderHistoryList.isEmpty) {
                  return Center(
                    child: Text(
                      "No ride history available",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF87878A),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final item =
                          _driverRiderController.riderHistoryList[index];

                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => DriverRiderDetailsScreen(
                              isParcel: item.isParcel,
                              riderHistoryItem: item,
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 13,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFE6E6E6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
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
                                      color: Color(0xFF333333),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "From : ${item.pickupAddress}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF87878A),
                                    ),
                                  ),
                                  Text(
                                    "To : ${item.dropoffAddress}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF87878A),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Text(
                                "\$${item.totalCost}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF012F64),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => SizedBox(height: 8),
                    itemCount: _driverRiderController.riderHistoryList.length,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomMenu(1),
    );
  }
}
