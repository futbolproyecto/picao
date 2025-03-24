import 'package:golpi/modules/user/models/player_profile_model.dart';

class UserModel {
  final int? id;
  final String? name;
  final String? lastName;
  final String? email;
  final String? mobileNumber;
  final DateTime? dateOfBirth;
  final String? nickName;
  final PlayerProfileModel? playerProfile;

  UserModel({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.dateOfBirth,
    this.nickName,
    this.playerProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      mobileNumber: json['mobile_number'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      nickName: json['nick_name'],
      playerProfile: json['player_profile'] != null
          ? PlayerProfileModel.fromJson(json['player_profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'email': email,
      'mobile_number': mobileNumber,
      'date_of_birth': dateOfBirth,
      'nick_name': nickName,
      'player_profile': playerProfile,
    };
  }
}
