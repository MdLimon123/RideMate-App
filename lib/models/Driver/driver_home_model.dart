class HomeModel {
  final double? totalCount;
  final double? totalEarnings;
  final double? totalTime;

  HomeModel({
    this.totalCount,
    this.totalEarnings,
    this.totalTime,
  });

 
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      totalCount: json['total_count'] == null ?0.0 :json['total_count'].runtimeType==int ?double.parse(json['total_count'].toString()):json['total_count'],
      totalEarnings: json['total_earnings'] == null ? 0.0: json['total_earnings'].runtimeType==int ?double.parse(json['total_earnings'].toString()):json['total_earnings'],
      totalTime: json['total_time'] == null ?0.0 : json['total_time'].runtimeType==int ?double.parse(json['total_time'].toString()):json['total_time'],
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
