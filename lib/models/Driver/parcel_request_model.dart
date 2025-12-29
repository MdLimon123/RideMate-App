class ParcelRequestSocketModel {
  final ParcelRequestModel parcel;
  final ParcelUserModel user;

  ParcelRequestSocketModel({required this.parcel, required this.user});

  factory ParcelRequestSocketModel.fromJson(Map<String, dynamic> json) {
    return ParcelRequestSocketModel(
      parcel: ParcelRequestModel.fromJson(json['parcel']),
      user: ParcelUserModel.fromJson(json['user']),
    );
  }
}

class ParcelUserModel {
  final String name;
  final int tripReceivedCount;
  final String? avatar;
  final int rating;
  final int ratingCount;

  ParcelUserModel({
    required this.name,
    required this.tripReceivedCount,
    this.avatar,
    required this.rating,
    required this.ratingCount,
  });

  factory ParcelUserModel.fromJson(Map<String, dynamic> json) {
    return ParcelUserModel(
      name: json['name'] ?? '',
      tripReceivedCount: json['trip_received_count'] ?? 0,
      avatar: json['avatar'],
      rating: json['rating'] ?? 0,
      ratingCount: json['rating_count'] ?? 0,
    );
  }
}

class ParcelRequestModel {
  final String id;
  final String slug;

  final DateTime requestedAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;
  final DateTime? deliveredAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final DateTime? paymentAt;

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
  final String parcelType;
  final int weight;
  final int amount;
  final int totalCost;

  final String? processingDriverId;
  final DateTime? processingAt;
  final bool isProcessing;

  final List<dynamic> deliveryProofFiles;
  final double? deliveryLat;
  final double? deliveryLng;

  ParcelRequestModel({
    required this.id,
    required this.slug,
    required this.requestedAt,
    this.acceptedAt,
    this.startedAt,
    this.deliveredAt,
    this.completedAt,
    this.cancelledAt,
    this.paymentAt,
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
    required this.parcelType,
    required this.weight,
    required this.amount,
    required this.totalCost,
    this.processingDriverId,
    this.processingAt,
    required this.isProcessing,
    required this.deliveryProofFiles,
    this.deliveryLat,
    this.deliveryLng,
  });

  factory ParcelRequestModel.fromJson(Map<String, dynamic> json) {
    return ParcelRequestModel(
      id: json['id'],
      slug: json['slug'],
      requestedAt: DateTime.parse(json['requested_at']),
      acceptedAt: json['accepted_at'] != null
          ? DateTime.parse(json['accepted_at'])
          : null,
      startedAt: json['started_at'] != null
          ? DateTime.parse(json['started_at'])
          : null,
      deliveredAt: json['delivered_at'] != null
          ? DateTime.parse(json['delivered_at'])
          : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      cancelledAt: json['cancelled_at'] != null
          ? DateTime.parse(json['cancelled_at'])
          : null,
      paymentAt: json['payment_at'] != null
          ? DateTime.parse(json['payment_at'])
          : null,
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
      parcelType: json['parcel_type'],
      weight: json['weight'],
      amount: json['amount'],
      totalCost: json['total_cost'],
      processingDriverId: json['processing_driver_id'],
      processingAt: json['processing_at'] != null
          ? DateTime.parse(json['processing_at'])
          : null,
      isProcessing: json['is_processing'] ?? false,
      deliveryProofFiles: List.from(json['delivery_proof_files'] ?? []),
      deliveryLat: json['delivery_lat'] != null
          ? (json['delivery_lat'] as num).toDouble()
          : null,
      deliveryLng: json['delivery_lng'] != null
          ? (json['delivery_lng'] as num).toDouble()
          : null,
    );
  }
}
