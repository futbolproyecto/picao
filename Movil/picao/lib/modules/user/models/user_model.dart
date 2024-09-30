class UserRegisterModel {
  final String names;
  final String surnames;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String cellPhone;
  final DateTime birthdate;

  UserRegisterModel({
    required this.names,
    required this.surnames,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.cellPhone,
    required this.birthdate,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      names: json['names'],
      surnames: json['surnames'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      cellPhone: json['cell_phone'],
      birthdate: json['birthdate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'names': names,
      'surnames': surnames,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'cell_phone': cellPhone,
      'birthdate': birthdate,
    };
  }
}
