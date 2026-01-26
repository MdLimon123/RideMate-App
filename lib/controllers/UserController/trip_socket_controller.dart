import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/models/Driver/trip_model.dart';
import 'package:radeef/models/Driver/trip_request_model.dart';
import 'package:radeef/models/User/driver_model.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/accept_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/confirmation_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/new_request_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/rate_pessengers_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/end_trip_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/find_driver_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/search_a_driver_screen.dart';

class TripSocketController extends GetxController {
  var isTripStarted = false.obs;
  var isTripEnded = false.obs;
  var isPaymentSuccessful = false.obs;

  void allDriverListeners() {
    listenOnRequestForTrip();
    listenOnTripPaid();
  }
  
  void allUserListeners() {
    listenOnAcceptedTrip();
    listenOnTripEnded();
    listenOnDriverCancelTrip();
    listenStartedTrip(onTripStarted: () {});
  }

  /// ======> user request for trip <====== ///
  void requestForTrip(var data) {
    SocketService().emit(
      'trip:new_request',
      data: data,
      ack: (res) {
        if (res['success']) {
          Get.to(
            () => SearchADriverScreen(
              pickLocation: res['data']["pickup_address"],
              dropLocation: res['data']["dropoff_address"],
              tripId: res['data']["id"],
            ),
          );
        } else {
          Get.snackbar(
            "Error",
            res['error'][0]?.message ?? "Failed to request trip",
          );
        }
      },
    );
  }

  /// ======> driver listen on request for trip <====== ///
  void listenOnRequestForTrip() {
    SocketService().on('trip:request', (data) {
      final socketModel = TripRequestSocketModel.fromJson(data);
      Get.to(
        () => NewRequestScreen(
          isParcel: false,
          trip: socketModel.trip,
          tripUserModel: socketModel.user,
        ),
      );
    });
  }

  /// ======> driver accept request for trip <====== ///
  void acceptTripRequest(var tripId, trip, tripUserModel) {
    SocketService().emit(
      'trip:accept',
      data: {"trip_id": tripId},
      ack: (a) {
        Get.to(
          () => AcceptScreen(
            isParcel: false,
            trip: trip,
            tripUserModel: tripUserModel,
          ),
        );
      },
    );
  }

  /// =====> user listen on accepted trip <====== ///
  void listenOnAcceptedTrip() {
    SocketService().on('trip:accepted', (data) {
      final driver = DriverModel.fromJson(data['driver']);
      final trip = TripModel.fromJson(data['trip']);
      // Navigate to FindDriverScreen
      Get.off(() => FindDriverScreen(driver: driver, trip: trip));
    });
  }

  /// ==== update driver trip location ==== ///
  void updateDriverLocation(
    double lat,
    double lng,
    String? address,
    var tripId,
  ) {
    SocketService().emit(
      'trip:refresh_location',
      data: {
        "location_lat": lat,
        "location_lng": lng,
        "location_address": address,
        "trip_id": tripId,
      },
    );
  }

  /// User listen on driver location ======= ///
  /// Listen for driver location updates
  void listenDriverLocation({
    required void Function(LatLng newLatLng) onLocationUpdate,
  }) {
    SocketService().on('trip:refresh_location', (data) async {
      final newLatLng = LatLng(data['location_lat'], data['location_lng']);
      onLocationUpdate(newLatLng);
    });
  }

  /// ====> driver trip started <==== ///
  void tripStarted({var tripId, required void Function() onTripStarted}) {
    SocketService().emit(
      "trip:start",
      data: {"trip_id": tripId},
      ack: (response) {
        isTripStarted.value = true;
        onTripStarted();
      },
    );
  }

  /// ========> user listen on driver trip started ==========///
  /// Listen for trip started event
  void listenStartedTrip({required void Function() onTripStarted}) {
    SocketService().on('trip:started', (data) {
      print("====== TRIP STARTED LISTENER CALLED ======");

      // Notify the caller that trip has started
      onTripStarted();
    });
  }

  /// ======> driver trip ended <====== ///
  void tripEnded(var tripId) {
    SocketService().emit(
      "trip:end",
      data: {"trip_id": tripId},
      ack: (response) {
        if (response['success']) {
          isTripStarted.value = false;
          isTripEnded.value = true;

          Get.to(
            () => ConfirmationScreen(
              tripData: TripDriverModel.fromJson(response['data']),
            ),
          );
        } else {
          showCustomSnackBar(
            response['error'][0]?.message ?? "Failed to end trip",
          );
        }
      },
    );
  }

  /// ========> user listen on driver trip ended ==========///

  void listenOnTripEnded() {
    SocketService().on('trip:ended', (data) {
      final driver = DriverModel.fromJson(data['driver']);
      final trip = TripModel.fromJson(data['trip']);
      isTripStarted.value = false;
      isTripEnded.value = true;
      Get.to(() => EndTripScreen(driver: driver, trip: trip));
    });
  }

  /// =====> user pay Trip ======///
  void payForTrip({
    required String tripId,
    required void Function(Map<String, dynamic> result) callback,
  }) {
    SocketService().emit(
      "trip:pay",
      data: {"trip_id": tripId},
      ack: (response) {
        isPaymentSuccessful.value = true;
        print("trip:pay response : $response");
        callback(response);
      },
    );
  }

  void listenOnTripPaid() {
    SocketService().on('trip:paid', (data) {
      print("trip:paid data : $data");
      isPaymentSuccessful.value = true;
      Get.to(
        () => RatePessengersScreen(
          userId: data['trip']["user"]["id"] ?? "",
          userName: data['trip']["user"]["name"] ?? "",
          userImage: data['trip']["user"]["avatar"] ?? "",
          tripId: data['trip']['id'] ?? "",
          rating: data['trip']["user"]["rating"] ?? 0.0,
          totalTrips: data['trip']["user"]["rating_count"] ?? 0,
        ),
      );
    });
  }

  /// =====> user cancel request for trip <====== ///

  void userCancelTrip(var tripId) {
    SocketService().emit(
      'trip:cancel',
      data: {"trip_id": tripId},
      ack: (response) {
        Get.back();
      },
    );
  }

  /// =====> driver listen on user cancel request for trip <====== ///

  void listenOnDriverCancelTrip() {
    SocketService().on("trip:canceled", (data) {
      print("trip:canceled : $data");
      Get.back();
    });
  }

  /// ======> driver cancel request for trip <====== ///
  void driverRejectTripRequest(var tripId) {
    SocketService().emit(
      'trip:driver_cancel',
      data: {"trip_id": tripId},
      ack: (response) {
        Get.back();
      },
    );
  }
}
