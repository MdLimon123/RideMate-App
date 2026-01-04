import 'package:get/get.dart';
import 'package:radeef/helpers/route.dart';
import 'package:radeef/service/prefs_helper.dart';
import 'package:radeef/utils/app_constants.dart';
import 'package:radeef/views/base/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response, {bool getXSnackBar = false})async{

    if(response.statusCode != 200){
      if(response.statusCode == 401) {
        await PrefsHelper.remove(AppConstants.bearerToken);
        Get.offAllNamed(AppRoutes.splashScreen);
      }else {
        showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);

      }

    }


  }
}