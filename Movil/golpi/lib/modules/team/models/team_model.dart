import 'package:golpi/modules/team/models/player_team_model.dart';

class TeamModel {
  final int? id;
  final String? name;
  final List<PlayerTeamModel>? players;

  TeamModel({
    this.id,
    this.name,
    this.players,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      name: json['name'],
      players: (json['players'] as List)
          .map((player) => PlayerTeamModel.fromJson(player))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'players': players,
    };
  }
}
