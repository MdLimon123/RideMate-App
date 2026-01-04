class RecentDestination {
  final String address;
  final double lat;
  final double lng;

  RecentDestination({
    required this.address,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toJson() => {
        'address': address,
        'lat': lat,
        'lng': lng,
      };

  factory RecentDestination.fromJson(Map<String, dynamic> json) {
    return RecentDestination(
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
