class CountryModel {
  final dynamic id;
  final String? name;
  final String? cellPrefix;
  final String? isoCode;

  const CountryModel({
    this.id,
    this.name,
    this.cellPrefix,
    this.isoCode,
  });

  factory CountryModel.fromJson(Map<dynamic, dynamic> json) => CountryModel(
        id: json["id"],
        name: json["name"],
        cellPrefix: json["cell_prefix"],
        isoCode: json["iso_code"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cell_prefix": cellPrefix,
        "iso_code": isoCode,
      };

  String get flagAsset => 'icons/flags/png100px/${isoCode?.toLowerCase()}.png';
}
