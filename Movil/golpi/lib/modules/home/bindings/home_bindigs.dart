import 'package:get/get.dart';
import 'package:golpi/data/repositories/team/team_repository.dart';
import 'package:golpi/data/repositories/user/user_repository.dart';
import 'package:golpi/modules/home/controller/home_controller.dart';
import 'package:golpi/modules/team/controller/team_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamRepository>(() => TeamRepository());
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
    Get.lazyPut<TeamController>(() =>
        TeamController(userRepository: Get.find(), teamRepository: Get.find()));
  }
}
