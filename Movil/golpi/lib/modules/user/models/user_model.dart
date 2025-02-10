class UserModel {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String mobileNumber;
  //final DateTime dateOfBirth;
  final String? nickName;

  UserModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    //required this.dateOfBirth,
    this.nickName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      email: json['email'],
      mobileNumber: json['mobile_number'],
      //dateOfBirth: json['dateOfBirth'],
      nickName: json['nick_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'email': email,
      'mobile_number': mobileNumber,
      //'date_of_birth': Utility().formatDate(dateOfBirth),
      'nick_name': nickName,
    };
  }
}
