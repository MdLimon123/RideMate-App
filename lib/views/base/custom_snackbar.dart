import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(
    String? message, {
      bool isError = true,
      bool getXSnackBar = false,
    }) {

  if (message?.isNotEmpty ?? false) {
    final backgroundColor = isError ? Colors.red.shade400 : Colors.green;

    if (getXSnackBar) {
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: backgroundColor,
          message: message!,
          duration: const Duration(seconds: 3),
          snackStyle: SnackStyle.FLOATING,
          margin: EdgeInsets.all(10),
          borderRadius: 8,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
        ),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.horizontal,
          margin: EdgeInsets.all(10),
          duration: const Duration(seconds: 3),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          content: Text(
            message!,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
