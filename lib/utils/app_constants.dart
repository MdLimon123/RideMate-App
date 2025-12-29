import '../models/language_model.dart';

class AppConstants {
  static String APP_NAME = "project_template";

  // share preference Key
  static String THEME = "theme";

  static const String LANGUAGE_CODE = "languageCode";
  static const String COUNTRY_CODE = "countryCode";
  static const String bearerToken = "bearerToken";

  static RegExp emailValidator = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static RegExp passwordValidator = RegExp(
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
  );
  static List<LanguageModel> languages = [
    LanguageModel(
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      languageName: 'Português',
      countryCode: 'PT',
      languageCode: 'pt',
    ),
  ];
}
