import 'package:get/get.dart';
import 'package:golpi/data/repositories/team/team_repository.dart';
import 'package:golpi/data/repositories/user/user_repository.dart';
import 'package:golpi/modules/team/controller/team_controller.dart';

class TeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<TeamRepository>(() => TeamRepository());
    Get.lazyPut<TeamController>(() =>
        TeamController(userRepository: Get.find(), teamRepository: Get.find()));
  }
}
