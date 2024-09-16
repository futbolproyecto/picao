import 'package:get/get.dart';
import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/modules/user/models/user_model.dart';

class LoginController extends GetxController {
  final UserRepository userRepository;
  LoginController({required this.userRepository});

  var isLoading = false.obs;
  var user = Rxn<UserModel>();

  Future<void> login(String username, String password) async {
    isLoading.value = true;
    user.value = await userRepository.login(username, password);
    isLoading.value = false;

    if (user.value != null) {
      Get.snackbar('Success', 'Logged in successfully');
    } else {
      Get.snackbar('Error', 'Invalid username or password');
    }
  }
}
