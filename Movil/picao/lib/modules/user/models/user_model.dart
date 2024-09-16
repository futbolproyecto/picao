class UserModel {
  final String username;
  final String token;

  UserModel({required this.username, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'token': token,
    };
  }
}
