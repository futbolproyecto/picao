class PlayerProfileRegisterModel {
  final String nickname;
  final double stature;
  final int weight;
  final int positionPlayerId;
  final int dominantFootId;
  final int zoneId;
  final int cityId;
  final int userId;

  PlayerProfileRegisterModel({
    required this.nickname,
    required this.stature,
    required this.weight,
    required this.positionPlayerId,
    required this.dominantFootId,
    required this.zoneId,
    required this.cityId,
    required this.userId,
  });

  factory PlayerProfileRegisterModel.fromJson(Map<String, dynamic> json) {
    return PlayerProfileRegisterModel(
      nickname: json['nickname'],
      stature: json['stature'],
      weight: json['weight'],
      positionPlayerId: json['position_player_id'],
      dominantFootId: json['dominant_foot_id'],
      zoneId: json['zone_id'],
      cityId: json['city_id'],
      userId: json['user_id'],
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
      'user_id': userId,
    };
  }
}
