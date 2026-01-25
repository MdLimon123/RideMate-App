import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeStatsShimmer extends StatelessWidget {
  const HomeStatsShimmer({super.key});

  Widget _shimmerBox() {
    return Container(
      height: 24,
      width: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _shimmerBox(),
          _shimmerBox(),
          _shimmerBox(),
        ],
      ),
    );
  }
}