import 'package:flutter/material.dart';
import 'package:radeef/utils/app_colors.dart';
import 'package:radeef/views/base/custom_appbar.dart';

class DriverVerifySuccessScreen extends StatefulWidget {
  const DriverVerifySuccessScreen({super.key});

  @override
  State<DriverVerifySuccessScreen> createState() =>
      _DriverVerifySuccessScreenState();
}

class _DriverVerifySuccessScreenState extends State<DriverVerifySuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Center(
            child: RotationTransition(
              turns: _controller,
              child: Image.asset(
                'assets/images/load_image.png',
                width: 200,
                height: 200,
              ),
            ),
          ),

          SizedBox(height: 24),

          Text(
            "Under the review your account, When admin approve then to the Home",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: 160),
        ],
      ),
    );
  }
}
