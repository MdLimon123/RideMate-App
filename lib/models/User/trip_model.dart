import 'dart:convert';

import 'package:radeef/controllers/UserController/tripstate_controller.dart';

TripModel tripModelFromJson(String str) => TripModel.fromJson(json.decode(str));

class TripModel {
  final String? id;
  final String? slug;
  final DateTime? requestedAt;
  final DateTime? acceptedAt;
  final DateTime? startedAt;
  final DateTime? arrivedAt;
  final DateTime? paymentAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final dynamic time;
  final DateTime? date;
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
  final dynamic locationLat;
  final dynamic locationLng;
  final dynamic locationAddress;
  final TripStatus? status;
  final int? totalCost;
  final dynamic processingDriverId;
  final DateTime? processingAt;
  final bool? isProcessing;
  final User? user;
  final Driver? driver;
  final List<Review>? reviews;

  TripModel({
    this.id,
    this.slug,
    this.requestedAt,
    this.acceptedAt,
    this.startedAt,
    this.arrivedAt,
    this.paymentAt,
    this.completedAt,
    this.cancelledAt,
    this.time,
    this.date,
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
    this.totalCost,
    this.processingDriverId,
    this.processingAt,
    this.isProcessing,
    this.user,
    this.driver,
    this.reviews,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
    id: json["id"],
    slug: json["slug"],
    requestedAt: json["requested_at"] == null
        ? null
        : DateTime.tryParse(json["requested_at"]),
    acceptedAt: json["accepted_at"] == null
        ? null
        : DateTime.tryParse(json["accepted_at"]),
    startedAt: json["started_at"] == null
        ? null
        : DateTime.tryParse(json["started_at"]),
    arrivedAt: json["arrived_at"] == null
        ? null
        : DateTime.tryParse(json["arrived_at"]),
    paymentAt: json["payment_at"] == null
        ? null
        : DateTime.tryParse(json["payment_at"]),
    completedAt: json["completed_at"] == null
        ? null
        : DateTime.tryParse(json["completed_at"]),
    cancelledAt: json["cancelled_at"] == null
        ? null
        : DateTime.tryParse(json["cancelled_at"]),
    time: json["time"],
    date: json["date"] == null ? null : DateTime.tryParse(json["date"]),
    userId: json["user_id"],
    driverId: json["driver_id"],
    pickupType: json["pickup_type"],
    pickupLat: json["pickup_lat"]?.toDouble(),
    pickupLng: json["pickup_lng"]?.toDouble(),
    pickupAddress: json["pickup_address"],
    dropoffType: json["dropoff_type"],
    dropoffLat: json["dropoff_lat"]?.toDouble(),
    dropoffLng: json["dropoff_lng"]?.toDouble(),
    dropoffAddress: json["dropoff_address"],
    locationType: json["location_type"],
    locationLat: json["location_lat"]?.toDouble(),
    locationLng: json["location_lng"]?.toDouble(),
    locationAddress: json["location_address"],
    // status: json["status"],
      status: TripStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
    totalCost: json["total_cost"],
    processingDriverId: json["processing_driver_id"],
    processingAt: json["processing_at"] == null
        ? null
        : DateTime.tryParse(json["processing_at"]),
    isProcessing: json["is_processing"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    reviews: json["reviews"] == null
        ? []
        : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
  );
}

class Driver {
  final String? id;
  final String? role;
  final dynamic onesignalId;
  final String? avatar;
  final String? name;
  final String? gender;
  final List<dynamic>? drivingLicensePhotos;
  final dynamic vehicleType;
  final dynamic vehicleBrand;
  final dynamic vehicleModel;
  final dynamic vehiclePlateNumber;
  final List<dynamic>? vehicleRegistrationPhotos;
  final List<dynamic>? vehiclePhotos;
  final int? tripGivenCount;
  final bool? isStripeConnected;
  final double? rating;
  final int? ratingCount;
  final double? locationLat;
  final double? locationLng;

  Driver({
    this.id,
    this.role,
    this.onesignalId,
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

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    role: json["role"],
    onesignalId: json["onesignal_id"],
    avatar: json["avatar"],
    name: json["name"],
    gender: json["gender"],
    drivingLicensePhotos: json["driving_license_photos"] == null
        ? []
        : List<dynamic>.from(json["driving_license_photos"]!.map((x) => x)),
    vehicleType: json["vehicle_type"],
    vehicleBrand: json["vehicle_brand"],
    vehicleModel: json["vehicle_model"],
    vehiclePlateNumber: json["vehicle_plate_number"],
    vehicleRegistrationPhotos: json["vehicle_registration_photos"] == null
        ? []
        : List<dynamic>.from(
            json["vehicle_registration_photos"]!.map((x) => x),
          ),
    vehiclePhotos: json["vehicle_photos"] == null
        ? []
        : List<dynamic>.from(json["vehicle_photos"]!.map((x) => x)),
    tripGivenCount: json["trip_given_count"],
    isStripeConnected: json["is_stripe_connected"],
    rating: json["rating"].toDouble(),
    ratingCount: json["rating_count"],
    locationLat: json["location_lat"]?.toDouble(),
    locationLng: json["location_lng"]?.toDouble(),
  );
}

class Review {
  final String? reviewerId;

  Review({this.reviewerId});

  factory Review.fromJson(Map<String, dynamic> json) =>
      Review(reviewerId: json["reviewer_id"]);
}

class User {
  final String? id;
  final String? role;
  final dynamic onesignalId;
  final String? avatar;
  final String? name;
  final String? gender;
  final int? tripReceivedCount;
  final bool? isStripeConnected;
  final double? rating;
  final int? ratingCount;
  final dynamic locationLat;
  final dynamic locationLng;

  User({
    this.id,
    this.role,
    this.onesignalId,
    this.avatar,
    this.name,
    this.gender,
    this.tripReceivedCount,
    this.isStripeConnected,
    this.rating,
    this.ratingCount,
    this.locationLat,
    this.locationLng,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    role: json["role"],
    onesignalId: json["onesignal_id"],
    avatar: json["avatar"],
    name: json["name"],
    gender: json["gender"],
    tripReceivedCount: json["trip_received_count"],
    isStripeConnected: json["is_stripe_connected"],
    rating: json["rating"].toDouble(),
    ratingCount: json["rating_count"],
    locationLat: json["location_lat"],
    locationLng: json["location_lng"],
  );
}
