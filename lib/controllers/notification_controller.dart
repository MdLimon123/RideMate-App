import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/models/notification_model.dart';
import 'package:radeef/service/api_client.dart';

class NotificationController extends GetxController {
  int page = 1;
  final int limit = 10;
  bool hasMore = true;
    var isMoreLoading = false.obs;

  var isLoading = false.obs;
  RxList<NotificationItem> notificationList = <NotificationItem>[].obs;



  Future<void> fetchNotifications({bool isInitial = false}) async {
    if (isLoading.value || isMoreLoading.value || !hasMore) return;

    if (isInitial) {
      page = 1;
      hasMore = true;
      isLoading(true);
    } else {
      isMoreLoading(true);
    }

    final response = await ApiClient.getData(
      '/notifications?page=$page&limit=$limit',
    );

    if (response.statusCode == 200) {
      final model = NotificationModel.fromJson(response.body);

      final newList = model.data;

      if (isInitial) {
        notificationList.value = newList;
      } else {
        notificationList.addAll(newList);
      }


      if (newList.length < limit) {
        hasMore = false;
      } else {
        page++;
      }
    } else {
      debugPrint("Failed to load notifications");
    }

    isLoading(false);
    isMoreLoading(false);
  }
}



