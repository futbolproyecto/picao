import 'package:get/get.dart';
import 'package:picao/data/providers/user/user_provider.dart';
import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/modules/user/controller/user_controller.dart';

class UserBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<UserRepository>(() => UserRepository(userProvider: Get.find()));
    Get.lazyPut<UserController>(() => UserController(userRepository: Get.find()));
  }
}
