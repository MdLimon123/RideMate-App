class TripEarnModel {
  final TripEarnMeta meta;
  final List<TripEarnItem> data;

  TripEarnModel({
    required this.meta,
    required this.data,
  });

  factory TripEarnModel.fromJson(Map<String, dynamic> json) {
    return TripEarnModel(
      meta: TripEarnMeta.fromJson(json['meta']),
      data: List<TripEarnItem>.from(
        json['data'].map((x) => TripEarnItem.fromJson(x)),
      ),
    );
  }
}

class TripEarnMeta {
  final TripEarnPagination pagination;
  final int totalCount;
  final num totalEarnings;
  final int totalTime;

  TripEarnMeta({
    required this.pagination,
    required this.totalCount,
    required this.totalEarnings,
    required this.totalTime,
  });

  factory TripEarnMeta.fromJson(Map<String, dynamic> json) {
    return TripEarnMeta(
      pagination: TripEarnPagination.fromJson(json['pagination']),
      totalCount: json['total_count'],
      totalEarnings: json['total_earnings'],
      totalTime: json['total_time'],
    );
  }
}

class TripEarnPagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  TripEarnPagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory TripEarnPagination.fromJson(Map<String, dynamic> json) {
    return TripEarnPagination(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPages: json['totalPages'],
    );
  }
}

class TripEarnItem {
  final String date;
  final num totalCost;
  final int totalTime;
  final int totalCount;

  TripEarnItem({
    required this.date,
    required this.totalCost,
    required this.totalTime,
    required this.totalCount,
  });

  factory TripEarnItem.fromJson(Map<String, dynamic> json) {
    return TripEarnItem(
      date: json['date'],
      totalCost: json['total_cost'],
      totalTime: json['total_time'],
      totalCount: json['total_count'],
    );
  }
}
