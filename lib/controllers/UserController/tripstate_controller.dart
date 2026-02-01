import 'package:get/get.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/accept_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/new_request_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/payment_wating_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/rate_pessengers_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/driver_home_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/end_trip_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/find_driver_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/search_a_driver_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/user_rating_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/user_home_screen.dart';

enum TripStatus {
  idle,
  REQUESTED,
  ACCEPTED,
  STARTED,
  ARRIVED,
  COMPLETED,
  CANCELLED,
}

class TripStateController extends GetxController {
  static TripStateController get to => Get.find();

  // ================= STATE =================
  final Rx<TripStatus> tripStatus = TripStatus.idle.obs;
  final Rx<TripModel?> trip = Rx<TripModel?>(null);
  final RxBool isDriver = false.obs;

  // ================= ROLE =================
  void setRole({required bool driver}) {
    isDriver.value = driver;
  }

  // ================= SET FULL TRIP =================
  void setTrip(TripModel tripData) {
    trip.value = tripData;
    updateTripStatus(tripData.status!);
  }

  // ================= UPDATE STATUS ONLY =================
  void updateTripStatus(TripStatus status) {
    tripStatus.value = status;
    _handleRouting(status);
  }

  // ================= CLEAR TRIP =================
  void clearTrip() {
    trip.value = null;
    tripStatus.value = TripStatus.idle;
    _handleRouting(TripStatus.idle);
  }

  // ================= ROUTING CORE =================
  void _handleRouting(TripStatus status) {
    if (isDriver.value) {
      _driverFlow(status);
    } else {
      _userFlow(status);
    }
  }

  // ================= USER FLOW =================
  void _userFlow(TripStatus status) {
    switch (status) {
      case TripStatus.idle:
        Get.offAll(UserHomeScreen());
        break;
      case TripStatus.REQUESTED:
        Get.offAll(
          SearchADriverScreen(
            pickLocation: trip.value!.pickupAddress!,
            dropLocation: trip.value!.dropoffAddress!,
            tripId: trip.value!.id!,
          ),
        );
        break;

      case TripStatus.ACCEPTED:
        Get.offAll(
          FindDriverScreen(trip: trip.value!, driver: trip.value!.driver!),
        );
        break;

      case TripStatus.STARTED:
        Get.offAll(
          FindDriverScreen(trip: trip.value!, driver: trip.value!.driver!),
        );
        break;

      case TripStatus.ARRIVED:
        Get.offAll(
          EndTripScreen(driver: trip.value!.driver!, trip: trip.value!),
        );
      case TripStatus.COMPLETED:
        Get.offAll(
          UserRatingScreen(
            drivierImage: trip.value!.driver!.avatar!,
            driverName: trip.value!.driver!.name!,
            trip: trip.value!.driver!.tripGivenCount!,
            rating: trip.value!.driver!.rating!,
            tripModel: trip.value!,
          ),
        );
        break;
      default:
        clearTrip();
        Get.offAll(UserHomeScreen());
    }
  }

  // ================= DRIVER FLOW =================
  void _driverFlow(TripStatus status) {
    switch (status) {
      case TripStatus.idle:
        Get.offAll(DriverHomeScreen());
        break;

      case TripStatus.REQUESTED:
        Get.offAll(NewRequestScreen(isParcel: false, trip: trip.value!));
        break;

      case TripStatus.ACCEPTED:
        Get.offAll(AcceptScreen(isParcel: false, trip: trip.value!));
        break;

      case TripStatus.STARTED:
        Get.offAll(AcceptScreen(isParcel: false, trip: trip.value!));
        break;

      case TripStatus.ARRIVED:
     
        Get.offAll(() => PaymentWatingScreen());
        break;
      case TripStatus.COMPLETED:
        Get.offAll(
          RatePessengersScreen(
            userId: trip.value!.user!.id!,
            userName: trip.value!.user!.name!,
            userImage: trip.value!.user!.avatar!,
            rating: trip.value!.user!.rating!,
            totalTrips: trip.value!.user!.tripReceivedCount!,
            tripId: trip.value!.id!,
          ),
        );
        break;
      default:
        clearTrip();
        Get.offAll(DriverHomeScreen());
    }
  }
}
