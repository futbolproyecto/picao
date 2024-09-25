import 'package:get/get.dart';
import 'package:picao/data/providers/login/user_provider.dart';
import 'package:picao/data/repositories/login/login_repository.dart';
import 'package:picao/modules/login/controller/login_controller.dart';

class InitialBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut<LoginProvider>(() => LoginProvider());
    Get.lazyPut<LoginRepository>(() => LoginRepository(loginProvider: Get.find()));
    Get.lazyPut<LoginController>(() => LoginController(loginRepository: Get.find()));
  }
}
