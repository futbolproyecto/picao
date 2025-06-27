class FieldAvailableModel {
  final String? id;
  final DateTime? date;
  final String? startTime;
  final String? status;
  final String? dayOfWeek;
  final String? nameField;
  final String? nameEstablishment;
  final String? addressEstablishment;

  FieldAvailableModel({
    this.id,
    this.date,
    this.startTime,
    this.status,
    this.dayOfWeek,
    this.nameField,
    this.nameEstablishment,
    this.addressEstablishment,
  });

  factory FieldAvailableModel.fromJson(Map<String, dynamic> json) {
    return FieldAvailableModel(
      id: json['id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      startTime: json['start_time'],
      status: json['status'],
      dayOfWeek: json['day_of_week'],
      nameField: json['name_field'],
      nameEstablishment: json['name_establishment'],
      addressEstablishment: json['address_establishment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'start_time': startTime,
      'status': status,
      'day_of_week': dayOfWeek,
      'name_field': nameField,
      'name_establishment': nameEstablishment,
      'address_establishment': addressEstablishment,
    };
  }
}
