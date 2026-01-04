class UserInfoModel {
  final String accessToken;
  final String refreshToken;
  final User user;

  UserInfoModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user': user.toJson(),
    };
  }
}

class User {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String role;
  final String email;
  final String? phone;
  final bool isVerified;
  final bool isActive;
  final bool isAdmin;
  final bool isVerificationPending;
  final String? avatar;
  final String name;
  final DateTime dateOfBirth;
  final String gender;
  final int tripReceivedCount;
  final bool isStripeConnected;
  final int rating;
  final int ratingCount;
  final String? locationAddress;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.email,
    this.phone,
    required this.isVerified,
    required this.isActive,
    required this.isAdmin,
    required this.isVerificationPending,
    this.avatar,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.tripReceivedCount,
    required this.isStripeConnected,
    required this.rating,
    required this.ratingCount,
    this.locationAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'], // nullable
      isVerified: json['is_verified'] ?? false,
      isActive: json['is_active'] ?? false,
      isAdmin: json['is_admin'] ?? false,
      isVerificationPending: json['is_verification_pending'] ?? false,
      avatar: json['avatar'], // nullable
      name: json['name'] ?? '',
      dateOfBirth: DateTime.parse(
        json['date_of_birth'] ?? DateTime.now().toIso8601String(),
      ),
      gender: json['gender'] ?? '',
      tripReceivedCount: json['trip_received_count'] ?? 0,
      isStripeConnected: json['is_stripe_connected'] ?? false,
      rating: (json['rating'] ?? 0).toInt(),
      ratingCount: (json['rating_count'] ?? 0).toInt(),

      locationAddress: json['location_address'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'role': role,
      'email': email,
      'phone': phone,
      'is_verified': isVerified,
      'is_active': isActive,
      'is_admin': isAdmin,
      'is_verification_pending': isVerificationPending,
      'avatar': avatar,
      'name': name,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'trip_received_count': tripReceivedCount,
      'is_stripe_connected': isStripeConnected,
      'rating': rating,
      'rating_count': ratingCount,
      'location_address': locationAddress,
    };
  }
}
