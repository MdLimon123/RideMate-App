import 'package:get/get.dart';

class SplashController extends GetxController{

  var selectRole = "".obs;

  void setRole(String role){
    selectRole.value = role;
  }

}