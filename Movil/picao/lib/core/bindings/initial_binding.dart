import 'package:get/get.dart';
import 'package:picao/data/providers/user/user_provider.dart';
import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/modules/user/controller/login_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<UserRepository>(() => UserRepository(userProvider: Get.find()));
    Get.lazyPut<LoginController>(() => LoginController(userRepository: Get.find()));
  }
}
