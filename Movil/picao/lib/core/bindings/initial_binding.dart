import 'package:get/get.dart';
import 'package:picao/data/repositories/login/login_repository.dart';
import 'package:picao/modules/login/controller/login_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRepository>(() => LoginRepository());
    Get.lazyPut<LoginController>(
        () => LoginController(loginRepository: Get.find()));
  }
}
