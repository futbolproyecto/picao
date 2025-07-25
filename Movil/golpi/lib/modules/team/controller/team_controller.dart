import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/core/models/option_model.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/data/service/secure_storage.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:golpi/modules/team/models/team_model.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/modules/widgets/ui_alert_message.dart';
import 'package:golpi/core/exception/models/error_model.dart';
import 'package:golpi/modules/team/models/user_team_model.dart';
import 'package:golpi/modules/home/controller/home_controller.dart';
import 'package:golpi/data/repositories/team/team_repository.dart';
import 'package:golpi/core/constants/constant_secure_storage.dart';
import 'package:golpi/data/repositories/user/user_repository.dart';
import 'package:golpi/modules/team/models/team_register_model.dart';
import 'package:golpi/modules/team/widgets/modal_search_user_phone_page.dart';

class TeamController extends GetxController {
  final UserRepository userRepository;
  final TeamRepository teamRepository;
  TeamController({required this.userRepository, required this.teamRepository});

  var listZonesOption = [OptionModel()].obs;
  var listCitiesOption = [OptionModel()].obs;
  var teamId = 0.obs;
  var isLoading = false.obs;
  var teamModel = Rx<TeamModel?>(null);
  var errorModel = Rx<ErrorModel?>(null);

  var formMobileNumer = FormGroup({
    'mobile_phone': FormControl<String>(
      validators: [Validators.required],
    ),
  });

  var formTeamRegistrer = FormGroup({
    'team_name': FormControl<String>(
      validators: [Validators.required, Validators.maxLength(50)],
    ),
    'representative_name': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'contact_number': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'city': FormControl<OptionModel>(validators: [Validators.required]),
    'zone': FormControl<OptionModel>(validators: [Validators.required]),
  });

  Future<void> loadDataTeam() async {
    try {
      isLoading.value = true;

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);
      final userModel = await userRepository.getUserById(int.parse(idUsuer!));

      formTeamRegistrer.control('representative_name').value =
          '${userModel.name} ${userModel.lastName}';
      formTeamRegistrer.control('contact_number').value =
          userModel.mobileNumber;
      formTeamRegistrer.control('representative_name').markAsDisabled();
      formTeamRegistrer.control('contact_number').markAsDisabled();
      listZonesOption.value = await userRepository.getAllZones();
      listCitiesOption.value = await userRepository.getAllCities();

      isLoading.value = false;
    } on CustomException catch (e) {
      isLoading.value = false;
      errorModel.value = e.error;
    } on Exception catch (_) {
      isLoading.value = false;
      errorModel.value = ErrorModel().uncontrolledError();
    }
  }

  Future<void> registerTeam() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Registrando equipo',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);

      await teamRepository.createTeam(TeamRegisterModel(
        name: formTeamRegistrer.control('team_name').value,
        zoneId: formTeamRegistrer.control('zone').value.id,
        cityId: formTeamRegistrer.control('zone').value.id,
        userId: int.parse(idUsuer!),
      ));
      Get.back();
      UiAlertMessage(Get.context!).success(
          message: S().exitoRegistrar,
          barrierDismissible: false,
          actionButtom: () {
            formTeamRegistrer.reset();
            Get.offNamed(AppPages.home);
          });
    } on CustomException catch (e) {
      Get.back();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      Get.back();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> openModalSearchUserPhone() async {
    try {
      formMobileNumer.unfocus();
      formMobileNumer.reset();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Confirmando informacion',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      Get.back();
      UiAlertMessage(Get.context!).custom(
          child: ModalSearchUserPhonePage().modalUserPhone(
            context: Get.context!,
            formMobileNumer: formMobileNumer,
          ),
          actions: [
            UiButtoms(
                    onPressed: () async {
                      if (formMobileNumer.valid) {
                        Get.back();
                        await getUserByMobileNumber();
                      } else {
                        formMobileNumer.markAllAsTouched();
                      }
                    },
                    title: S().buscar)
                .textButtom(color: Theme.of(Get.context!).colorScheme.primaryContainer),
            UiButtoms(
                    onPressed: () {
                      Get.back();
                    },
                    title: S().cerrar)
                .textButtom(),
          ]);
    } on CustomException catch (e) {
      Get.back();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      Get.back();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> getUserByMobileNumber() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Consultando jugador',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      final response = await teamRepository
          .getUserByMobileNumber(formMobileNumer.control('mobile_phone').value);

      Get.back();
      UiAlertMessage(Get.context!).custom(
          child: ModalSearchUserPhonePage().modalUserInformation(
            context: Get.context!,
            userModel: response,
          ),
          actions: [
            UiButtoms(
                    onPressed: () async {
                      Get.back();
                      addUserTeam(response.id!,
                          '${response.name} ${response.lastName}');
                    },
                    title: S().agregarJugador)
                .textButtom(color: Theme.of(Get.context!).colorScheme.primaryContainer),
            UiButtoms(
                    onPressed: () {
                      Get.back();
                    },
                    title: S().cancelar)
                .textButtom(),
          ]);
    } on CustomException catch (e) {
      Get.back();
      if (e.error.code == 'E9') {
        UiAlertMessage(Get.context!)
            .alert(message: e.error.error ?? '', actions: [
          UiButtoms(
                  onPressed: () async {
                    Get.back();
                    openWhatsApp(formMobileNumer.control('mobile_phone').value);
                  },
                  title: S().invitarJugador)
              .textButtom(color: Theme.of(Get.context!).colorScheme.primaryContainer),
          UiButtoms(
                  onPressed: () {
                    Get.back();
                  },
                  title: S().cerrar)
              .textButtom(),
        ]);
      } else {
        UiAlertMessage(Get.context!)
            .error(message: '${e.error.error}\n${e.error.recommendation}');
      }
    } on Exception catch (_) {
      Get.back();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> addUserTeam(int userId, String playerName) async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Agregando jugador',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      await teamRepository.addUserTeam(UserTeamModel(
        teamId: teamId.value,
        userId: userId,
      ));

      Get.back();

      UiAlertMessage(Get.context!).success(
          actionButtom: () {
            Get.back();
          },
          message: S().jugadorAgregadoEquipo(playerName.toUpperCase()));

      getTeamsByUserId(teamId.value);
    } on CustomException catch (e) {
      Get.back();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      Get.back();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  void openWhatsApp(String phoneNumber) async {
    final String message = Uri.encodeComponent(S().invitacionDescargaGolpi);

    final String whatsappUrl = "https://wa.me/$phoneNumber?text=$message";

    if (!await launchUrl(Uri.parse(whatsappUrl))) {
      throw Exception('Could not launch $whatsappUrl');
    }
  }

  Future<void> getTeamsByUserId(int teamId) async {
    try {
      isLoading.value = true;

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);
      teamModel.value =
          await teamRepository.getTeamsByUserId(int.parse(idUsuer!), teamId);

      isLoading.value = false;
    } on CustomException catch (e) {
      isLoading.value = false;
      errorModel.value = e.error;
    } on Exception catch (_) {
      isLoading.value = false;
      errorModel.value = ErrorModel().uncontrolledError();
    }
  }

  Future<void> modalLeaveTeam(HomeController homeController) async {
    try {
      UiAlertMessage(Get.context!).alert(
          message:
              S().confirmacionSalirEquipo(teamModel.value!.name!.toUpperCase()),
          actions: [
            UiButtoms(
                    onPressed: () {
                      Get.back();
                      leaveTeam(homeController);
                    },
                    title: S().salir)
                .textButtom(color: Theme.of(Get.context!).colorScheme.primaryContainer),
            UiButtoms(
                    onPressed: () {
                      Get.back();
                    },
                    title: S().cerrar)
                .textButtom(),
          ]);
    } on CustomException catch (e) {
      Get.back();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      Get.back();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> leaveTeam(HomeController homeController) async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Saliendo del equipo',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);
      await teamRepository.leaveTeam(
        int.parse(idUsuer!),
        teamId.value,
      );

      Get.back();
      UiAlertMessage(Get.context!).success(
          actionButtom: () {
            homeController.indexTabBarView.value = 1;
            Get.toNamed(AppPages.home);
            homeController.getTeamsByUserId();
          },
          message: S().exitoSalirEquipo(teamModel.value!.name!.toUpperCase()));
    } on CustomException catch (e) {
      Get.back();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      Get.back();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }
}
