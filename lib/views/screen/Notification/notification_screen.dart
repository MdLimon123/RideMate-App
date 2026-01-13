import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/notification_controller.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_appbar.dart';
import 'package:radeef/views/base/custom_loading.dart';
import 'package:radeef/views/base/timeAgo.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _notificationController = Get.put(NotificationController());

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _notificationController.fetchNotifications(isInitial: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        _notificationController.fetchNotifications();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: "Notification"),
      body: Obx(() {
        if (_notificationController.isLoading.value) {
          return Center(child: CustomLoading(color: AppColors.primaryColor));
        }

        return ListView.separated(
          controller: _scrollController,
          itemCount:
              _notificationController.notificationList.length +
              (_notificationController.isMoreLoading.value ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemBuilder: (context, index) {
            if (index >= _notificationController.notificationList.length) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: CustomLoading(color: AppColors.primaryColor),
                ),
              );
            }

            final item = _notificationController.notificationList[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF012F64),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.message,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF676769),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timeAgo(item.timestamp),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF676769),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
