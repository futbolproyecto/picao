import 'package:get/get.dart';
import 'package:golpi/data/repositories/team/team_repository.dart';
import 'package:golpi/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamRepository>(() => TeamRepository());
    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
