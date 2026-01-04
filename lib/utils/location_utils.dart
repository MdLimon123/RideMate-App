import 'dart:math';

class LocationUtils {
  static double _degToRad(double deg) => deg * (pi / 180);

  /// Returns distance in KM
  static double distanceKm({
    required double lat1,
    required double lng1,
    required double lat2,
    required double lng2,
  }) {
    const earthRadiusKm = 6371;

    final dLat = _degToRad(lat2 - lat1);
    final dLng = _degToRad(lng2 - lng1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) *
            cos(_degToRad(lat2)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  /// Estimate time in minutes based on avg speed
  static int etaMinutes({
    required double distanceKm,
    double avgSpeedKmH = 30, // city avg speed
  }) {
    if (avgSpeedKmH <= 0) return 0;
    final minutes = (distanceKm / avgSpeedKmH) * 60;
    final m = minutes.ceil();
    return m < 1 ? 1 : m; // min 1 minute
  }
}
