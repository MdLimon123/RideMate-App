import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class TripMapScreen extends StatefulWidget {
  const TripMapScreen({super.key});

  @override
  _TripMapScreenState createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen> {
  GoogleMapController? _controller;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  LatLng currentCarLocation = LatLng(23.7770, 90.3800);
  LatLng destinationLocation = LatLng(23.7500, 90.3890);

  List<LatLng> routeCoordinates = [
    LatLng(23.7770, 90.3800),
    LatLng(23.7750, 90.3820),
    LatLng(23.7720, 90.3840),
    LatLng(23.7700, 90.3860),
    LatLng(23.7650, 90.3870),
    LatLng(23.7600, 90.3850),
    LatLng(23.7550, 90.3870),
    LatLng(23.7500, 90.3890),
  ];

  int currentIndex = 0;
  Timer? _timer;
  bool tripStarted = false;

  String timeKamalparaToTongi = "47 min";
  String distanceKamalparaToTongi = "15.6 km";

  String timeCurrentToDestination = "35 min";
  String distanceCurrentToDestination = "18 km";

  @override
  void initState() {
    super.initState();
    _setupMarkers();
    _setupPolyline();
  }

  void _setupMarkers() {
    markers.add(Marker(
      markerId: const MarkerId('car'),
      position: currentCarLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ));

    markers.add(Marker(
      markerId: const MarkerId('destination'),
      position: destinationLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));
  }

  void _setupPolyline() {
    polylines.add(Polyline(
      polylineId: const PolylineId('route'),
      points: routeCoordinates,
      color: Colors.blue,
      width: 5,
    ));
  }

  void _startTrip() {
    setState(() {
      tripStarted = true;
    });

    const duration = Duration(milliseconds: 500);
    _timer = Timer.periodic(duration, (timer) async {
      if (currentIndex < routeCoordinates.length - 1) {
        LatLng start = routeCoordinates[currentIndex];
        LatLng end = routeCoordinates[currentIndex + 1];

        double lat = start.latitude + (end.latitude - start.latitude) * 0.2;
        double lng = start.longitude + (end.longitude - start.longitude) * 0.2;

        setState(() {
          currentCarLocation = LatLng(lat, lng);

          markers.removeWhere((m) => m.markerId.value == 'car');
          markers.add(Marker(
            markerId: const MarkerId('car'),
            position: currentCarLocation,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ));
        });

        if (_controller != null) {
          await _controller!.animateCamera(
            CameraUpdate.newLatLng(currentCarLocation),
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
  }

  void _endTrip() {
    _timer?.cancel();
    Get.back(result: 'tripEnded');
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentCarLocation,
              zoom: 14,
            ),
            markers: markers,
            polylines: polylines,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
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
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Trip Info Top Right
          Positioned(
            top: 40,
            right: 20,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'R301',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Tongi',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
                  const Text('KAMARPARA', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  const Text('কামারপাড়া', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.directions_car, size: 18, color: Colors.grey.shade700),
                      const SizedBox(width: 5),
                      Text(
                        timeKamalparaToTongi,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    distanceKamalparaToTongi,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          /// Bottom Card with Start/End Trip
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: GestureDetector(
              onTap: () {
                if (!tripStarted) {
                  _startTrip();
                } else {
                  _endTrip();
                }
              },
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                decoration: BoxDecoration(
                  color: tripStarted ? Colors.red : Colors.green,
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
                child: Center(
                  child: Text(
                    tripStarted ? 'End Trip' : 'Start Trip',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),

          /// Car Icon above Bottom Card
          Positioned(
            bottom: 120,
            left: MediaQuery.of(context).size.width / 2 - 20,
            child: const Icon(
              Icons.directions_car,
              size: 40,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
