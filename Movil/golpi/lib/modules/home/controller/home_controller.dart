import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/data/service/secure_storage.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/modules/widgets/ui_alert_message.dart';
import 'package:golpi/core/exception/models/error_model.dart';
import 'package:golpi/modules/team/models/team_data_model.dart';
import 'package:golpi/data/repositories/team/team_repository.dart';
import 'package:golpi/core/constants/constant_secure_storage.dart';

class HomeController extends GetxController {
  final TeamRepository teamRepository;
  HomeController(this.teamRepository);

  RxInt indexTabBarView = 0.obs;
  var floatingActionButton = Rx<Widget?>(null);
  var listTeams = <TeamDataModel>[].obs;

  void changeIndexTabBarView(int index) {
    indexTabBarView.value = index;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    switch (index) {
      case 0:
        floatingActionButton.value = null;
        break;
      case 1:
        getTeamsByUserId();

        floatingActionButton.value = Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: FloatingActionButton(
              onPressed: () {
                Get.toNamed(AppPages.registerTeam);
              },
              backgroundColor:
                  Theme.of(Get.context!).colorScheme.secondaryContainer,
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.groups_outlined,
                      size: 30,
                      color: Theme.of(Get.context!).colorScheme.secondary,
                    ),
                  ),
                  Positioned(
                    top: 3,
                    right: 3,
                    child: Icon(
                      Icons.add_circle_sharp,
                      size: 20,
                      color: Theme.of(Get.context!).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ));
        break;
      case 2:
        floatingActionButton.value = null;
        break;
      case 3:
        floatingActionButton.value = null;
        break;
      default:
    }
  }

  Future<void> getTeamsByUserId() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Consultando equipos',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);

      final images = [
        'assets/img/equipo1.jpg',
        'assets/img/equipo2.jpg',
        'assets/img/equipo3.jpg',
        'assets/img/equipo4.jpg',
      ];

      final random = Random();

      listTeams.value =
          (await teamRepository.getTeamByUserId(int.parse(idUsuer!)))
              .map((team) {
        team.image = images[random.nextInt(images.length)];
        return team;
      }).toList();

      Get.back();
    } on CustomException catch (e) {
      listTeams.value = [];
      Get.back();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      listTeams.value = [];
      Get.back();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  void closeSesion() async {
    await SecureStorage().deleteAll();
    Get.offAndToNamed(AppPages.login);
  }
}
