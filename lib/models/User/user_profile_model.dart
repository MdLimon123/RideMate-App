class UserProfileModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? role;
  final String? email;
  final String? phone;
  final bool? isVerified;
  final bool? isActive;
  final bool? isAdmin;
  final bool? isVerificationPending;
  final String? avatar;
  final String? name;
  final DateTime? dateOfBirth;
  final String? gender;

  // New fields
  final List<String>? drivingLicensePhotos;
  final String? vehicleType;
  final String? vehicleBrand;
  final String? vehicleModel;
  final String? vehiclePlateNumber;
  final List<String>? vehicleRegistrationPhotos;
  final List<String>? vehiclePhotos;

  final int? tripReceivedCount;
  final int? tripGivenCount;
  final bool? isStripeConnected;
  final int? rating;
  final int? ratingCount;
  final double? locationLat;
  final double? locationLng;
  final String? locationAddress;

  final Wallet? wallet;

  UserProfileModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.email,
    this.phone,
    this.isVerified,
    this.isActive,
    this.isAdmin,
    this.isVerificationPending,
    this.avatar,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.drivingLicensePhotos,
    this.vehicleType,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehiclePlateNumber,
    this.vehicleRegistrationPhotos,
    this.vehiclePhotos,
    this.tripReceivedCount,
    this.tripGivenCount,
    this.isStripeConnected,
    this.rating,
    this.ratingCount,
    this.locationLat,
    this.locationLng,
    this.locationAddress,
    this.wallet,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      isVerified: json['is_verified'] ?? false,
      isActive: json['is_active'] ?? false,
      isAdmin: json['is_admin'] ?? false,
      isVerificationPending: json['is_verification_pending'] ?? false,
      avatar: json['avatar'],
      name: json['name'] ?? '',
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null,
      gender: json['gender'] ?? '',
      drivingLicensePhotos: json['driving_license_photos'] != null
          ? List<String>.from(json['driving_license_photos'])
          : null,
      vehicleType: json['vehicle_type'],
      vehicleBrand: json['vehicle_brand'],
      vehicleModel: json['vehicle_model'],
      vehiclePlateNumber: json['vehicle_plate_number'],
      vehicleRegistrationPhotos: json['vehicle_registration_photos'] != null
          ? List<String>.from(json['vehicle_registration_photos'])
          : null,
      vehiclePhotos: json['vehicle_photos'] != null
          ? List<String>.from(json['vehicle_photos'])
          : null,
      tripReceivedCount: json['trip_received_count'] ?? 0,
      tripGivenCount: json['trip_given_count'] ?? 0,
      isStripeConnected: json['is_stripe_connected'] ?? false,
      rating: (json['rating'] ?? 0).toInt(),
      ratingCount: (json['rating_count'] ?? 0).toInt(),
      locationLat: json['location_lat'] != null
          ? (json['location_lat'] as num).toDouble()
          : null,
      locationLng: json['location_lng'] != null
          ? (json['location_lng'] as num).toDouble()
          : null,
      locationAddress: json['location_address'],
      wallet: json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "role": role,
      "email": email,
      "phone": phone,
      "is_verified": isVerified,
      "is_active": isActive,
      "is_admin": isAdmin,
      "is_verification_pending": isVerificationPending,
      "avatar": avatar,
      "name": name,
      "date_of_birth": dateOfBirth?.toIso8601String(),
      "gender": gender,
      "driving_license_photos": drivingLicensePhotos,
      "vehicle_type": vehicleType,
      "vehicle_brand": vehicleBrand,
      "vehicle_model": vehicleModel,
      "vehicle_plate_number": vehiclePlateNumber,
      "vehicle_registration_photos": vehicleRegistrationPhotos,
      "vehicle_photos": vehiclePhotos,
      "trip_received_count": tripReceivedCount,
      "trip_given_count": tripGivenCount,
      "is_stripe_connected": isStripeConnected,
      "rating": rating,
      "rating_count": ratingCount,
      "location_lat": locationLat,
      "location_lng": locationLng,
      "location_address": locationAddress,
      "wallet": wallet?.toJson(),
    };
  }
}

class Wallet {
  final double? balance;
  final double? totalExpend;
  final double? totalIncome;

  Wallet({this.balance, this.totalExpend, this.totalIncome});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      balance: json['balance'].runtimeType == int
          ? json['balance'].toDouble()
          : json['balance'] ?? 0.0,
      totalExpend: json['total_expend'].runtimeType == int
          ? json['total_expend'].toDouble()
          : json['total_expend'] ?? 0.0,
      totalIncome: json['total_income'].runtimeType == int
          ? json['total_income'].toDouble()
          : json['total_income'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "balance": balance,
      "total_expend": totalExpend,
      "total_income": totalIncome,
    };
  }
}
