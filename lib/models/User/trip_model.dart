class TripModel {
  final String id;
  final String slug;
  final String status;

  final DateTime requestedAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;
  final DateTime? arrivedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;

  final String pickupAddress;
  final double pickupLat;
  final double pickupLng;

  final String dropoffAddress;
  final double dropoffLat;
  final double dropoffLng;

  final int totalCost;
  final bool isProcessing;

  TripModel({
    required this.id,
    required this.slug,
    required this.status,
    required this.requestedAt,
    this.acceptedAt,
    this.startedAt,
    this.arrivedAt,
    this.completedAt,
    this.cancelledAt,
    required this.pickupAddress,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropoffAddress,
    required this.dropoffLat,
    required this.dropoffLng,
    required this.totalCost,
    required this.isProcessing,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'],
      slug: json['slug'],
      status: json['status'],
      requestedAt: DateTime.parse(json['requested_at']),
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'])
          : null,
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'])
          : null,
      arrivedAt: json['arrived_at'] != null
          ? DateTime.parse(json['arrived_at'])
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      cancelledAt: json['cancelled_at'] != null
          ? DateTime.parse(json['cancelled_at'])
          : null,
      pickupAddress: json['pickup_address'],
      pickupLat: json['pickup_lat'].toDouble(),
      pickupLng: json['pickup_lng'].toDouble(),
      dropoffAddress: json['dropoff_address'],
      dropoffLat: json['dropoff_lat'].toDouble(),
      dropoffLng: json['dropoff_lng'].toDouble(),
      totalCost: json['total_cost'],
      isProcessing: json['is_processing'] ?? false,
    );
  }
}
