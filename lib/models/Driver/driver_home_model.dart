class HomeModel {
  final int? totalCount;
  final int? totalEarnings;
  final int? totalTime;

  HomeModel({
    this.totalCount,
    this.totalEarnings,
    this.totalTime,
  });

 
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      totalCount: json['total_count'] != null ? json['total_count'] as int : null,
      totalEarnings: json['total_earnings'] != null ? json['total_earnings'] as int : null,
      totalTime: json['total_time'] != null ? json['total_time'] as int : null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'total_count': totalCount,
      'total_earnings': totalEarnings,
      'total_time': totalTime,
    };
  }
}
