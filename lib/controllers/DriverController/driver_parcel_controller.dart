import 'dart:io';

import 'package:get/get.dart';
import 'package:radeef/utils/image_utils.dart';

class DriverParcelController extends GetxController{

  Rx<File?> parcelImage = Rx<File?>(null);

  Future<void> pickParcelImage({bool fromCamera = true})async{

    final pickedFile = await ImageUtils.pickAndCropImage(fromCamera: fromCamera);
    if(pickedFile != null){
      parcelImage.value = pickedFile;
    }

  }


}