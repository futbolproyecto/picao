import 'package:get/get.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/data/service/secure_storage.dart';

class HomeController extends GetxController {
  HomeController();

  var indexTabBarView = 0.obs;

  void changeIndexTabBarView(int index) {
    indexTabBarView.value = index;
  }

  void closeSesion() async {
    await SecureStorage().deleteAll();
    Get.toNamed(AppPages.login);
  }
}
