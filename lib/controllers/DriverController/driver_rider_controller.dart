import 'dart:io';

import 'package:get/get.dart';
import 'package:radeef/utils/image_utils.dart';

class DriverRiderController extends GetxController{

  final RxString selectedOption = 'This Week'.obs;
  int days = -1;
  final List<String> options = ['This Week', 'This Month'];

  void changeOption(String newValue) {
    selectedOption.value = newValue;

    switch (newValue) {

      case "This Week":
        days = 7;
        break;
      case "This Month":
        days = 30;
        break;
      default:
        days = -1;
    }
  }

  Rx<File?> parcelImage = Rx<File?>(null);

  Future<void> pickParcelImage({bool fromCamera = true})async{

    final pickedFile = await ImageUtils.pickAndCropImage(fromCamera: fromCamera);
    if(pickedFile != null){
      parcelImage.value = pickedFile;
    }

  }
}