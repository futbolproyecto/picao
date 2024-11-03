import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/data/service/secure_storage.dart';

class HomeController extends GetxController {
  HomeController();

  var indexTabBarView = 0.obs;
  var floatingActionButton = FloatingActionButton(
    onPressed: () {},
  ).obs;

  void changeIndexTabBarView(int index) {
    indexTabBarView.value = index;
    switch (index) {
      case 0:
        floatingActionButton.value = FloatingActionButton(
          onPressed: () {},
        );
        break;
      case 1:
        floatingActionButton.value = FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppPages.registerTeam);
          },
          child: const Icon(
            Icons.group_add_outlined,
            size: 30,
          ),
        );
        break;
      case 2:
        floatingActionButton.value = FloatingActionButton(
          onPressed: () {},
        );
        break;
      case 3:
        floatingActionButton.value = FloatingActionButton(
          onPressed: () {},
        );
        break;
      default:
    }
  }

  void closeSesion() async {
    await SecureStorage().deleteAll();
    Get.toNamed(AppPages.login);
  }
}
