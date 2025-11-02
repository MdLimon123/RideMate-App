import 'dart:io';

import 'package:get/get.dart';
import 'package:radeef/utils/image_utils.dart';

class DriverProfileController extends GetxController{

  Rx<File?> driverProfileImage = Rx<File?>(null);


  /// Pick image from camera or gallery
  Future<void> pickDriverProfileImage({bool fromCamera = false})async{

    final pickedFile = await ImageUtils.pickAndCropImage(fromCamera: fromCamera);
    if(pickedFile != null){
      driverProfileImage.value = pickedFile;
    }

  }

}