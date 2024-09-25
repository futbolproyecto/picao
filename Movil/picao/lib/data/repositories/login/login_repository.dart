//import 'package:get/get.dart';
import 'package:picao/data/providers/login/user_provider.dart';
import 'package:picao/modules/login/models/user_model.dart';

class LoginRepository {
  final LoginProvider loginProvider;
  LoginRepository({required this.loginProvider});

  Future<UserModel?> login(String username, String password) async {
    // Simulación de una petición HTTP para login
    await Future.delayed(const Duration(seconds: 2));
    if (username == 'user' && password == 'password') {
      return UserModel(username: username, token: '12345');
    }
    return null;
  }
}
