import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/controllers/parcel_controller.dart';
import 'package:radeef/controllers/parcel_state.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/trip_map_screen.dart';
import 'package:http/http.dart' as http;

class TrackParcelDriverScreen extends StatefulWidget {
  const TrackParcelDriverScreen({super.key});

  @override
  State<TrackParcelDriverScreen> createState() =>
      _TrackParcelDriverScreenState();
}

class _TrackParcelDriverScreenState extends State<TrackParcelDriverScreen> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final _parcelController = Get.put(ParcelController());
  final _parcelStateController = Get.put(ParcelStateController());

  LatLng? _driverLatLng;

  @override
  void initState() {
    _driverLatLng = LatLng(
      _parcelStateController.parcel.value!.driver!.locationLat!,
      _parcelStateController.parcel.value!.driver!.locationLng!,
    );

    _setupMarkers();
    _drawPickupToDestination();
    _listenParcelDriverLocation();

    if (_parcelStateController.parcel.value!.status != ParcelState.STARTED)
      _drawDriverToPickup();
    ;
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
        position: LatLng(
          _parcelStateController.parcel.value!.pickupLat!,
          _parcelStateController.parcel.value!.pickupLng!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    _markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(
          _parcelStateController.parcel.value!.dropoffLat!,
          _parcelStateController.parcel.value!.dropoffLng!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  /// ================= SOCKET =================
  void _listenParcelDriverLocation() async {
    _parcelController.listenDriverParcelLocation(
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

        if (!_parcelController.isParcelStarted.value) {
          await _drawDriverToPickup();
        }
      },
    );
  }

  void listenStartedParcel() {
    _parcelController.listenStartedParcel(
      onParcelStarted: () {
        setState(() {
          _parcelController.isParcelStarted.value = true;
          print(
            "====== TRIP STARTED ${_parcelController.isParcelStarted.value}",
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
    if (_parcelController.isParcelStarted.value) return;

    // 🔴 REMOVE FIRST
    _polylines.removeWhere((p) => p.polylineId.value == 'driver_to_pickup');

    final route = await _fetchRoute(
      _driverLatLng!.latitude,
      _driverLatLng!.longitude,
      _parcelStateController.parcel.value!.pickupLat!,
      _parcelStateController.parcel.value!.pickupLng!,
    );

    // 🔴 CHECK AGAIN AFTER AWAIT
    if (route == null || _parcelController.isParcelStarted.value) return;

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
      _parcelStateController.parcel.value!.pickupLat!,
      _parcelStateController.parcel.value!.pickupLng!,
      _parcelStateController.parcel.value!.dropoffLat!,
      _parcelStateController.parcel.value!.dropoffLng!,
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
    SocketService().off('parcel:refresh_location');
    super.dispose();
  }

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
        ],
      ),
    );
  }
}
