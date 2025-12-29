import 'package:get/get.dart';

class LanguageController extends GetxController{


  var isExpanded = false.obs;
  var selectedLanguage = 'English'.obs;

  List<String> languages = ['English', 'Português'];

  void selectLanguage(String lang) {
    selectedLanguage.value = lang;
  }

}