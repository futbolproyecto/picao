import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import 'package:quickalert/quickalert.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:picao/core/models/option_model.dart';
import 'package:picao/data/service/secure_storage.dart';
import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/modules/widgets/ui_alert_message.dart';
import 'package:picao/core/exception/models/error_model.dart';
import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/core/constants/constant_secure_storage.dart';
import 'package:picao/modules/user/models/player_profile_register_model.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository;
  ProfileController({required this.userRepository});

  @override
  void onReady() async {
    loadData();
    super.onReady();
  }

  var isLoading = false.obs;
  var listZonesOption = [OptionModel()].obs;
  var listPositionPlayerOption = [OptionModel()].obs;
  var listDominantFootOption = [OptionModel()].obs;
  var valueZoneSelected = ValueNotifier<int?>(null).obs;
  var valuePositionPlayerSelected = ValueNotifier<int?>(null).obs;
  var valueDominantFootSelected = ValueNotifier<int?>(null).obs;
  var valueCitySelected = ValueNotifier<int?>(null).obs;

  var formUserInfo = FormGroup({
    'name': FormControl<String>(validators: []),
    'lastName': FormControl<String>(validators: []),
    'mobileNumber': FormControl<String>(validators: []),
    'email': FormControl<String>(validators: []),
    'date_of_birth': FormControl<DateTime>(validators: []),
  });

  var formProfile = FormGroup({
    'nickname': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'stature': FormControl<double>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'weight': FormControl<int>(
        validators: [Validators.required, Validators.maxLength(50)]),
  });

  Future<void> loadData() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Consultando perfil',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);
      final userModel = await userRepository.getUserById(int.parse(idUsuer!));

      formUserInfo.value = userModel.toJson();
      formUserInfo.markAsDisabled();

      listZonesOption.value = await userRepository.getAllZones();
      listPositionPlayerOption.value =
          await userRepository.getAllPositionPlayer();
      listDominantFootOption.value = await userRepository.getAllDominantFoot();
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

  Future<void> registerPlayerProfile() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Registrando perfil',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);

      await userRepository.createPlayerProfile(PlayerProfileRegisterModel(
          nickname: formProfile.control('nickname').value,
          stature: formProfile.control('stature').value,
          weight: formProfile.control('weight').value,
          positionPlayerId: valuePositionPlayerSelected.value.value!,
          dominantFootId: valueDominantFootSelected.value.value!,
          zoneId: valueZoneSelected.value.value!,
          cityId: valueCitySelected.value.value!,
          userId: int.parse(idUsuer!)));

      Get.back();
      UiAlertMessage(Get.context!).success(
          message: 'La informacion se registro de manera exitosa',
          barrierDismissible: false,
          actionButtom: () {
            formProfile.reset();
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
}
