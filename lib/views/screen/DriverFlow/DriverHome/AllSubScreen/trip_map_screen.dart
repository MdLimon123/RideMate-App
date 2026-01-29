// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:radeef/controllers/UserController/trip_socket_controller.dart';
// import 'package:radeef/models/Driver/parcel_request_model.dart';
// import 'package:radeef/models/Driver/trip_request_model.dart';

// import 'package:radeef/service/api_constant.dart';

// class TrackDriverMapScreen extends StatefulWidget {
//   final bool isParcel;
//   final ParcelRequestModel? parcel;
//   final TripRequestModel? trip;
//   final ParcelUserModel? parcelUserModel;
//   final TripUserModel? tripUserModel;

//   const TrackDriverMapScreen({
//     super.key,
//     required this.isParcel,
//     this.parcel,
//     this.parcelUserModel,
//     this.trip,
//     this.tripUserModel,
//   });

//   @override
//   State<TrackDriverMapScreen> createState() => _TrackDriverMapScreenState();
// }

// class _TrackDriverMapScreenState extends State<TrackDriverMapScreen> {
//   final Set<Marker> _markers = {};
//   final Set<Polyline> _polylines = {};

//   final TripSocketController _tripSocketController = Get.put(
//     TripSocketController(),
//   );
//   Position? _currentPosition;

//   @override
//   void initState() {
//     _setupMarkers();
//     _drawPickupToDestination();
//     _initializeLocationTracking();
//     super.initState();
//   }

//   Future<void> _initializeLocationTracking() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       print('Location services are disabled.');
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         print('Location permissions are denied');
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       print('Location permissions are permanently denied');
//       return;
//     }
//     startLocationUpdates();
//   }

//   StreamSubscription<Position>? _positionStream;

//   void startLocationUpdates()async{

//     if (_positionStream != null) return;

//   // Get the current position first → immediate update
//   Position position = await Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.high,
//   );
//   _currentPosition = position;

//     LocationSettings locationSettings = const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 10,
//     );

//     _positionStream =
//         Geolocator.getPositionStream(locationSettings: locationSettings).listen(
//           (Position position) async {
//             _currentPosition = position;

//             String address = await getOptimizedAddress(
//               position.latitude,
//               position.longitude,
//             );
//             _tripSocketController.updateDriverLocation(
//               position.latitude,
//               position.longitude,
//               address,
//               widget.trip!.id,
//             );
//           },
//         );
//   }

//   String? _lastAddress;
//   DateTime? _lastAddressTime;

//   Future<String> getOptimizedAddress(double lat, double lng) async {
//     if (_lastAddressTime != null &&
//         DateTime.now().difference(_lastAddressTime!).inMinutes < 2) {
//       return _lastAddress!;
//     }

//     final placemarks = await placemarkFromCoordinates(lat, lng);
//     _lastAddress = placemarks.first.locality ?? 'Unknown';
//     _lastAddressTime = DateTime.now();
//     return _lastAddress!;
//   }

//   /// ================= MARKERS =================
//   void _setupMarkers() {
//     _markers.clear();
//     _markers.add(
//       Marker(
//         markerId: const MarkerId('driver'),
//         position: _currentPosition == null
//             ? LatLng(0, 0)
//             : LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       ),
//     );

//     _markers.add(
//       Marker(
//         markerId: const MarkerId('pickup'),
//         position: LatLng(widget.trip!.pickupLat, widget.trip!.pickupLng),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//       ),
//     );

//     _markers.add(
//       Marker(
//         markerId: const MarkerId('destination'),
//         position: LatLng(widget.trip!.dropoffLat, widget.trip!.dropoffLng),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       ),
//     );
//   }

//   /// ================= ROUTE =================
//   Future<RouteData?> _fetchRoute(
//     double startLat,
//     double startLng,
//     double endLat,
//     double endLng,
//   ) async {
//     final url =
//         'https://maps.googleapis.com/maps/api/directions/json?'
//         'origin=$startLat,$startLng&'
//         'destination=$endLat,$endLng&'
//         'key=${ApiConstant.googleApiKey}';

//     final response = await http.get(Uri.parse(url));
//     final data = json.decode(response.body);

//     if (data['routes'].isEmpty) return null;

//     final route = data['routes'][0];
//     final leg = route['legs'][0];

//     final encoded = route['overview_polyline']['points'];
//     final decoded = PolylinePoints.decodePolyline(encoded);

//     return RouteData(
//       points: decoded.map((e) => LatLng(e.latitude, e.longitude)).toList(),
//       duration: leg['duration']['text'],
//       distance: leg['distance']['text'],
//     );
//   }

//   /// ================= POLYLINES =================

//   /// ================= POLYLINES =================
//   Future<void> _drawPickupToDestination() async {
//     final route = await _fetchRoute(
//       widget.trip!.pickupLat,
//       widget.trip!.pickupLng,
//       widget.trip!.dropoffLat,
//       widget.trip!.dropoffLng,
//     );

//     if (route == null) return;

//     _polylines.add(
//       Polyline(
//         polylineId: const PolylineId('pickup_to_destination'),
//         points: route.points,
//         color: Colors.red,
//         width: 5,
//       ),
//     );

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _positionStream?.cancel();
//     super.dispose();
//   }

//   /// ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//               target: _currentPosition == null
//                   ? LatLng(0, 0)
//                   : LatLng(
//                       _currentPosition!.latitude,
//                       _currentPosition!.longitude,
//                     ),
//               zoom: 14,
//             ),

//             markers: _markers,
//             polylines: _polylines,
//             myLocationEnabled: false,
//           ),

//           Positioned(
//             top: 40,
//             left: 10,
//             child: SafeArea(
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: Get.back,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// ================= DATA MODEL =================
// class RouteData {
//   final List<LatLng> points;
//   final String duration;
//   final String distance;

//   RouteData({
//     required this.points,
//     required this.duration,
//     required this.distance,
//   });
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:radeef/controllers/UserController/trip_socket_controller.dart';
import 'package:radeef/models/Driver/parcel_request_model.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/views/base/custom_button.dart';

class TrackDriverMapScreen extends StatefulWidget {
  final bool isParcel;
  final ParcelRequestModel? parcel;
  final TripModel? trip;
  final ParcelUserModel? parcelUserModel;

  const TrackDriverMapScreen({
    super.key,
    required this.isParcel,
    this.parcel,
    this.parcelUserModel,
    this.trip,
  });

  @override
  State<TrackDriverMapScreen> createState() => _TrackDriverMapScreenState();
}

class _TrackDriverMapScreenState extends State<TrackDriverMapScreen> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final TripSocketController _tripSocketController = Get.put(
    TripSocketController(),
  );

  Position? _currentPosition;
  StreamSubscription<Position>? _positionStream;
  final Completer<GoogleMapController> _mapController = Completer();

  // Address caching
  String? _lastAddress;
  DateTime? _lastAddressTime;

  @override
  void initState() {
    super.initState();
    _setupMarkers();
    _drawPickupToDestination();
    _initializeLocationTracking();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  /// ================= LOCATION =================
  Future<void> _initializeLocationTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return;
    }

    startLocationUpdates();
  }

  void startLocationUpdates() async {
    if (_positionStream != null) return; // prevent duplicate stream

    // 1️⃣ Immediate first update
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _currentPosition = position;
    _updateDriverMarkerAndServer(position);

    // 2️⃣ Continuous updates every 10 meters
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // update only if moved 10m
    );

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
          (Position position) {
            _currentPosition = position;
            _updateDriverMarkerAndServer(position);
          },
        );
  }

  Future<void> _updateDriverMarkerAndServer(Position position) async {
    final driverLatLng = LatLng(position.latitude, position.longitude);

    // Update marker
    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'driver');
      _markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: driverLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    });

    // Move camera to follow driver
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(driverLatLng));

    // Send location to server
    String address = await _getOptimizedAddress(
      position.latitude,
      position.longitude,
    );
    _tripSocketController.updateDriverLocation(
      position.latitude,
      position.longitude,
      address,
      widget.trip!.id,
    );
  }

  Future<String> _getOptimizedAddress(double lat, double lng) async {
    if (_lastAddressTime != null &&
        DateTime.now().difference(_lastAddressTime!).inSeconds < 30 &&
        _lastAddress != null) {
      return _lastAddress!;
    }

    final placemarks = await placemarkFromCoordinates(lat, lng);
    _lastAddress = placemarks.first.locality ?? 'Unknown';
    _lastAddressTime = DateTime.now();
    return _lastAddress!;
  }

  /// ================= MARKERS =================
  void _setupMarkers() {
    _markers.clear();

    // Driver marker placeholder, will update on first location
    _markers.add(
      Marker(
        markerId: const MarkerId('driver'),
        position: _currentPosition == null
            ? LatLng(widget.trip!.pickupLat!, widget.trip!.pickupLng!)
            : LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('pickup'),
        position: LatLng(widget.trip!.pickupLat!, widget.trip!.pickupLng!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(widget.trip!.dropoffLat!, widget.trip!.dropoffLng!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  /// ================= ROUTE =================
  Future<RouteData?> _fetchRoute(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) async {
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=$startLat,$startLng&'
        'destination=$endLat,$endLng&'
        'key=${ApiConstant.googleApiKey}';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (data['routes'].isEmpty) return null;

    final route = data['routes'][0];
    final leg = route['legs'][0];

    final encoded = route['overview_polyline']['points'];
    final decoded = PolylinePoints.decodePolyline(encoded);

    return RouteData(
      points: decoded.map((e) => LatLng(e.latitude, e.longitude)).toList(),
      duration: leg['duration']['text'],
      distance: leg['distance']['text'],
    );
  }

  /// ================= POLYLINES =================
  Future<void> _drawPickupToDestination() async {
    final route = await _fetchRoute(
      widget.trip!.pickupLat!,
      widget.trip!.pickupLng!,
      widget.trip!.dropoffLat!,
      widget.trip!.dropoffLng!,
    );

    if (route == null) return;

    _polylines.add(
      Polyline(
        polylineId: const PolylineId('pickup_to_destination'),
        points: route.points,
        color: Colors.red,
        width: 5,
      ),
    );

    setState(() {});
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: _currentPosition == null
                  ? LatLng(widget.trip!.pickupLat!, widget.trip!.pickupLng!)
                  : LatLng(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    ),
              zoom: 14,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: false,
          ),
          Positioned(
            top: 40,
            left: 10,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: Get.back,
              ),
            ),
          ),

          // Positioned(
          //   bottom: 30, left: 20, right: 20,
          //   child: CustomButton(onTap: (){}
          //   , text: "Trip End"),
          // ),
        ],
      ),
    );
  }
}

/// ================= DATA MODEL =================
class RouteData {
  final List<LatLng> points;
  final String duration;
  final String distance;

  RouteData({
    required this.points,
    required this.duration,
    required this.distance,
  });
}
