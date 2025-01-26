import 'package:get/get.dart';
import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/modules/user/controller/profile_controller.dart';
import 'package:picao/modules/user/controller/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<UserController>(
        () => UserController(userRepository: Get.find()));
    Get.lazyPut<ProfileController>(
        () => ProfileController(userRepository: Get.find()));
  }
}
