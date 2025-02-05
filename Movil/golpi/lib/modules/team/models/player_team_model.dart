class PlayerTeamModel {
  final String? nickName;
  final String? positionPlayer;

  PlayerTeamModel({
     this.nickName,
     this.positionPlayer,
  });

  factory PlayerTeamModel.fromJson(Map<String, dynamic> json) {
    return PlayerTeamModel(
      nickName: json['nick_name'],
      positionPlayer: json['position_player'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nick_name': nickName,
      'position_player': positionPlayer,
    };
  }
}
