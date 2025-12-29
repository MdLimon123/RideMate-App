class DriverProfileModel {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? role;
  String? email;
  String? phone;

  bool? isVerified;
  bool? isActive;
  bool? isAdmin;
  bool? isVerificationPending;

  String? avatar;
  String? name;
  DateTime? dateOfBirth;
  String? gender;

  List<String>? drivingLicensePhotos;

  String? vehicleType;
  String? vehicleBrand;
  String? vehicleModel;
  String? vehiclePlateNumber;

  List<String>? vehicleRegistrationPhotos;
  List<String>? vehiclePhotos;

  int? tripGivenCount;
  bool? isStripeConnected;
  double? rating;
  int? ratingCount;

  double? locationLat;
  double? locationLng;
  String? locationAddress;

  DriverProfileModel();

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel()
      ..id = json['id']
      ..createdAt = json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null
      ..updatedAt = json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null
      ..role = json['role']
      ..email = json['email']
      ..phone = json['phone']
      ..isVerified = json['is_verified']
      ..isActive = json['is_active']
      ..isAdmin = json['is_admin']
      ..isVerificationPending = json['is_verification_pending']
      ..avatar = json['avatar']
      ..name = json['name']
      ..dateOfBirth = json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : null
      ..gender = json['gender']
      ..drivingLicensePhotos =
          (json['driving_license_photos'] as List?)
              ?.map((e) => e.toString())
              .toList()
      ..vehicleType = json['vehicle_type']
      ..vehicleBrand = json['vehicle_brand']
      ..vehicleModel = json['vehicle_model']
      ..vehiclePlateNumber = json['vehicle_plate_number']
      ..vehicleRegistrationPhotos =
          (json['vehicle_registration_photos'] as List?)
              ?.map((e) => e.toString())
              .toList()
      ..vehiclePhotos = (json['vehicle_photos'] as List?)
          ?.map((e) => e.toString())
          .toList()
      ..tripGivenCount = json['trip_given_count']
      ..isStripeConnected = json['is_stripe_connected']
      ..rating = json['rating'] != null
          ? double.tryParse(json['rating'].toString())
          : null
      ..ratingCount = json['rating_count']
      ..locationLat = json['location_lat'] != null
          ? double.tryParse(json['location_lat'].toString())
          : null
      ..locationLng = json['location_lng'] != null
          ? double.tryParse(json['location_lng'].toString())
          : null
      ..locationAddress = json['location_address'];
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
      "trip_given_count": tripGivenCount,
      "is_stripe_connected": isStripeConnected,
      "rating": rating,
      "rating_count": ratingCount,
      "location_lat": locationLat,
      "location_lng": locationLng,
      "location_address": locationAddress,
    };
  }
}
