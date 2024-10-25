class SesionModel {
  final String mobileNumber;
  final String token;
  SesionModel({
    required this.mobileNumber,
    required this.token,
  });

  factory SesionModel.fromJson(Map<String, dynamic> json) {
    return SesionModel(
      mobileNumber: json['mobile_number'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile_number': mobileNumber,
      'token': token,
    };
  }
}
