import 'package:get/get.dart';

import 'package:radeef/models/parcel_model.dart';

import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';
import 'package:radeef/views/screen/DriverFlow/parcel/driver_parcel_accepted.dart';
import 'package:radeef/views/screen/DriverFlow/parcel/driver_parcel_confirm.dart';
import 'package:radeef/views/screen/DriverFlow/parcel/driver_parcel_request.dart';
import 'package:radeef/views/screen/DriverFlow/parcel/final_parcel_earn.dart';
import 'package:radeef/views/screen/DriverFlow/parcel/parcel_rate_for_user.dart';
import 'package:radeef/views/screen/UserFLow/ParcelScreen/end_parcel_screen.dart';
import 'package:radeef/views/screen/UserFLow/ParcelScreen/find_parcel_driver_screen.dart';
import 'package:radeef/views/screen/UserFLow/ParcelScreen/search_parcel_driver_screen.dart';
import 'package:radeef/views/screen/UserFLow/ParcelScreen/user_rating_for_parcel_screen.dart';

import 'package:radeef/views/screen/UserFLow/UserHome/user_home_screen.dart';

enum ParcelState {
  idle,
  REQUESTED,
  ACCEPTED,
  STARTED,
  DELIVERED,
  COMPLETED,
  CANCELLED,
}

class ParcelStateController extends GetxController {
  static ParcelStateController get to => Get.find();

  // ================= STATE =================
  final Rx<ParcelState> parcelState = ParcelState.idle.obs;
  final Rx<ParcelModel?> parcel = Rx<ParcelModel?>(null);
  final RxBool isDriver = false.obs;

  // ================= ROLE =================
  void setRole({required bool driver}) {
    isDriver.value = driver;
  }

  // ================= SET FULL TRIP =================
  void setParcel(ParcelModel parcelData) {
    parcel.value = parcelData;
    updateParcelStatus(parcel.value!.status!);
  }

  // ================= UPDATE STATUS ONLY =================
  void updateParcelStatus(ParcelState status) {
    parcelState.value = status;
    _handleRouting(status);
  }

  // ================= CLEAR TRIP =================
  void clearParcel() {
    parcel.value = null;
    parcelState.value = ParcelState.idle;
    _handleRouting(ParcelState.idle);
  }

  // ================= ROUTING CORE =================
  void _handleRouting(ParcelState status) {
    if (isDriver.value) {
      _driverFlow(status);
    } else {
      _userFlow(status);
    }
  }

  // ================= USER FLOW =================
  void _userFlow(ParcelState status) {
    switch (status) {
      case ParcelState.idle:
        Get.offAll(UserHomeScreen());
        break;
      case ParcelState.REQUESTED:
        Get.offAll(SearchParcelDriverScreen());
        break;

      case ParcelState.ACCEPTED:
        Get.offAll(FindParcelDriverScreen());
        break;

      case ParcelState.STARTED:
        Get.offAll(FindParcelDriverScreen());
        break;
      case ParcelState.DELIVERED:
        Get.offAll(EndParcelScreen());
      case ParcelState.COMPLETED:
        Get.offAll(UserRatingForParcelScreen());
        break;
      default:
        clearParcel();
        Get.offAll(UserHomeScreen());
    }
  }

  // ================= DRIVER FLOW =================
  
  void _driverFlow(ParcelState status) {
    switch (status) {
      case ParcelState.idle:
        Get.offAll(DriverHomeScreen());
        break;

      case ParcelState.REQUESTED:
        Get.offAll(DriverParcelRequest());
        break;

      case ParcelState.ACCEPTED:
        Get.offAll(DriverParcelAccepted());
        break;

      case ParcelState.STARTED:
        Get.offAll(DriverParcelAccepted());
        break;

      case ParcelState.DELIVERED:
        Get.offAll(DriverParcelConfirmationScreen());
        break;
      case ParcelState.COMPLETED:
        Get.offAll(ParcelRatePessengersScreen());
        break;
      default:
        clearParcel();
        Get.offAll(DriverHomeScreen());
    }
  }
}
