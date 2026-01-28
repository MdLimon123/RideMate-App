import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/controllers/UserController/tripstate_controller.dart';
import 'package:radeef/controllers/parcel_state.dart';
import 'package:radeef/models/Driver/driver_profile_model.dart';

import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/models/User/user_profile_model.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/views/base/custom_snackbar.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/accept_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/confirmation_screen.dart';

import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/search_a_driver_screen.dart';

import '../../models/parcel_model.dart';

class TripSocketController extends GetxController {
  var isTripStarted = false.obs;
  var isPaymentSuccessful = false.obs;

  var currentDriver = Rxn<DriverProfileModel>();
  var currentUser = Rxn<UserProfileModel>();

  void allDriverListeners() {
    listenOnRequestForTrip();
    listenOnTripPaid();
    listenOnDriverCancelTrip();
  }

  void allUserListeners() {
    listenOnAcceptedTrip();
    listenOnTripEnded();
    listenStartedTrip(
      onTripStarted: () {
        print("====== TRIP STARTED CALLBACK CALLED ======");
        TripStateController.to.updateTripStatus(TripStatus.STARTED);
      },
    );
  }

  /// ======> recover trip data <====== ///

  // Future<void> recoverTripData() async {
  //   final response = await ApiClient.getData('/trips/recover-trip');
  //   if (response.statusCode == 200) {
  //     if (response.body['data'] != null) {
  //       TripStateController.to.setTrip(TripModel.fromJson(response.body));
  //     } else {
  //       TripStateController.to.setTrip(TripModel.fromJson(response.body));
  //     }
  //   } else {
  //     TripStateController.to.updateTripStatus(TripStatus.idle);
  //   }
  // }

  Future<void> recoverTripData() async {
    final response = await ApiClient.getData('/trips/recover-trip');

    if (response.statusCode == 200) {
      final body = response.body;

      if (body['data'] != null) {
        final tripJson = body['data'];

        TripStateController.to.setTrip(TripModel.fromJson(tripJson));
      } else {
        TripStateController.to.updateTripStatus(TripStatus.idle);
      }
    } else {
      TripStateController.to.updateTripStatus(TripStatus.idle);
    }
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
      final trip = TripModel.fromJson(data['trip']);
      TripStateController.to.setTrip(trip);
    });
  }

  /// ======> driver accept request for trip <====== ///
  void acceptTripRequest(var tripId) {
    SocketService().emit(
      'trip:accept',
      data: {"trip_id": tripId},
      ack: (a) {
        print("Trip accepted ack: $a");

        final trip = TripModel.fromJson(a['data']);

        Get.offAll(() => AcceptScreen(isParcel: false, trip: trip));
      },
    );
  }

  /// =====> user listen on accepted trip <====== ///
  void listenOnAcceptedTrip() {
    SocketService().on('trip:accepted', (data) {
      // final driver = DriverModel.fromJson(data['driver']);
      // final trip = TripModel.fromJson(data['trip']);
      // // Navigate to FindDriverScreen
      // Get.off(() => FindDriverScreen(driver: driver, trip: trip));

      final trip = TripModel.fromJson(data['trip']);
      TripStateController.to.setTrip(trip);
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

          Get.offAll(
            () => ConfirmationScreen(
              tripData: TripModel.fromJson(response['data']),
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
      final trip = TripModel.fromJson(data['trip']);
      TripStateController.to.setTrip(trip);
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
      isPaymentSuccessful.value = true;
      final trip = TripModel.fromJson(data['trip']);
      TripStateController.to.setTrip(trip);
    });
  }

  /// =====> user cancel request for trip <====== ///

  void userCancelTrip(var tripId) {
    print("===== Emitting trip:cancel for tripId: $tripId =====");
    SocketService().emit(
      'trip:cancel',
      data: {"trip_id": tripId},
      ack: (response) {
        TripStateController.to.clearTrip();
      },
    );
  }

  /// =====> driver listen on user cancel request for trip <====== ///

  void listenOnDriverCancelTrip() {
    SocketService().on("trip:canceled", (data) {
      print("===== Driver received trip:canceled =====${data}");
      TripStateController.to.clearTrip();
    });
  }

  /// ======> driver cancel request for trip <====== ///
  void driverRejectTripRequest(var tripId) {
    SocketService().emit(
      'trip:driver_cancel',
      data: {"trip_id": tripId},
      ack: (response) {
        print("Driver canceled trip ack: $response");
        Get.back();
      },
    );
  }

  /// ===== USER TRIP RECOVER Listen ======= ///
  //

  @override
  void onClose() {
    print("🔴 TripSocketController DISPOSE");

    // USER listeners
    SocketService().off('trip:accepted');
    SocketService().off('trip:started');
    SocketService().off('trip:ended');
    SocketService().off('trip:canceled');
    SocketService().off('trip:refresh_location');
    // DRIVER listeners
    SocketService().off('trip:request');
    SocketService().off('trip:paid');
    super.onClose();
  }
}
