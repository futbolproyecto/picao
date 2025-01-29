class LoginRequestModel {
  final String emailOrMobileNumber;
  final String password;

  LoginRequestModel({
    required this.emailOrMobileNumber,
    required this.password,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      emailOrMobileNumber: json['email_or_mobile_number'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email_or_mobile_number': emailOrMobileNumber,
      'password': password,
    };
  }
}
