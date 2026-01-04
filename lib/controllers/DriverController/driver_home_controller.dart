import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radeef/models/Driver/driver_home_model.dart';
import 'package:radeef/service/api_client.dart';

class DriverHomeController extends GetxController {
  var homeModel = HomeModel().obs;

  Future<void> fetchHomeData() async {
    final response = await ApiClient.getData("/drivers");

    if (response.statusCode == 200 || response.statusCode == 201) {
      homeModel.value = HomeModel.fromJson(response.body);
    } else {
      debugPrint("soemthing we want wrong ======> ${response.statusText}");
    }
  }
}
