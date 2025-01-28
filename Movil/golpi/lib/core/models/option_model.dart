class OptionModel {
  final dynamic id;
  final String? name;

  const OptionModel({
    this.id,
    this.name,
  });

  factory OptionModel.fromJson(Map<dynamic, dynamic> json) => OptionModel(
        id: json["id"],
        name: json["name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
