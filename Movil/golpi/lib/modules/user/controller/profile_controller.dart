import 'package:get/get.dart';
import 'package:golpi/modules/user/models/user_model.dart';
import 'package:quickalert/quickalert.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/core/models/option_model.dart';
import 'package:golpi/data/service/secure_storage.dart';
import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/modules/widgets/ui_alert_message.dart';
import 'package:golpi/core/exception/models/error_model.dart';
import 'package:golpi/data/repositories/user/user_repository.dart';
import 'package:golpi/core/constants/constant_secure_storage.dart';
import 'package:golpi/modules/user/models/player_profile_register_model.dart';

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
  var listCitiesOption = [OptionModel()].obs;
  var userModel = UserModel().obs;

  var formUserInfo = FormGroup({
    'name': FormControl<String>(validators: []),
    'last_name': FormControl<String>(validators: []),
    'mobile_number': FormControl<String>(validators: []),
    'email': FormControl<String>(validators: []),
    'date_of_birth': FormControl<DateTime>(validators: []),
  });

  var formProfile = FormGroup({
    'nickname': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'stature': FormControl<int>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'weight': FormControl<int>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'position_player':
        FormControl<OptionModel>(validators: [Validators.required]),
    'dominant_foot':
        FormControl<OptionModel>(validators: [Validators.required]),
    'zone': FormControl<OptionModel>(validators: [Validators.required]),
    'city': FormControl<OptionModel>(validators: [Validators.required]),
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
      listPositionPlayerOption.value =
          await userRepository.getAllPositionPlayer();
      listDominantFootOption.value = await userRepository.getAllDominantFoot();
      listZonesOption.value = await userRepository.getAllZones();
      listCitiesOption.value = await userRepository.getAllCities();

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);
      userModel.value = await userRepository.getUserById(int.parse(idUsuer!));

      formUserInfo.value = userModel.toJson();
      formUserInfo.markAsDisabled();

      if (userModel.value.playerProfile != null) {
        formProfile.value = userModel.value.playerProfile?.toJson();

        formProfile.control('position_player').value =
            listPositionPlayerOption.firstWhere((item) =>
                item.id == userModel.value.playerProfile?.positionPlayerId);

        formProfile.control('dominant_foot').value =
            listDominantFootOption.firstWhere((item) =>
                item.id == userModel.value.playerProfile?.positionPlayerId);

        formProfile.control('zone').value = listZonesOption.firstWhere((item) =>
            item.id == userModel.value.playerProfile?.positionPlayerId);

        formProfile.control('city').value = listCitiesOption.firstWhere(
            (item) =>
                item.id == userModel.value.playerProfile?.positionPlayerId);
      }

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

  Future<void> savePlayerProfile() async {
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

      final playerProfileRegisterModel = PlayerProfileRegisterModel(
          nickname: formProfile.control('nickname').value,
          stature: formProfile.control('stature').value,
          weight: formProfile.control('weight').value,
          positionPlayerId: formProfile.control('position_player').value.id,
          dominantFootId: formProfile.control('dominant_foot').value.id,
          zoneId: formProfile.control('zone').value.id,
          cityId: formProfile.control('city').value.id,
          userId: int.parse(idUsuer!));

      if (userModel.value.playerProfile == null) {
        await userRepository.createPlayerProfile(playerProfileRegisterModel);
      } else {
        await userRepository.updatePlayerProfile(playerProfileRegisterModel);
      }

      Get.back();
      UiAlertMessage(Get.context!).success(
          message: 'La información se guardo de manera exitosa',
          barrierDismissible: false,
          actionButtom: () {
            formProfile.reset();
            Get.delete<ProfileController>();
            Get.toNamed(AppPages.home);
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
