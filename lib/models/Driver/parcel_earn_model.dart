class ParcelEarnModel {
  final ParcelEarnMeta meta;
  final List<ParcelEarnItem> data;

  ParcelEarnModel({required this.meta, required this.data});

  factory ParcelEarnModel.fromJson(Map<String, dynamic> json) {
    return ParcelEarnModel(
      meta: ParcelEarnMeta.fromJson(json['meta']),
      data: List<ParcelEarnItem>.from(
        json['data'].map((x) => ParcelEarnItem.fromJson(x)),
      ),
    );
  }
}

class ParcelEarnMeta {
  final ParcelEarnPagination pagination;
  final int totalCount;
  final num totalEarnings;
  final int totalTime;

  ParcelEarnMeta({
    required this.pagination,
    required this.totalCount,
    required this.totalEarnings,
    required this.totalTime,
  });

  factory ParcelEarnMeta.fromJson(Map<String, dynamic> json) {
    return ParcelEarnMeta(
      pagination: ParcelEarnPagination.fromJson(json['pagination']),
      totalCount: json['total_count'],
      totalEarnings: json['total_earnings'],
      totalTime: json['total_time'],
    );
  }
}

class ParcelEarnPagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  ParcelEarnPagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory ParcelEarnPagination.fromJson(Map<String, dynamic> json) {
    return ParcelEarnPagination(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPages: json['totalPages'],
    );
  }
}

/// ✅ Simplified ParcelEarnItem for aggregated daily data
class ParcelEarnItem {
  final String date;
  final num totalCost;
  final int totalTime;
  final int totalCount;

  ParcelEarnItem({
    required this.date,
    required this.totalCost,
    required this.totalTime,
    required this.totalCount,
  });

  factory ParcelEarnItem.fromJson(Map<String, dynamic> json) {
    return ParcelEarnItem(
      date: json['date'],
      totalCost: json['total_cost'],
      totalTime: json['total_time'],
      totalCount: json['total_count'],
    );
  }
}
