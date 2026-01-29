// To parse this JSON data, do
//
//     final parcelModel = parcelModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final parcelModel = parcelModelFromJson(jsonString);

import 'dart:convert';

import 'package:radeef/controllers/parcel_state.dart';

ParcelModel parcelModelFromJson(String str) =>
    ParcelModel.fromJson(json.decode(str));

String parcelModelToJson(ParcelModel data) => json.encode(data.toJson());

class ParcelModel {
  final String? id;
  final String? slug;
  final DateTime? requestedAt;
  final DateTime? acceptedAt;
  final dynamic startedAt;
  final dynamic deliveredAt;
  final dynamic completedAt;
  final dynamic cancelledAt;
  final dynamic paymentAt;
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
  final ParcelState? status;
  final String? parcelType;
  final int? weight;
  final int? amount;
  final int? totalCost;
  final dynamic processingDriverId;
  final dynamic processingAt;
  final bool? isProcessing;
  final List<String>? deliveryProofFiles;
  final dynamic deliveryLat;
  final dynamic deliveryLng;
  final User? user;
  final Driver? driver;
  final List<dynamic>? reviews;

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
    this.user,
    this.driver,
    this.reviews,
  });

  factory ParcelModel.fromJson(Map<String, dynamic> json) => ParcelModel(
    id: json["id"],
    slug: json["slug"],
    requestedAt: json["requested_at"] == null
        ? null
        : DateTime.parse(json["requested_at"]),
    acceptedAt: json["accepted_at"] == null
        ? null
        : DateTime.parse(json["accepted_at"]),
    startedAt: json["started_at"],
    deliveredAt: json["delivered_at"],
    completedAt: json["completed_at"],
    cancelledAt: json["cancelled_at"],
    paymentAt: json["payment_at"],
    time: json["time"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
    locationLat: json["location_lat"],
    locationLng: json["location_lng"],
    locationAddress: json["location_address"],
    status: ParcelState.values.firstWhere((e) => e.name == json['status']),
    parcelType: json["parcel_type"],
    weight: json["weight"],
    amount: json["amount"],
    totalCost: json["total_cost"],
    processingDriverId: json["processing_driver_id"],
    processingAt: json["processing_at"],
    isProcessing: json["is_processing"],
    deliveryProofFiles: json["delivery_proof_files"] == null
        ? []
        : List<String>.from(json["delivery_proof_files"]),

    deliveryLat: json["delivery_lat"],
    deliveryLng: json["delivery_lng"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    reviews: json["reviews"] == null
        ? []
        : List<dynamic>.from(json["reviews"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "requested_at": requestedAt?.toIso8601String(),
    "accepted_at": acceptedAt?.toIso8601String(),
    "started_at": startedAt,
    "delivered_at": deliveredAt,
    "completed_at": completedAt,
    "cancelled_at": cancelledAt,
    "payment_at": paymentAt,
    "time": time,
    "date":
        "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "user_id": userId,
    "driver_id": driverId,
    "pickup_type": pickupType,
    "pickup_lat": pickupLat,
    "pickup_lng": pickupLng,
    "pickup_address": pickupAddress,
    "dropoff_type": dropoffType,
    "dropoff_lat": dropoffLat,
    "dropoff_lng": dropoffLng,
    "dropoff_address": dropoffAddress,
    "location_type": locationType,
    "location_lat": locationLat,
    "location_lng": locationLng,
    "location_address": locationAddress,
    "status": status,
    "parcel_type": parcelType,
    "weight": weight,
    "amount": amount,
    "total_cost": totalCost,
    "processing_driver_id": processingDriverId,
    "processing_at": processingAt,
    "is_processing": isProcessing,
    "delivery_proof_files": deliveryProofFiles == null
        ? []
        : List<dynamic>.from(deliveryProofFiles!.map((x) => x)),
    "delivery_lat": deliveryLat,
    "delivery_lng": deliveryLng,
    "user": user?.toJson(),
    "driver": driver?.toJson(),
    "reviews": reviews == null
        ? []
        : List<dynamic>.from(reviews!.map((x) => x)),
  };
}

class Driver {
  final String? id;
  final String? role;
  final String? onesignalId;
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
  final int? rating;
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
    rating: json["rating"],
    ratingCount: json["rating_count"],
    locationLat: json["location_lat"]?.toDouble(),
    locationLng: json["location_lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "onesignal_id": onesignalId,
    "avatar": avatar,
    "name": name,
    "gender": gender,
    "driving_license_photos": drivingLicensePhotos == null
        ? []
        : List<dynamic>.from(drivingLicensePhotos!.map((x) => x)),
    "vehicle_type": vehicleType,
    "vehicle_brand": vehicleBrand,
    "vehicle_model": vehicleModel,
    "vehicle_plate_number": vehiclePlateNumber,
    "vehicle_registration_photos": vehicleRegistrationPhotos == null
        ? []
        : List<dynamic>.from(vehicleRegistrationPhotos!.map((x) => x)),
    "vehicle_photos": vehiclePhotos == null
        ? []
        : List<dynamic>.from(vehiclePhotos!.map((x) => x)),
    "trip_given_count": tripGivenCount,
    "is_stripe_connected": isStripeConnected,
    "rating": rating,
    "rating_count": ratingCount,
    "location_lat": locationLat,
    "location_lng": locationLng,
  };
}

class User {
  final String? id;
  final String? role;
  final String? onesignalId;
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "onesignal_id": onesignalId,
    "avatar": avatar,
    "name": name,
    "gender": gender,
    "trip_received_count": tripReceivedCount,
    "is_stripe_connected": isStripeConnected,
    "rating": rating,
    "rating_count": ratingCount,
    "location_lat": locationLat,
    "location_lng": locationLng,
  };
}
