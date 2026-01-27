// To parse this JSON data, do
//
//     final recoverTripModel = recoverTripModelFromJson(jsonString);

import 'dart:convert';

import 'package:radeef/controllers/UserController/tripstate_controller.dart' show TripStatus;

RecoverTripModel recoverTripModelFromJson(String str) => RecoverTripModel.fromJson(json.decode(str));

String recoverTripModelToJson(RecoverTripModel data) => json.encode(data.toJson());

class RecoverTripModel {
    final String? id;
    final String? slug;
    final DateTime? requestedAt;
    final dynamic acceptedAt;
    final dynamic startedAt;
    final dynamic arrivedAt;
    final dynamic paymentAt;
    final dynamic completedAt;
    final dynamic cancelledAt;
    final dynamic time;
    final DateTime? date;
    final String? userId;
    final dynamic driverId;
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
    final String? processingDriverId;
    final DateTime? processingAt;
    final bool? isProcessing;
    final User? user;
    final dynamic driver;

    RecoverTripModel({
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
    });

    factory RecoverTripModel.fromJson(Map<String, dynamic> json) => RecoverTripModel(
        id: json["id"],
        slug: json["slug"],
        requestedAt: json["requested_at"] == null ? null : DateTime.parse(json["requested_at"]),
        acceptedAt: json["accepted_at"],
        startedAt: json["started_at"],
        arrivedAt: json["arrived_at"],
        paymentAt: json["payment_at"],
        completedAt: json["completed_at"],
        cancelledAt: json["cancelled_at"],
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
       // status: json["status"],

        status: TripStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
        totalCost: json["total_cost"],
        processingDriverId: json["processing_driver_id"],
        processingAt: json["processing_at"] == null ? null : DateTime.parse(json["processing_at"]),
        isProcessing: json["is_processing"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        driver: json["driver"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "requested_at": requestedAt?.toIso8601String(),
        "accepted_at": acceptedAt,
        "started_at": startedAt,
        "arrived_at": arrivedAt,
        "payment_at": paymentAt,
        "completed_at": completedAt,
        "cancelled_at": cancelledAt,
        "time": time,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
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
        "driver": driver,
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
        rating: json["rating"]?.toDouble(),
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
