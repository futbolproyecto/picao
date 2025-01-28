class SesionModel {
  final int idUsuer;
  final String mobileNumber;
  final String token;
  SesionModel({
    required this.idUsuer,
    required this.mobileNumber,
    required this.token,
  });

  factory SesionModel.fromJson(Map<String, dynamic> json) {
    return SesionModel(
      idUsuer: json['id'],
      mobileNumber: json['mobile_number'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': idUsuer,
      'mobile_number': mobileNumber,
      'token': token,
    };
  }
}
