import 'package:get/get.dart';

class EaringController extends GetxController{

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

}