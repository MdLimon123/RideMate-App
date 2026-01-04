class RiderHistoryModel {
  final Meta? meta;
  final List<RiderHistoryItem> data;

  RiderHistoryModel({
    this.meta,
    this.data = const [],
  });

  factory RiderHistoryModel.fromJson(Map<String, dynamic> json) {
    return RiderHistoryModel(
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data: json['data'] != null
          ? List<RiderHistoryItem>.from(
              json['data'].map((x) => RiderHistoryItem.fromJson(x)),
            )
          : [],
    );
  }
}

class Meta {
  final Pagination? pagination;

  Meta({this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      pagination:
          json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }
}

class Pagination {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;

  Pagination({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPages: json['totalPages'],
    );
  }
}

class RiderHistoryItem {
  final String? id;
  final String? slug;
  final int? time;
  final String? date;
  final String? userId;
  final String? driverId;
  final String? pickupAddress;
  final String? dropoffAddress;
  final String? status;
  final int? totalCost;
  final bool isProcessing;
  final bool isParcel;
  final String? parcelType;
  final int? weight;
  final int? amount;
  final List<String> deliveryProofFiles;
  final User? user;
  final User? driver; // Keep the driver field
  final DateTime? completedAt; // Added field

  RiderHistoryItem({
    this.id,
    this.slug,
    this.time,
    this.date,
    this.userId,
    this.driverId,
    this.pickupAddress,
    this.dropoffAddress,
    this.status,
    this.totalCost,
    this.isProcessing = false,
    this.isParcel = false,
    this.parcelType,
    this.weight,
    this.amount,
    this.deliveryProofFiles = const [],
    this.user,
    this.driver,
    this.completedAt,
  });

  factory RiderHistoryItem.fromJson(Map<String, dynamic> json) {
    return RiderHistoryItem(
      id: json['id'],
      slug: json['slug'],
      time: json['time'],
      date: json['date'],
      userId: json['user_id'],
      driverId: json['driver_id'],
      pickupAddress: json['pickup_address'],
      dropoffAddress: json['dropoff_address'],
      status: json['status'],
      totalCost: json['total_cost'],
      isProcessing: json['is_processing'] ?? false,
      isParcel: json['is_parcel'] ?? false,
      parcelType: json['parcel_type'],
      weight: json['weight'],
      amount: json['amount'],
      deliveryProofFiles: json['delivery_proof_files'] != null
          ? List<String>.from(json['delivery_proof_files'])
          : [],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      driver: json['driver'] != null ? User.fromJson(json['driver']) : null,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
    );
  }
}
class User {
  final String? name;
  final String? avatar;

  User({this.name, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}