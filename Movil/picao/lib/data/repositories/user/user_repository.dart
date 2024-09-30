import 'package:picao/data/providers/user/user_provider.dart';
import 'package:picao/modules/user/models/user_model.dart';

class UserRepository {
  final UserProvider userProvider;
  UserRepository({required this.userProvider});

  Future<UserRegisterModel?> registerUser(
      UserRegisterModel userRegisterModel) async {
    // Simulación de una petición HTTP para login
    await Future.delayed(const Duration(seconds: 2));
    if (userRegisterModel.password == 'Golpi') {
      return userRegisterModel;
    }
    return null;
  }
}
