class TeamDataModel {
  final int? id;
  final String? name;
  final int? numberOfPlayers;
  final String? positionPlayer;

  TeamDataModel({
     this.id,
     this.name,
     this.numberOfPlayers,
     this.positionPlayer,
  });

  factory TeamDataModel.fromJson(Map<String, dynamic> json) {
    return TeamDataModel(
      id: json['id'],
      name: json['name'],
      numberOfPlayers: json['number_of_players'],
      positionPlayer: json['position_player'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number_of_players': numberOfPlayers,
      'position_player': positionPlayer,
    };
  }
}
