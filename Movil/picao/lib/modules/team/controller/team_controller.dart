import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:picao/core/constants/constants.dart';
import 'package:picao/core/models/option_model.dart';
import 'package:picao/data/service/secure_storage.dart';
import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/core/exception/models/error_model.dart';
import 'package:picao/data/repositories/team/team_repository.dart';
import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/modules/team/models/team_register_model.dart';
import 'package:picao/modules/team/widgets/modal_search_user_phone_page.dart';
import 'package:picao/modules/widgets/ui_alert_message.dart';
import 'package:picao/modules/widgets/ui_buttoms.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:picao/core/constants/constant_secure_storage.dart';

class TeamController extends GetxController {
  final UserRepository userRepository;
  final TeamRepository teamRepository;
  TeamController({required this.userRepository, required this.teamRepository});

  @override
  void onReady() async {
    loadData();
    super.onReady();
  }

  var listZonesOption = [OptionModel()].obs;
  var valueZoneSelected = ValueNotifier<int?>(null).obs;
  var valueCitySelected = ValueNotifier<int?>(null).obs;

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
  });

  Future<void> loadData() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Consultando informacion',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);
      final userModel = await userRepository.getUserById(int.parse(idUsuer!));

      formTeamRegistrer.control('representative_name').value =
          '${userModel.name} ${userModel.lastName}';
      formTeamRegistrer.control('contact_number').value =
          userModel.mobileNumber;
      formTeamRegistrer.control('representative_name').markAsDisabled();
      formTeamRegistrer.control('contact_number').markAsDisabled();
      listZonesOption.value = await userRepository.getAllZones();
      Get.back();
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
        zoneId: valueZoneSelected.value.value!,
        cityId: valueCitySelected.value.value!,
        userId: int.parse(idUsuer!),
      ));
      Get.back();
      UiAlertMessage(Get.context!).success(
          message: 'La informacion se registro de manera exitosa',
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
//1234567890
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
                    title: 'Validar')
                .textButtom(Constants.primaryColor),
            UiButtoms(
                    onPressed: () {
                      Get.back();
                    },
                    title: 'Cerrar')
                .textButtom(Colors.black),
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
                      //await getUserByMobileNumber();
                    },
                    title: 'Agregar')
                .textButtom(Constants.primaryColor),
            UiButtoms(
                    onPressed: () {
                      Get.back();
                    },
                    title: 'Cancelar')
                .textButtom(Colors.black),
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
}
