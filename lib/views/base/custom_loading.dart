import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final Color? color;

  const CustomLoading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(color: color ?? Colors.white),
    );
  }
}
