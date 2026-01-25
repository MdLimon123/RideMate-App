import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:radeef/models/User/driver_model.dart';
import 'package:radeef/models/User/trip_model.dart';
import 'package:radeef/service/api_constant.dart';
import 'package:radeef/views/screen/UserFLow/UserHome/AllSubScreen/end_trip_screen.dart';
import 'package:http/http.dart' as http;

class TrackDriverScreen extends StatefulWidget {
  final double pickLat;
  final double pickLan;
  final double dropLat;
  final double dropLan;
  final String dropAddress;
  final DriverModel driver;
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
  _TrackDriverScreenState createState() => _TrackDriverScreenState();
}

class _TrackDriverScreenState extends State<TrackDriverScreen> {


  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  int etaMin = 0;
  double distanceKm = 0;

  @override
  void initState() {
    super.initState();
    _setupMarkers();
    _getDirections(); 
  }

  void _setupMarkers() {
    markers.add(
      Marker(
        markerId: const MarkerId('bike'),
        position: LatLng(widget.pickLat, widget.pickLan),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    markers.add(
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(widget.dropLat, widget.dropLan),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
  }

  Future<void> _getDirections() async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${widget.pickLat},${widget.pickLan}&'
        'destination=${widget.dropLat},${widget.dropLan}&'
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

          final int distanceMeters =
              data['routes'][0]['legs'][0]['distance']['value'];
          final int durationSeconds =
              data['routes'][0]['legs'][0]['duration']['value'];

          setState(() {
            polylines.add(
              Polyline(
                polylineId: const PolylineId('route'),
                points: routePoints,
                color: Colors.red,
                width: 5,
              ),
            );

      
            distanceKm = distanceMeters / 1000;
            etaMin = (durationSeconds / 60).round();
          });

          print("📍 Route Distance: ${distanceKm.toStringAsFixed(2)} km");
          print("⏱ Estimated Time: $etaMin min");
        }
      }
    } catch (e) {
      print("Error fetching directions: $e");
    }
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.pickLat, widget.pickLan),
              zoom: 14,
            ),
            markers: markers,
            polylines: polylines,
            onMapCreated: (GoogleMapController controller) {},
          ),

          /// Back Button
          Positioned(
            top: 40,
            left: 10,
            child: SafeArea(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Kamarpara Card
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
                    widget.dropAddress,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.motorcycle,
                        size: 18,
                        color: Colors.grey.shade700,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        etaMin == 0 ? "-- min" : "$etaMin min",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    distanceKm == 0
                        ? "-- km"
                        : "${distanceKm.toStringAsFixed(1)} km",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 30,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: InkWell(
              onTap: () {
                Get.to(
                  () => EndTripScreen(driver: widget.driver, trip: widget.trip),
                );
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
                    "End Trip",
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
