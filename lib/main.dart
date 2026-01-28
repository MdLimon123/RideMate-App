import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:radeef/controllers/UserController/tripstate_controller.dart';
import 'package:radeef/controllers/localization_controller.dart';
import 'package:radeef/controllers/parcel_state.dart';
import 'package:radeef/controllers/theme_controller.dart';
import 'package:radeef/helpers/di.dart' as GetStorage;
import 'package:radeef/service/notification_service.dart';
import 'package:radeef/service/prefs_helper.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/themes/light_theme.dart';
import 'package:radeef/utils/app_constants.dart';
import 'package:radeef/utils/message.dart';

import 'helpers/di.dart' as di;
import 'helpers/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await OneSignalHelper.initialize();

  await GetStorage.init();
  final token = await PrefsHelper.getToken();

  if (token != null && token.isNotEmpty) {
    SocketService().connect(token);
  }
  Get.put(TripStateController(), permanent: true);
  Get.put(ParcelStateController(), permanent: true);

  Map<String, Map<String, String>> _languages = await di.init();
  runApp(MyApp(languages: _languages));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return ScreenUtilInit(
              designSize: const Size(393, 852),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return GetMaterialApp(
                  title: AppConstants.APP_NAME,
                  debugShowCheckedModeBanner: false,
                  navigatorKey: Get.key,
                  // theme: themeController.darkTheme ? dark(): light(),
                  theme: light(),
                  defaultTransition: Transition.rightToLeft,
                  locale: localizeController.locale,
                  translations: Messages(languages: languages),

                  fallbackLocale: Locale(
                    AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode,
                  ),
                  transitionDuration: const Duration(milliseconds: 500),
                  getPages: AppRoutes.page,
                  initialRoute: AppRoutes.splashScreen,
             
                );
              },
            );
          },
        );
      },
    );
  }
}
