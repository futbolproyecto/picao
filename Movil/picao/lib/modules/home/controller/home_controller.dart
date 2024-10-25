import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();

  var indexTabBarView = 0.obs;

  void changeIndexTabBarView(int index) {
    indexTabBarView.value = index;
  }
}
