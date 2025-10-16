import 'package:get/get.dart';
import 'package:radeef/views/screen/Home/home_screen.dart';
import 'package:radeef/views/screen/Profile/profile_screen.dart';
import 'package:radeef/views/screen/Splash/select_role_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/select_language_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/user_login_screen.dart';
import 'package:radeef/views/screen/Wallet/wallet_screen.dart';
import '../views/screen/Splash/splash_screen.dart';

class AppRoutes{

  static String splashScreen="/splash_screen";
  static String selectRole = "/select_role";
  static String homeScreen="/home_screen";
  static String profileScreen="/profile_screen";
  static String walletScreen="/wallet_screen";
  static String selectUserLanguage = "/select_user_language";
  static String userLoginScreen = "/user_login_screen";


 static List<GetPage> page=[
    GetPage(name:splashScreen, page: ()=>const SplashScreen()),
    GetPage(name:homeScreen, page: ()=>const HomeScreen(),transition:Transition.noTransition),
    GetPage(name:walletScreen, page: ()=>const WalletScreen(),transition:Transition.noTransition),
    GetPage(name:profileScreen, page: ()=>const ProfileScreen(),transition: Transition.noTransition),
   GetPage(name:selectRole, page: ()=>const SelectRoleScreen(),transition: Transition.noTransition),
   GetPage(name:selectUserLanguage, page: ()=>const SelectUserLanguageScreen(),transition: Transition.noTransition),
   GetPage(name:userLoginScreen, page: ()=>const UserLoginScreen(),transition: Transition.noTransition),
  ];



}