import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golpi/core/constants/constant_secure_storage.dart';
import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/core/exception/models/error_model.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/data/repositories/team/team_repository.dart';
import 'package:golpi/data/service/secure_storage.dart';
import 'package:golpi/modules/team/models/team_data_model.dart';
import 'package:golpi/modules/widgets/ui_alert_message.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class HomeController extends GetxController {
  final TeamRepository teamRepository;
  HomeController(this.teamRepository);

  RxInt indexTabBarView = 0.obs;
  var floatingActionButton = FloatingActionButton(onPressed: () {}).obs;
  var listTeams = <TeamDataModel>[].obs;

  void changeIndexTabBarView(int index) {
    indexTabBarView.value = index;
    switch (index) {
      case 0:
        floatingActionButton.value = FloatingActionButton(
          onPressed: () {},
        );
        break;
      case 1:
        getTeamsByUserId();
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

      listTeams.value =
          await teamRepository.getTeamByUserId(int.parse(idUsuer!));
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
