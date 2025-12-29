class DriverModel {
  final String id;
  final String name;
  final String avatar;

  final String? role;
  final String? gender;

  final String? vehicleType;
  final String? vehicleBrand;
  final String? vehicleModel;
  final String? vehiclePlateNumber;

  final double rating;
  final int ratingCount;
  final int tripGivenCount;

  final double locationLat;
  final double locationLng;

  DriverModel({
    required this.id,
    required this.name,
    required this.avatar,
    this.role,
    this.gender,
    this.vehicleType,
    this.vehicleBrand,
    this.vehicleModel,
    this.vehiclePlateNumber,
    required this.rating,
    required this.ratingCount,
    required this.tripGivenCount,
    required this.locationLat,
    required this.locationLng,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown Driver',
      avatar: json['avatar'] ?? '',
      role: json['role'],
      gender: json['gender'],
      vehicleType: json['vehicle_type'],
      vehicleBrand: json['vehicle_brand'],
      vehicleModel: json['vehicle_model'],
      vehiclePlateNumber: json['vehicle_plate_number'],
      rating: (json['rating'] ?? 0).toDouble(),
      ratingCount: json['rating_count'] ?? 0,
      tripGivenCount: json['trip_given_count'] ?? 0,
      locationLat: (json['location_lat'] ?? 0).toDouble(),
      locationLng: (json['location_lng'] ?? 0).toDouble(),
    );
  }
}
