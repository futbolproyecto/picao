import 'package:get/get.dart';
import 'package:picao/data/repositories/login/login_repository.dart';
import 'package:picao/modules/login/models/user_model.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository;
  LoginController({required this.loginRepository});

  var isLoading = false.obs;
  var user = Rxn<UserModel>();

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    user.value = await loginRepository.login(username, password);
    isLoading.value = false;

    if (user.value != null) {
      Get.snackbar('Success', 'Logged in successfully');
    } else {
      Get.snackbar('Error', 'Invalid username or password');
    }
  }
}
