class PlayerProfileModel {
  final String? nickname;
  final int? stature;
  final int? weight;
  final int? positionPlayerId;
  final int? dominantFootId;
  final int? zoneId;
  final int? cityId;

  PlayerProfileModel({
    this.nickname,
    this.stature,
    this.weight,
    this.positionPlayerId,
    this.dominantFootId,
    this.zoneId,
    this.cityId,
  });

  factory PlayerProfileModel.fromJson(Map<String, dynamic> json) {
    return PlayerProfileModel(
      nickname: json['nickname'],
      stature: json['stature'],
      weight: json['weight'],
      positionPlayerId: json['position_player_id'],
      dominantFootId: json['dominant_foot_id'],
      zoneId: json['zone_id'],
      cityId: json['city_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'stature': stature,
      'weight': weight,
      'position_player_id': positionPlayerId,
      'dominant_foot_id': dominantFootId,
      'zone_id': zoneId,
      'city_id': cityId,
    };
  }
}
