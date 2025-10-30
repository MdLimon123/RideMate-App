import 'package:flutter/material.dart';
import 'package:radeef/views/base/bottom_menu..dart';

class DriverEarnScreen extends StatefulWidget {
  const DriverEarnScreen({super.key});

  @override
  State<DriverEarnScreen> createState() => _DriverEarnScreenState();
}

class _DriverEarnScreenState extends State<DriverEarnScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Center(
        child: Text("Earn"),
      ),
     bottomNavigationBar: BottomMenu(2),
    );
  }
}
