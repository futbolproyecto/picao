class SesionModel {
  final String username;
  final String token;
  SesionModel({
    required this.username,
    required this.token,
  });

  factory SesionModel.fromJson(Map<String, dynamic> json) {
    return SesionModel(
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
