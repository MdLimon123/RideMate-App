import 'package:get/get.dart';
import 'package:radeef/models/Driver/trip_request_model.dart';
import 'package:radeef/models/User/driver_model.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/accept_screen.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/new_request_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/find_driver_screen.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/search_a_driver_screen.dart';

class TripSocketController extends GetxController {
  /// ======> user request for trip <====== ///
  void requestForTrip(var data) {
    SocketService().emit(
      'trip:new_request',
      data: data,
      ack: (d) {
        Get.to(
          () => SearchADriverScreen(
            pickLocation: d["pickup_address"],
            dropLocation: d["dropoff_address"],
            tripId: d["id"],
          ),
        );
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
  void listenTripDriverLocation() {
    


  }

 

  /// ======> driver cancel request for trip <====== ///
  void cancelTrip(var tripId) {
    SocketService().emit(
      'trip:cancel',
      data: {"trip_id": tripId},
      ack: (response) {
        Get.back();
      },
    );
  }
}
