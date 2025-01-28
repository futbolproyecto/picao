class TeamDataModel {
  final int? id;
  final String? name;

  TeamDataModel({
     this.id,
     this.name,
  });

  factory TeamDataModel.fromJson(Map<String, dynamic> json) {
    return TeamDataModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
