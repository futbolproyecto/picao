import 'package:picao/core/utils/utility.dart';

class UserRegisterModel {
  final String name;
  final String lastName;
  final String email;
  final String password;
  final String mobileNumber;
  final DateTime dateOfBirth;

  UserRegisterModel({
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.mobileNumber,
    required this.dateOfBirth,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      mobileNumber: json['mobile_number'],
      dateOfBirth: json['date_of_birth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'last_name': lastName,
      'email': email,
      'password': password,
      'mobile_number': mobileNumber,
      'date_of_birth': Utility().formatDate(dateOfBirth),
    };
  }
}
