class UserTeamModel {
  final int? teamId;
  final int? userId;

  UserTeamModel({
     this.teamId,
     this.userId,
  });

  factory UserTeamModel.fromJson(Map<String, dynamic> json) {
    return UserTeamModel(
      teamId: json['team_id'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team_id': teamId,
      'user_id': userId,
    };
  }
}
