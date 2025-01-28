class TeamRegisterModel {
  final String name;
  final int zoneId;
  final int cityId;
  final int userId;

  TeamRegisterModel({
    required this.name,
    required this.zoneId,
    required this.cityId,
    required this.userId,
  });

  factory TeamRegisterModel.fromJson(Map<String, dynamic> json) {
    return TeamRegisterModel(
      name: json['name'],
      zoneId: json['zone_id'],
      cityId: json['city_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'zone_id': zoneId,
      'city_id': cityId,
      'user_id': userId,
    };
  }
}
