class TripRequestSocketModel {
  final TripRequestModel trip;
  final TripUserModel user;

  TripRequestSocketModel({required this.trip, required this.user});

  factory TripRequestSocketModel.fromJson(Map<String, dynamic> json) {
    return TripRequestSocketModel(
      trip: TripRequestModel.fromJson(json['trip']),
      user: TripUserModel.fromJson(json['user']),
    );
  }
}

class TripUserModel {
  final String name;
  final int tripReceivedCount;
  final String? avatar;
  final double rating; // ✅ double
  final int ratingCount;

  TripUserModel({
    required this.name,
    required this.tripReceivedCount,
    this.avatar,
    required this.rating,
    required this.ratingCount,
  });

  factory TripUserModel.fromJson(Map<String, dynamic> json) {
    return TripUserModel(
      name: json['name'] ?? '',
      tripReceivedCount: (json['trip_received_count'] as num?)?.toInt() ?? 0,
      avatar: json['avatar'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ratingCount: (json['rating_count'] as num?)?.toInt() ?? 0,
    );
  }
}

class TripRequestModel {
  final String id;
  final String slug;

  final DateTime requestedAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;
  final DateTime? arrivedAt;
  final DateTime? paymentAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;

  final int? time;

  final String userId;
  final String? driverId;

  final String pickupType;
  final double pickupLat;
  final double pickupLng;
  final String pickupAddress;

  final String dropoffType;
  final double dropoffLat;
  final double dropoffLng;
  final String dropoffAddress;

  final String locationType;
  final double? locationLat;
  final double? locationLng;
  final String? locationAddress;

  final String status;
  final int totalCost;

  final String? processingDriverId;
  final DateTime? processingAt;
  final bool isProcessing;

  TripRequestModel({
    required this.id,
    required this.slug,
    required this.requestedAt,
    this.acceptedAt,
    this.startedAt,
    this.arrivedAt,
    this.paymentAt,
    this.completedAt,
    this.cancelledAt,
    this.time,
    required this.userId,
    this.driverId,
    required this.pickupType,
    required this.pickupLat,
    required this.pickupLng,
    required this.pickupAddress,
    required this.dropoffType,
    required this.dropoffLat,
    required this.dropoffLng,
    required this.dropoffAddress,
    required this.locationType,
    this.locationLat,
    this.locationLng,
    this.locationAddress,
    required this.status,
    required this.totalCost,
    this.processingDriverId,
    this.processingAt,
    required this.isProcessing,
  });

  factory TripRequestModel.fromJson(Map<String, dynamic> json) {
    return TripRequestModel(
      id: json['id'],
      slug: json['slug'],
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
      paymentAt: json['payment_at'] != null
          ? DateTime.parse(json['payment_at'])
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      cancelledAt: json['cancelled_at'] != null
          ? DateTime.parse(json['cancelled_at'])
          : null,
      time: json['time'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      pickupType: json['pickup_type'],
      pickupLat: (json['pickup_lat'] as num).toDouble(),
      pickupLng: (json['pickup_lng'] as num).toDouble(),
      pickupAddress: json['pickup_address'],
      dropoffType: json['dropoff_type'],
      dropoffLat: (json['dropoff_lat'] as num).toDouble(),
      dropoffLng: (json['dropoff_lng'] as num).toDouble(),
      dropoffAddress: json['dropoff_address'],
      locationType: json['location_type'],
      locationLat: json['location_lat'] != null
          ? (json['location_lat'] as num).toDouble()
          : null,
      locationLng: json['location_lng'] != null
          ? (json['location_lng'] as num).toDouble()
          : null,
      locationAddress: json['location_address'],
      status: json['status'],
      totalCost: json['total_cost'],
      processingDriverId: json['processing_driver_id'],
      processingAt: json['processing_at'] != null
          ? DateTime.parse(json['processing_at'])
          : null,
      isProcessing: json['is_processing'] ?? false,
    );
  }
}
