class LoginRequestModel {
  final String mobileNumber;
  final String password;

  LoginRequestModel({
    required this.mobileNumber,
    required this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      mobileNumber: json['mobile_number'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile_number': mobileNumber,
      'password': password,
    };
  }
}
