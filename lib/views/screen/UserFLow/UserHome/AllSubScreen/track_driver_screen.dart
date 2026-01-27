import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:radeef/controllers/UserController/trip_socket_controller.dart';
import 'package:radeef/controllers/UserController/tripstate_controller.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/service/socket_service.dart';

class TrackDriverScreen extends StatefulWidget {
  final double pickLat;
  final double pickLan;
  final double dropLat;
  final double dropLan;
  final String dropAddress;
  final Driver driver;
  final TripModel trip;

  const TrackDriverScreen({
    super.key,
    required this.pickLat,
    required this.pickLan,
    required this.dropLat,
    required this.dropLan,
    required this.dropAddress,
    required this.driver,
    required this.trip,
  });

  @override
  State<TrackDriverScreen> createState() => _TrackDriverScreenState();
}

class _TrackDriverScreenState extends State<TrackDriverScreen> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final TripSocketController _tripSocketController = Get.put(
    TripSocketController(),
  );

  LatLng? _driverLatLng;

  @override
  void initState() {
    _driverLatLng = LatLng(
      widget.driver.locationLat!,
      widget.driver.locationLng!,
    );

    _setupMarkers();
    _drawPickupToDestination();
    _listenDriverLocation();
    print("====== isTripStarted ${widget.trip.status}");
    if (widget.trip.status != TripStatus.STARTED) _drawDriverToPickup();
    listenStartedTrip();
    super.initState();
  }

  /// ================= MARKERS =================
  void _setupMarkers() {
    _markers.clear();

    _markers.add(
      Marker(
        markerId: const MarkerId('driver'),
        position: _driverLatLng!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('pickup'),
        position: LatLng(widget.pickLat, widget.pickLan),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(widget.dropLat, widget.dropLan),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  /// ================= SOCKET =================
  void _listenDriverLocation() async {
    _tripSocketController.listenDriverLocation(
      onLocationUpdate: (newLatLng) async {
        setState(() {
          _driverLatLng = newLatLng;
          // 🔴 ONLY update driver marker
          _markers.removeWhere((m) => m.markerId.value == 'driver');

          _markers.add(
            Marker(
              markerId: const MarkerId('driver'),
              position: _driverLatLng!,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
            ),
          );
        });

        if (!_tripSocketController.isTripStarted.value) {
          await _drawDriverToPickup();
        }
      },
    );

    // SocketService().on('trip:refresh_location', (data) async {
    //   final newLatLng = LatLng(data['location_lat'], data['location_lng']);

    //   setState(() {
    //     _driverLatLng = newLatLng;

    //     // 🔴 ONLY update driver marker
    //     _markers.removeWhere((m) => m.markerId.value == 'driver');

    //     _markers.add(
    //       Marker(
    //         markerId: const MarkerId('driver'),
    //         position: _driverLatLng!,
    //         icon: BitmapDescriptor.defaultMarkerWithHue(
    //           BitmapDescriptor.hueBlue,
    //         ),
    //       ),
    //     );
    //   });
    //   // pickup শুরু না হলে route draw করো
    //   if (!_isPickupStarted) {
    //     await _drawDriverToPickup();
    //   }
    // });
  }

  void listenStartedTrip() {
    _tripSocketController.listenStartedTrip(
      onTripStarted: () {
        setState(() {
          _tripSocketController.isTripStarted.value = true;
          print(
            "====== TRIP STARTED ${_tripSocketController.isTripStarted.value}",
          );

          // 🔴 FORCE REMOVE
          _polylines.removeWhere(
            (p) => p.polylineId.value == 'driver_to_pickup',
          );
        });
      },
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
  Future<void> _drawDriverToPickup() async {
    if (_tripSocketController.isTripStarted.value) return;

    // 🔴 REMOVE FIRST
    _polylines.removeWhere((p) => p.polylineId.value == 'driver_to_pickup');

    final route = await _fetchRoute(
      _driverLatLng!.latitude,
      _driverLatLng!.longitude,
      widget.pickLat,
      widget.pickLan,
    );

    // 🔴 CHECK AGAIN AFTER AWAIT
    if (route == null || _tripSocketController.isTripStarted.value) return;

    _polylines.add(
      Polyline(
        polylineId: const PolylineId('driver_to_pickup'),
        points: route.points,
        color: Colors.blue,
        width: 5,
      ),
    );

    setState(() {});
  }

  /// ================= POLYLINES =================
  Future<void> _drawPickupToDestination() async {
    final route = await _fetchRoute(
      widget.pickLat,
      widget.pickLan,
      widget.dropLat,
      widget.dropLan,
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

  @override
  void dispose() {
    SocketService().off('trip:refresh_location');
    super.dispose();
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _driverLatLng!,
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
          //   bottom: 30,
          //   left: 30,
          //   right: 30,
          //   child: InkWell(
          //     onTap: () {
          //       Get.to(
          //         () => EndTripScreen(driver: widget.driver, trip: widget.trip),
          //       );
          //     },
          //     child: Container(
          //       padding: const EdgeInsets.all(14),
          //       decoration: BoxDecoration(
          //         color: Colors.red,
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       child: const Center(
          //         child: Text(
          //           "End Trip",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
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
