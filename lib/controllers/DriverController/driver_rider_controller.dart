import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/models/Driver/rider_history_model.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/utils/image_utils.dart';

class DriverRiderController extends GetxController {
  final RxString selectedOption = 'All'.obs; 
  int page = 1;
  bool hasMore = true;
  var isLoading = false.obs;
  final RxList<RiderHistoryItem> riderHistoryList = <RiderHistoryItem>[].obs;

  final Map<String, String> optionsMap = {
    'All': 'all_time',
    'This Week': 'this_week',
    'This Month': 'this_month',
  };

  void changeOption(String newValue) {
    selectedOption.value = newValue;
    page = 1;
    hasMore = true;
    riderHistoryList.clear();
    fetchRiderHistory();
  }

  Rx<File?> parcelImage = Rx<File?>(null);

  Future<void> pickParcelImage({bool fromCamera = true}) async {
    final pickedFile = await ImageUtils.pickAndCropImage(
      fromCamera: fromCamera,
    );
    if (pickedFile != null) {
      parcelImage.value = pickedFile;
    }
  }

  Future<void> fetchRiderHistory() async {
    if (!hasMore) return;

    isLoading(true);

    String url = '/ride-history';
    if (selectedOption.value.isNotEmpty) {
      String dateRange = optionsMap[selectedOption.value] ?? '-1';
      url = '/ride-history?dateRange=$dateRange&page=$page';
    }

    final response = await ApiClient.getData(url);

    if (response.statusCode == 200) {
      final json = response.body;
      final model = RiderHistoryModel.fromJson(json);
      riderHistoryList.addAll(model.data);
      hasMore = model.data.isNotEmpty;
    } else {
      hasMore = false;
      debugPrint("Failed to load rider history: ${response.statusCode}");
    }

    isLoading(false);
  }
}
