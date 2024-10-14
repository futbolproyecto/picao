class ChangePasswordModel {
  final String password;
  final String email;
  final String otp;

  ChangePasswordModel({
    required this.email,
    required this.password,
    required this.otp,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      password: json['password'],
      email: json['email'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
      'otp': otp,
    };
  }
}
