import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/models/Driver/parcel_request_model.dart';
import 'package:radeef/models/Driver/trip_request_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/service/socket_service.dart';
import 'package:radeef/utils/location_utils.dart';
import 'package:radeef/views/screen/DriverFlow/DriverHome/AllSubScreen/confirmation_screen.dart';
import 'package:http/http.dart' as http;

class TripMapScreen extends StatefulWidget {
  final bool isParcel;
  final ParcelRequestModel? parcel;
  final TripRequestModel? trip;
  final ParcelUserModel? parcelUserModel;
  final TripUserModel? tripUserModel;

  const TripMapScreen({
    super.key,
    required this.isParcel,
    this.parcel,
    this.trip,
    this.parcelUserModel,
    this.tripUserModel,
  });

  @override
  _TripMapScreenState createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen> {


  GoogleMapController? _controller;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  bool tripStarted = false;
  bool tripCompleted = false;
  Timer? _timer;
  int currentIndex = 0;

  int etaMin = 0;
  double distance = 0;
  double driverLat = 0;
  double driverLng = 0;

  List<LatLng> routeCoordinates = [];

  @override
  void initState() {
    super.initState();
    _setupMarkers();
    _getDirections();
    _calculateEta();
  }

  void _calculateEta() {
    final userLat = widget.isParcel
        ? widget.parcel!.pickupLat
        : widget.trip!.pickupLat;
    final userLng = widget.isParcel
        ? widget.parcel!.pickupLng
        : widget.trip!.pickupLng;

    if (driverLat == 0 || driverLng == 0 || userLat == 0 || userLng == 0) {
      setState(() {
        etaMin = 0;
        distance = 0;
      });
      return;
    }

    final d = LocationUtils.distanceKm(
      lat1: driverLat,
      lng1: driverLng,
      lat2: userLat,
      lng2: userLng,
    );

    final eta = LocationUtils.etaMinutes(distanceKm: d);

    setState(() {
      distance = d;
      etaMin = eta;
    });

    debugPrint("📍 Distance KM: ${d.toStringAsFixed(2)}");
    debugPrint("⏱ ETA Minutes: $eta");
  }

  void _setupMarkers() {
    LatLng start = LatLng(
      widget.isParcel ? widget.parcel!.pickupLat : widget.trip!.pickupLat,
      widget.isParcel ? widget.parcel!.pickupLng : widget.trip!.pickupLng,
    );
    LatLng end = LatLng(
      widget.isParcel ? widget.parcel!.dropoffLat : widget.trip!.dropoffLat,
      widget.isParcel ? widget.parcel!.dropoffLng : widget.trip!.dropoffLng,
    );

    markers.add(
      Marker(
        markerId: const MarkerId('car'),
        position: start,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: end,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  Future<void> _getDirections() async {
    LatLng start = LatLng(
      widget.isParcel ? widget.parcel!.pickupLat : widget.trip!.pickupLat,
      widget.isParcel ? widget.parcel!.pickupLng : widget.trip!.pickupLng,
    );
    LatLng end = LatLng(
      widget.isParcel ? widget.parcel!.dropoffLat : widget.trip!.dropoffLat,
      widget.isParcel ? widget.parcel!.dropoffLng : widget.trip!.dropoffLng,
    );

    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${start.latitude},${start.longitude}&'
        'destination=${end.latitude},${end.longitude}&'
        'key=${ApiConstant.googleApiKey}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['routes'].isNotEmpty) {
          final String encodedPolyline =
              data['routes'][0]['overview_polyline']['points'];

          List<PointLatLng> decodedPoints = PolylinePoints.decodePolyline(
            encodedPolyline,
          );

          List<LatLng> routePoints = decodedPoints
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();

          setState(() {
            routeCoordinates = routePoints;

            polylines.add(
              Polyline(
                polylineId: const PolylineId('route'),
                points: routePoints,
                color: Colors.blue,
                width: 5,
              ),
            );
          });

          debugPrint("✅ Route loaded with ${routePoints.length} points");
        }
      }
    } catch (e) {
      debugPrint("❌ Error fetching directions: $e");

      setState(() {
        routeCoordinates = [start, end];
        polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            points: routeCoordinates,
            color: Colors.blue,
            width: 5,
          ),
        );
      });
    }
  }

  void _startParcel() {
    setState(() {
      tripStarted = true;
      tripCompleted = false;
    });

    const duration = Duration(milliseconds: 500);
    _timer = Timer.periodic(duration, (timer) async {
      if (currentIndex < routeCoordinates.length - 1) {
        LatLng start = routeCoordinates[currentIndex];
        LatLng end = routeCoordinates[currentIndex + 1];

        double lat = start.latitude + (end.latitude - start.latitude) * 0.2;
        double lng = start.longitude + (end.longitude - start.longitude) * 0.2;

        setState(() {
          LatLng currentPos = LatLng(lat, lng);

          markers.removeWhere((m) => m.markerId.value == 'car');
          markers.add(
            Marker(
              markerId: const MarkerId('car'),
              position: currentPos,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
            ),
          );
        });

        if (_controller != null) {
          await _controller!.animateCamera(
            CameraUpdate.newLatLng(LatLng(lat, lng)),
          );
        }

        if ((lat - end.latitude).abs() < 0.0001 &&
            (lng - end.longitude).abs() < 0.0001) {
          currentIndex++;
        }
      } else {
        // _endParcel();
      }
    });

    // Socket call for parcel
    SocketService().emit(
      "parcel:start",
      data: {"parcel_id": widget.parcel!.id},
    );
  }

  void _startTrip() {
    setState(() {
      tripStarted = true;
      tripCompleted = false;
    });

    const duration = Duration(milliseconds: 500);
    _timer = Timer.periodic(duration, (timer) async {
      if (currentIndex < routeCoordinates.length - 1) {
        LatLng start = routeCoordinates[currentIndex];
        LatLng end = routeCoordinates[currentIndex + 1];

        double lat = start.latitude + (end.latitude - start.latitude) * 0.2;
        double lng = start.longitude + (end.longitude - start.longitude) * 0.2;

        setState(() {
          LatLng currentPos = LatLng(lat, lng);

          markers.removeWhere((m) => m.markerId.value == 'car');
          markers.add(
            Marker(
              markerId: const MarkerId('car'),
              position: currentPos,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
            ),
          );
        });

        if (_controller != null) {
          await _controller!.animateCamera(
            CameraUpdate.newLatLng(LatLng(lat, lng)),
          );
        }

        if ((lat - end.latitude).abs() < 0.0001 &&
            (lng - end.longitude).abs() < 0.0001) {
          currentIndex++;
        }
      } else {
        _endTrip();
      }
    });

    SocketService().emit("trip:start", data: {"trip_id": widget.trip!.id});
  }

  void _endTrip() {
    _timer?.cancel();
    SocketService().emit("trip:end", data: {"trip_id": widget.trip!.id});
    setState(() {
      tripStarted = false;
      tripCompleted = true;
    });

    Get.to(
      () => ConfirmationScreen(
        isParcel: widget.isParcel,
        parcel: widget.isParcel ? widget.parcel : null,
        parcelUserModel: widget.isParcel ? widget.parcelUserModel : null,
        trip: widget.isParcel ? null : widget.trip,
        tripUserModel: widget.isParcel ? null : widget.tripUserModel,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LatLng initialCamera = LatLng(
      widget.isParcel ? widget.parcel!.pickupLat : widget.trip!.pickupLat,
      widget.isParcel ? widget.parcel!.pickupLng : widget.trip!.pickupLng,
    );

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialCamera,
              zoom: 14,
            ),
            markers: markers,
            polylines: polylines,
            onMapCreated: (controller) => _controller = controller,
          ),

          Positioned(
            top: 40,
            left: 10,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.2,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isParcel
                        ? widget.parcel!.pickupAddress
                        : widget.trip!.pickupAddress,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.motorcycle,
                        size: 18,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        etaMin == 0 ? "-- min away" : "$etaMin min away",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    distance == 0
                        ? "-- km away"
                        : "${distance.toStringAsFixed(2)} km away",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          if (!tripStarted && !tripCompleted)
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 100,
              child: GestureDetector(
                onTap: () {
                  if (widget.isParcel) {
                    _startParcel();
                  } else {
                    _startTrip();
                  }
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      widget.isParcel ? "Start Parcel" : "Start Trip",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

          if (tripStarted && !tripCompleted)
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 100,
              child: GestureDetector(
                onTap: () {
                  if (widget.isParcel) {
                    Get.to(
                      () => ConfirmationScreen(
                        isParcel: widget.isParcel,
                        parcel: widget.isParcel ? widget.parcel : null,
                        parcelUserModel: widget.isParcel
                            ? widget.parcelUserModel
                            : null,
                        trip: widget.isParcel ? null : widget.trip,
                        tripUserModel: widget.isParcel
                            ? null
                            : widget.tripUserModel,
                      ),
                    );
                  } else {
                    _endTrip();
                  }
                },
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      widget.isParcel ? "Deliver Parcel" : "End Trip",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
