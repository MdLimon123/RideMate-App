import 'package:flutter/material.dart';
import 'package:radeef/views/base/bottom_menu..dart';

class DriverRidersScreen extends StatefulWidget {
  const DriverRidersScreen({super.key});

  @override
  State<DriverRidersScreen> createState() => _DriverRidersScreenState();
}

class _DriverRidersScreenState extends State<DriverRidersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Rides"),
      ),
      bottomNavigationBar: BottomMenu(1),
    );
  }
}
