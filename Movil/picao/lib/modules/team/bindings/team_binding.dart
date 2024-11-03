import 'package:get/get.dart';
import 'package:picao/modules/team/controller/team_controller.dart';

class TeamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamController>(() => TeamController());
  }
}
