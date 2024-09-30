//import 'package:get/get.dart';
import 'package:picao/data/providers/login/user_provider.dart';
import 'package:picao/modules/login/models/login_model.dart';

class LoginRepository {
  final LoginProvider loginProvider;
  LoginRepository({required this.loginProvider});

  Future<LoginModel?> login(String username, String password) async {
    // Simulación de una petición HTTP para login
    await Future.delayed(const Duration(seconds: 2));
    if (username == 'user' && password == 'password') {
      return LoginModel(username: username, token: '12345');
    }
    return null;
  }
}
