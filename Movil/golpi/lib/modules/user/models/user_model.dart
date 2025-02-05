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
      lastName: json['last_name'],
      email: json['email'],
      mobileNumber: json['mobile_number'],
      //dateOfBirth: json['dateOfBirth'],
      nickName: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'last_name': lastName,
      'email': email,
      'mobile_number': mobileNumber,
      //'date_of_birth': Utility().formatDate(dateOfBirth),
      'username': nickName,
    };
  }
}
