import 'package:get/get.dart';
import 'package:picao/core/constants/constant_secure_storage.dart';
import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/core/exception/models/error_model.dart';
import 'package:picao/core/models/option_model.dart';
import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/data/service/secure_storage.dart';
import 'package:picao/modules/user/models/user_model.dart';
import 'package:picao/modules/widgets/ui_alert_message.dart';
import 'package:quickalert/quickalert.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ProfileController extends GetxController {
  final UserRepository userRepository;
  ProfileController({required this.userRepository});

  @override
  void onInit() {
    //getUserById();
    super.onInit();
  }

  @override
  void onReady() {
    getUserById();
    super.onReady();
  }

  var isLoading = false.obs;

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
    'stature': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'weight': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'position_player': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'dominant_foot': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'zone': FormControl<OptionModel>(
        value: OptionModel(id: 1, description: 'Prueba'),
        validators: [Validators.required]),
    'city': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
  });

  Future<void> getUserById() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Confirmando informacion',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      final idUsuer = await SecureStorage().read(ConstantSecureStorage.idUsuer);
      final response = await userRepository.getUserById(int.parse(idUsuer!));

      final userModel = UserModel.fromJson(response);

      formUserInfo.value = userModel.toJson();
      formUserInfo.markAsDisabled();
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
}
