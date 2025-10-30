import 'package:get/get.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_forget_password_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_login_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_otp_verify_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_reset_password_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_signup_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverAuth/driver_terms_condition_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverEarn/driver_earn_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverProfile/driver_profile_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverRides/driver_riders_screen.dart';
import 'package:radeef/views/screen/Splash/select_role_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/select_language_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/terms_condition_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/user_forget_password_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/user_login_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/user_otp_verify_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/user_reset_password_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserAuth/user_signup_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/user_home_screen.dart';
import '../views/screen/Splash/splash_screen.dart';

class AppRoutes{

  static String splashScreen="/splash_screen";
  static String selectRole = "/select_role";
  static String homeScreen="/home_screen";
  static String profileScreen="/profile_screen";
  static String walletScreen="/wallet_screen";
  static String selectUserLanguage = "/select_user_language";
  static String userLoginScreen = "/user_login_screen";
  static String userSignUpScreen = "/user_sign_up_screen";
  static String userForgotPasswordScreen = "/user_forgot_password_screen";
  static String userTermsConditionScreen = "/user_terms_condition_screen";
  static String userOtpVerifyScreen = "/user_otp_verify_screen";
  static String userResetPasswordScreen = "/user_reset_password_screen";
  static String userHomeScreen = "/user_home_screen";
  static String driverLoginScreen = "/driver_login_screen";
  static String driverSignUpScreen = "/driver_sign_up_screen";
  static String driverForgotPasswordScreen = "/driver_forgot_password_screen";
  static String driverOtpVerifyScreen = "/driver_otp_verify_screen";
  static String driverResetPasswordScreen = "/driver_reset_password_screen";
  static String driverTermsConditionScreen = "/driver_terms_condition_screen";
  static String driverHomeScreen = "/driver_home_screen";
  static String driverProfileScreen = "/driver_profile_screen";
  static String driverRidesScreen = "/driver_rides_screen";
  static String driverEarnScreen = "/driver_earn_screen";







 static List<GetPage> page=[
    GetPage(name:splashScreen, page: ()=>const SplashScreen()),
   GetPage(name:selectRole, page: ()=>const SelectRoleScreen(),transition: Transition.noTransition),
   GetPage(name:selectUserLanguage, page: ()=>const SelectUserLanguageScreen(),transition: Transition.noTransition),
   GetPage(name:userLoginScreen, page: ()=>const UserLoginScreen(),transition: Transition.noTransition),
   GetPage(name:userSignUpScreen, page: ()=>const UserSignupScreen(),transition: Transition.noTransition),
   GetPage(name:userTermsConditionScreen, page: ()=>const TermsConditionScreen(),transition: Transition.noTransition),
   GetPage(name:userForgotPasswordScreen, page: ()=>const UserForgetPasswordScreen(),transition: Transition.noTransition),
   GetPage(name: userOtpVerifyScreen, page: ()=> const UserOtpVerifyScreen(),transition: Transition.noTransition),
   GetPage(name: userResetPasswordScreen, page: ()=> const UserResetPasswordScreen(), transition: Transition.noTransition),
   GetPage(name: userHomeScreen, page: ()=> const UserHomeScreen(), transition: Transition.noTransition),
   GetPage(name: driverLoginScreen, page: ()=> const DriverLoginScreen(), transition: Transition.noTransition),
   GetPage(name: driverSignUpScreen, page: ()=> const DriverSignupScreen(), transition: Transition.noTransition),
   GetPage(name: driverForgotPasswordScreen, page: ()=> const DriverForgetPasswordScreen(), transition: Transition.noTransition),
   GetPage(name: driverOtpVerifyScreen, page: ()=> const DriverOtpVerifyScreen(), transition: Transition.noTransition),
   GetPage(name: driverResetPasswordScreen, page: ()=> const DriverResetPasswordScreen(), transition: Transition.noTransition),
   GetPage(name: driverTermsConditionScreen, page: ()=> const DriverTermsConditionScreen(), transition: Transition.noTransition),
   GetPage(name: driverHomeScreen, page: ()=> const DriverHomeScreen(), transition: Transition.noTransition),
   GetPage(name: driverProfileScreen, page: ()=> const DriverProfileScreen(), transition: Transition.noTransition),
   GetPage(name: driverRidesScreen, page: ()=> const DriverRidersScreen(), transition: Transition.noTransition),
   GetPage(name: driverEarnScreen, page: ()=> const DriverEarnScreen(), transition: Transition.noTransition),


  ];



}