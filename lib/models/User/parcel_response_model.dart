class ParcelResponseModel {
  final ParcelDriverModel? driver;
  final ParcelModel? parcel;

  ParcelResponseModel({this.driver, this.parcel});

  factory ParcelResponseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ParcelResponseModel();

    return ParcelResponseModel(
      driver: json['driver'] != null
          ? ParcelDriverModel.fromJson(json['driver'])
          : null,
      parcel: json['parcel'] != null
          ? ParcelModel.fromJson(json['parcel'])
          : null,
    );
  }
}

class ParcelDriverModel {
  final String? id;
  final String? role;
  final String? avatar;
  final String? name;
  final String? gender;
  final List<String>? drivingLicensePhotos;
  final String? vehicleType;
  final String? vehicleBrand;
  final String? vehicleModel;
  final String? vehiclePlateNumber;
  final List<String>? vehicleRegistrationPhotos;
  final List<String>? vehiclePhotos;
  final int? tripGivenCount;
  final bool? isStripeConnected;
  final int? rating;
  final int? ratingCount;
  final double? locationLat;
  final double? locationLng;

  ParcelDriverModel({
    this.id,
    this.role,
    this.avatar,
    this.name,
    this.gender,
    this.drivingLicensePhotos,
    this.vehicleType,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehiclePlateNumber,
    this.vehicleRegistrationPhotos,
    this.vehiclePhotos,
    this.tripGivenCount,
    this.isStripeConnected,
    this.rating,
    this.ratingCount,
    this.locationLat,
    this.locationLng,
  });

  factory ParcelDriverModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ParcelDriverModel();

    return ParcelDriverModel(
      id: json['id'],
      role: json['role'],
      avatar: json['avatar'],
      name: json['name'],
      gender: json['gender'],
      drivingLicensePhotos: (json['driving_license_photos'] as List?)
          ?.cast<String>(),
      vehicleType: json['vehicle_type'],
      vehicleBrand: json['vehicle_brand'],
      vehicleModel: json['vehicle_model'],
      vehiclePlateNumber: json['vehicle_plate_number'],
      vehicleRegistrationPhotos: (json['vehicle_registration_photos'] as List?)
          ?.cast<String>(),
      vehiclePhotos: (json['vehicle_photos'] as List?)?.cast<String>(),
      tripGivenCount: json['trip_given_count'],
      isStripeConnected: json['is_stripe_connected'],
      rating: json['rating'],
      ratingCount: json['rating_count'],
      locationLat: (json['location_lat'] as num?)?.toDouble(),
      locationLng: (json['location_lng'] as num?)?.toDouble(),
    );
  }
}

class ParcelModel {
  final String? id;
  final String? slug;
  final String? requestedAt;
  final String? acceptedAt;
  final String? startedAt;
  final String? deliveredAt;
  final String? completedAt;
  final String? cancelledAt;
  final String? paymentAt;
  final String? userId;
  final String? driverId;

  final String? pickupType;
  final double? pickupLat;
  final double? pickupLng;
  final String? pickupAddress;

  final String? dropoffType;
  final double? dropoffLat;
  final double? dropoffLng;
  final String? dropoffAddress;

  final String? locationType;
  final double? locationLat;
  final double? locationLng;
  final String? locationAddress;

  final String? status;
  final String? parcelType;
  final int? weight;
  final int? amount;
  final int? totalCost;

  final String? processingDriverId;
  final String? processingAt;
  final bool? isProcessing;

  final List<String>? deliveryProofFiles;
  final double? deliveryLat;
  final double? deliveryLng;

  ParcelModel({
    this.id,
    this.slug,
    this.requestedAt,
    this.acceptedAt,
    this.startedAt,
    this.deliveredAt,
    this.completedAt,
    this.cancelledAt,
    this.paymentAt,
    this.userId,
    this.driverId,
    this.pickupType,
    this.pickupLat,
    this.pickupLng,
    this.pickupAddress,
    this.dropoffType,
    this.dropoffLat,
    this.dropoffLng,
    this.dropoffAddress,
    this.locationType,
    this.locationLat,
    this.locationLng,
    this.locationAddress,
    this.status,
    this.parcelType,
    this.weight,
    this.amount,
    this.totalCost,
    this.processingDriverId,
    this.processingAt,
    this.isProcessing,
    this.deliveryProofFiles,
    this.deliveryLat,
    this.deliveryLng,
  });

  factory ParcelModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ParcelModel();

    return ParcelModel(
      id: json['id'],
      slug: json['slug'],
      requestedAt: json['requested_at'],
      acceptedAt: json['accepted_at'],
      startedAt: json['started_at'],
      deliveredAt: json['delivered_at'],
      completedAt: json['completed_at'],
      cancelledAt: json['cancelled_at'],
      paymentAt: json['payment_at'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      pickupType: json['pickup_type'],
      pickupLat: (json['pickup_lat'] as num?)?.toDouble(),
      pickupLng: (json['pickup_lng'] as num?)?.toDouble(),
      pickupAddress: json['pickup_address'],
      dropoffType: json['dropoff_type'],
      dropoffLat: (json['dropoff_lat'] as num?)?.toDouble(),
      dropoffLng: (json['dropoff_lng'] as num?)?.toDouble(),
      dropoffAddress: json['dropoff_address'],
      locationType: json['location_type'],
      locationLat: (json['location_lat'] as num?)?.toDouble(),
      locationLng: (json['location_lng'] as num?)?.toDouble(),
      locationAddress: json['location_address'],
      status: json['status'],
      parcelType: json['parcel_type'],
      weight: json['weight'],
      amount: json['amount'],
      totalCost: json['total_cost'],
      processingDriverId: json['processing_driver_id'],
      processingAt: json['processing_at'],
      isProcessing: json['is_processing'],
      deliveryProofFiles: (json['delivery_proof_files'] as List?)
          ?.cast<String>(),
      deliveryLat: (json['delivery_lat'] as num?)?.toDouble(),
      deliveryLng: (json['delivery_lng'] as num?)?.toDouble(),
    );
  }
}
