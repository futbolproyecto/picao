//import 'package:get/get.dart';
import 'package:picao/data/providers/user/user_provider.dart';
import 'package:picao/modules/user/models/user_model.dart';

class UserRepository {
  final UserProvider userProvider;
  UserRepository({required this.userProvider});

  Future<UserModel?> login(String username, String password) async {
    // Simulación de una petición HTTP para login
    await Future.delayed(const Duration(seconds: 2));
    if (username == 'user' && password == 'password') {
      return UserModel(username: username, token: '12345');
    }
    return null;
  }
}
