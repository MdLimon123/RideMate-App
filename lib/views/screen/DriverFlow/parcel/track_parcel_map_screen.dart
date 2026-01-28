import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/controllers/parcel_controller.dart';
import 'package:radeef/controllers/parcel_state.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:http/http.dart' as http;

class TrackParcelMapScreen extends StatefulWidget {
  const TrackParcelMapScreen({super.key});

  @override
  State<TrackParcelMapScreen> createState() => _TrackParcelMapScreenState();
}

class _TrackParcelMapScreenState extends State<TrackParcelMapScreen> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final _parcelController = Get.put(ParcelController());
  final _parcelStateController = Get.put(ParcelStateController());

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
    _parcelController.updateDriverParcelLocation(
      position.latitude,
      position.longitude,
      address,
      _parcelStateController.parcel.value!.id!,
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
            ? LatLng(
                _parcelStateController.parcel.value!.pickupLat!,
                _parcelStateController.parcel.value!.pickupLng!,
              )
            : LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
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
                  ? LatLng(_parcelStateController.parcel.value!.pickupLat!,   _parcelStateController.parcel.value!.pickupLng!,)
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
