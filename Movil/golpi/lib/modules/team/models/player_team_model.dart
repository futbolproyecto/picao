class PlayerTeamModel {
  final String? name;
  final String? lastName;
  final String? nickName;
  final String? positionPlayer;

  PlayerTeamModel({
     this.name,
     this.lastName,
     this.nickName,
     this.positionPlayer,
  });

  factory PlayerTeamModel.fromJson(Map<String, dynamic> json) {
    return PlayerTeamModel(
      name: json['name'],
      nickName: json['nick_name'],
      lastName: json['last_name'],
      positionPlayer: json['position_player'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'last_name': lastName,
      'nick_name': nickName,
      'position_player': positionPlayer,
    };
  }
}
