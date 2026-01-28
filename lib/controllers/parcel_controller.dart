import 'dart:io';

import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/controllers/parcel_state.dart';
import 'package:radeef/models/parcel_model.dart';
import 'package:radeef/service/api_client.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/views/base/custom_snackbar.dart';

class ParcelController extends GetxController {
  final RxBool loading = false.obs;

  var isParcelStarted = false.obs;

  void allDriverParcelListeners() {
    listenOnRequestForParcel();
    listenOnParcelPaid();
    listenOnDriverCancelParcel();
  }

  void allParcelUserListeners() {
    listenOnAcceptedParcel();
    listernOnParcelEnded();
    listenStartedParcel(
      onParcelStarted: () {
        print("====== PARCEL STARTED CALLBACK CALLED ======");
        ParcelStateController.to.updateParcelStatus(ParcelState.STARTED);
      },
    );
  }

  // Future<void> recoverParcelData() async {
  //   loading(true);
  //   final response = await ApiClient.getData('/trips/recover-trip');
  //   if (response.statusCode == 200) {
  //     if (response.body['data'] != null) {
  //       ParcelStateController.to.setParcel(ParcelModel.fromJson(response.body));
  //     } else {
  //       ParcelStateController.to.setParcel(ParcelModel.fromJson(response.body));
  //     }
  //   } else {
  //     debugPrint("No active parcel found");
  //   }
  //   loading(false);
  // }

  Future<void> recoverParcelData() async {
    loading(true);

    final response = await ApiClient.getData('/trips/recover-trip');

    if (response.statusCode == 200) {
      final body = response.body;

      if (body['isParcel'] == true && body['data'] != null) {
        final parcelJson = body['data'];

        ParcelStateController.to.setParcel(ParcelModel.fromJson(parcelJson));
      } else {
        debugPrint("Recovered data is not parcel");
      }
    } else {
      debugPrint("No active parcel found");
    }

    loading(false);
  }

  /// ======> user request for parcel <====== ///
  void requestForParcel(var data) {
    SocketService().emit(
      'parcel:new_request',
      data: data,
      ack: (res) {
        /// navigate to search a driver screen
      },
    );
  }

  /// ======> driver listen on request for parcel <====== ///
  void listenOnRequestForParcel() {
    SocketService().on('parcel:request', (data) {
      final parcel = ParcelModel.fromJson(data['parcel']);
      ParcelStateController.to.setParcel(parcel);
    });
  }

  /// ======> driver accept request for parcel <====== ///
  void acceptParcelRequest(var parcelId) {
    SocketService().emit(
      'parcel:accept',
      data: {"parcel_id": parcelId},
      ack: (res) {
        /// navigate to confirmation screen
      },
    );
  }

  /// ======> user listen on accepted parcel <====== ///
  void listenOnAcceptedParcel() {
    SocketService().on('parcel:accepted', (data) {
      final parcel = ParcelModel.fromJson(data['parcel']);
      ParcelStateController.to.setParcel(parcel);
    });
  }

  /// =======> Update Driver Parcel Location <======= ///
  void updateDriverParcelLocation(
    double lat,
    double lng,
    String? address,
    var parcelId,
  ) {
    SocketService().emit(
      'parcel:refresh_location',
      data: {
        "location_lat": lat,
        "location_lng": lng,
        "address": address,
        "parcel_id": parcelId,
      },
    );
  }

  /// =======> User Listen on Driver Parcel Location <======= ///
  ///

  void listenDriverParcelLocation({
    required void Function(LatLng newLatLng) onLocationUpdate,
  }) {
    SocketService().on('parcel:refresh_location', (data) {
      final newLatLng = LatLng(data['location_lat'], data['location_lng']);
      onLocationUpdate(newLatLng);
    });
  }

  /// ======> Driver Parcel Started <=======
  void parcelStarted({var parcelId, required Function() onParcelStarted}) {
    SocketService().emit(
      'parcel:start',
      data: {"parcel_id": parcelId},
      ack: (res) {
        isParcelStarted(true);
        onParcelStarted();
      },
    );
  }

  /// ========> user listen on driver parcel started ==========///
  void listenStartedParcel({required Function() onParcelStarted}) {
    SocketService().on('parcel:started', (data) {
      onParcelStarted();
    });
  }

  //// ======> Driver Parcel Ended <======= ///
  void parcelEnded({var parcelId, File? imageFile}) {
    SocketService().emit(
      'parcel:deliver',
      data: {"parcel_id": parcelId, "files": imageFile},
      ack: (res) {
        if (res['success']) {
          isParcelStarted.value = false;
        } else {
          showCustomSnackBar("Failed to end parcel");
        }
      },
    );
  }

  /// =====> user listen on driver parcel ended <====== ///

  void listernOnParcelEnded() {
    SocketService().on('parcel:delivered', (data) {
      final parcel = ParcelModel.fromJson(data['parcel']);
      ParcelStateController.to.setParcel(parcel);
    });
  }

  /// ======> user pay Parcel  <====== ///
  void payForParcel({
    required String parcelId,
    required void Function(Map<String, dynamic> result) callback,
  }) {
    SocketService().emit(
      "parcel:pay",
      data: {"parcel_id": parcelId},
      ack: (response) {
        callback(response);
      },
    );
  }

  /// ========> driver listen on parcel paid ==========///

  void listenOnParcelPaid() {
    SocketService().on('parcel:paid', (data) {
      final parcel = ParcelModel.fromJson(data['parcel']);
      ParcelStateController.to.setParcel(parcel);
    });
  }

  /// ======> user cancel parcel request <====== ///

  void userCancelParcelRequest(var parcelId) {
    SocketService().emit(
      "parcel:driver_cancel",
      data: {"parcel_id": parcelId},
      ack: (response) {
        ParcelStateController.to.clearParcel();
      },
    );
  }

  /// ======> driver listen on user cancel request for parcel <====== ///

  void listenOnDriverCancelParcel() {
    SocketService().on('parcel:cancelled', (data) {
      final parcel = ParcelModel.fromJson(data['parcel']);
      ParcelStateController.to.setParcel(parcel);
    });
  }

  /// ======> driver cancel parcel request <====== ///

  void driverCancelParcelRequest(var parcelId) {
    SocketService().emit(
      "parcel:driver_cancel",
      data: {"parcel_id": parcelId},
      ack: (response) {
        ParcelStateController.to.clearParcel();
      },
    );
  }
}
