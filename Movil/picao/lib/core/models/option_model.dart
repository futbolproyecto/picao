class OptionModel {
  final dynamic id;
  final String? description;

  const OptionModel({
    this.id,
    this.description,
  });

  factory OptionModel.fromJson(Map<dynamic, dynamic> json) => OptionModel(
        id: json["id"],
        description: json["descripcion"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "descripcion": description,
      };
}
