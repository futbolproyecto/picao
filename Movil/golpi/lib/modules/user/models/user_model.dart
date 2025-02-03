class UserModel {
  final String name;
  final String lastName;
  final String email;
  final String mobileNumber;
  //final DateTime dateOfBirth;
  final String? nickName;

  UserModel({
    required this.name,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    //required this.dateOfBirth,
    this.nickName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      //dateOfBirth: json['dateOfBirth'],
      nickName: json['nickName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
      //'date_of_birth': Utility().formatDate(dateOfBirth),
      'nickName': nickName,
    };
  }
}
