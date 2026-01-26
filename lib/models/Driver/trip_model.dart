// To parse this JSON data, do
//
//     final tripDriverModel = tripDriverModelFromJson(jsonString);

import 'dart:convert';

TripDriverModel tripDriverModelFromJson(String str) => TripDriverModel.fromJson(json.decode(str));

String tripDriverModelToJson(TripDriverModel data) => json.encode(data.toJson());

class TripDriverModel {
    final String? id;
    final String? slug;
    final DateTime? requestedAt;
    final DateTime? acceptedAt;
    final DateTime? startedAt;
    final dynamic deliveredAt;
    final DateTime? completedAt;
    final dynamic cancelledAt;
    final DateTime? paymentAt;
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
    final String? status;
    final int? totalCost;
    final String? processingDriverId;
    final DateTime? processingAt;
    final bool? isProcessing;
    final User? user;

    TripDriverModel({
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
        this.totalCost,
        this.processingDriverId,
        this.processingAt,
        this.isProcessing,
        this.user,
    });

    factory TripDriverModel.fromJson(Map<String, dynamic> json) => TripDriverModel(
        id: json["id"],
        slug: json["slug"],
        requestedAt: json["requested_at"] == null ? null : DateTime.parse(json["requested_at"]),
        acceptedAt: json["accepted_at"] == null ? null : DateTime.parse(json["accepted_at"]),
        startedAt: json["started_at"] == null ? null : DateTime.parse(json["started_at"]),
        deliveredAt: json["delivered_at"],
        completedAt: json["completed_at"] == null ? null : DateTime.parse(json["completed_at"]),
        cancelledAt: json["cancelled_at"],
        paymentAt: json["payment_at"] == null ? null : DateTime.parse(json["payment_at"]),
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
        status: json["status"],
        totalCost: json["total_cost"],
        processingDriverId: json["processing_driver_id"],
        processingAt: json["processing_at"] == null ? null : DateTime.parse(json["processing_at"]),
        isProcessing: json["is_processing"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "requested_at": requestedAt?.toIso8601String(),
        "accepted_at": acceptedAt?.toIso8601String(),
        "started_at": startedAt?.toIso8601String(),
        "delivered_at": deliveredAt,
        "completed_at": completedAt?.toIso8601String(),
        "cancelled_at": cancelledAt,
        "payment_at": paymentAt?.toIso8601String(),
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
        "total_cost": totalCost,
        "processing_driver_id": processingDriverId,
        "processing_at": processingAt?.toIso8601String(),
        "is_processing": isProcessing,
        "user": user?.toJson(),
    };
}

class User {
    final String? name;
    final double? rating;
    final String? avatar;
    final int? ratingCount;

    User({
        this.name,
        this.rating,
        this.avatar,
        this.ratingCount,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        rating: json["rating"]?.toDouble(),
        avatar: json["avatar"],
        ratingCount: json["rating_count"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "rating": rating,
        "avatar": avatar,
        "rating_count": ratingCount,
    };
}
