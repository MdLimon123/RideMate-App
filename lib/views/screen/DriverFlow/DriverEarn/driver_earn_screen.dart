import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/DriverController/earing_controller.dart';
import 'package:radeef/models/Driver/parcel_earn_model.dart';
import 'package:radeef/models/Driver/trip_earn_model.dart';
import 'package:radeef/views/base/bottom_menu.dart';
import 'package:radeef/views/base/custom_loading.dart';
import 'package:radeef/views/base/custom_page_loading.dart';
import 'package:radeef/views/base/format_time.dart';

class DriverEarnScreen extends StatefulWidget {
  const DriverEarnScreen({super.key});

  @override
  State<DriverEarnScreen> createState() => _DriverEarnScreenState();
}

class _DriverEarnScreenState extends State<DriverEarnScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _earingController = Get.put(EaringController());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _earingController.fetchEarnings();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header + Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Earnings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Obx(
                    () => DropdownButton<String>(
                      value: _earingController.selectedOption.value,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onChanged: (value) {
                        if (value != null) {
                          _earingController.changeOption(value);
                        }
                      },
                      items: _earingController.optionsMap.keys
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
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
              const SizedBox(height: 16),

              /// Tabs
              TabBar(
                onTap: (index) {
                  _earingController.changeTab(index == 0 ? 'trip' : 'parcel');
                },
                controller: _tabController,
                indicator: BoxDecoration(
                  color: const Color(0xFFE6EAF0),
                  borderRadius: BorderRadius.circular(8),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Trips"),
                  Tab(text: "Parcels"),
                ],
              ),
              const SizedBox(height: 16),

              /// Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    buildEarningTab('trip'),
                    buildEarningTab('parcel'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= TAB BODY =================
  Widget buildEarningTab(String tab) {
    return SingleChildScrollView(
      child: Obx(() {
        final list = tab == 'trip'
            ? _earingController.tripList
            : _earingController.parcelList;

        /// Determine meta for current tab
        final meta = tab == 'trip'
            ? _earingController.tripList.isNotEmpty
                  ? _earingController.tripList.first
                  : null
            : _earingController.parcelMeta;

        return Column(
          children: [
            /// Total Earnings
            if (meta != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6EAF0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Total Earnings",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tab == 'trip'
                          ? "\$${_earingController.tripList.fold<num>(0, (sum, item) => sum + item.totalCost)}"
                          : "\$${_earingController.parcelMeta!.totalEarnings}",
                      style: const TextStyle(
                        color: Color(0xFF012F64),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            /// Stats
            if (meta != null)
              Row(
                children: [
                  buildInfoCard(
                    icon: 'assets/icons/cycle.svg',
                    title: "Total Trips",
                    value: tab == 'trip'
                        ? "${_earingController.tripList.fold<int>(0, (sum, item) => sum + item.totalCount)}"
                        : "${_earingController.parcelMeta!.totalCount}",
                  ),
                  const SizedBox(width: 12),
                  buildInfoCard(
                    icon: 'assets/icons/clock.svg',
                    title: "Online Time",
                    value: tab == 'trip'
                        ? formatTimeFromMs(
                            _earingController.tripList.fold<int>(
                              0,
                              (sum, item) => sum + item.totalTime,
                            ),
                          )
                        : formatTimeFromMs(
                            _earingController.parcelMeta!.totalTime,
                          ),
                  ),
                ],
              ),

            const SizedBox(height: 20),

            /// Daily List
            buildEarningList(tab, list),
          ],
        );
      }),
    );
  }

  /// ================= LIST BUILDER =================
  Widget buildEarningList(String tab, List<dynamic> list) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels ==
                scrollNotification.metrics.maxScrollExtent &&
            !_earingController.isLoading.value &&
            _earingController.hasMore) {
          _earingController.loadMore();
        }
        return false;
      },
      child: ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: list.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (_, index) {
          if (index < list.length) {
            final item = list[index];

            String date = '';
            int count = 0;
            int time = 0;
            num cost = 0;

            if (item is TripEarnItem) {
              date = item.date;
              count = item.totalCount;
              time = item.totalTime;
              cost = item.totalCost;
            } else if (item is ParcelEarnItem) {
              date = item.date;
              count = item.totalCount;
              time = item.totalTime;
              cost = item.totalCost;
            }

            return buildItem(date: date, count: count, time: time, cost: cost);
          } else {
            return Obx(
              () => _earingController.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CustomLoading()),
                    )
                  : const SizedBox.shrink(),
            );
          }
        },
      ),
    );
  }

  /// ================= ITEM BUILDER =================
  Widget buildItem({
    required String date,
    required int count,
    required int time,
    required num cost,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE6EAF0).withValues(alpha: 0.24),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: const TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              Text(
                "Trips: $count, Time: ${formatTimeFromMs(time)}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "\$$cost",
            style: const TextStyle(
              color: Color(0xFF012F64),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= INFO CARD =================
  Widget buildInfoCard({
    required String icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 22),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF545454),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
