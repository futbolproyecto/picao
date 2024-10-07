import 'package:get/get.dart';
import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/core/exception/models/error_model.dart';

import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/modules/user/models/user_model.dart';
import 'package:picao/modules/widgets/modal_otp_validation.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UserController extends GetxController {
  final UserRepository userRepository;
  UserController({required this.userRepository});

  @override
  void onInit() {
    validateFormatPassword();
    super.onInit();
  }

  var isLoading = false.obs;
  var user = Rxn<UserRegisterModel>();
  var obscureText = true.obs;
  var showValidationPassword = false.obs;
  var hasEspecialCaracter = false.obs;
  var hasMinCaracter = false.obs;
  var hasCapital = false.obs;
  var hasLower = false.obs;
  var hasNumber = false.obs;

  var formUserRegistrer = FormGroup({
    'name': FormControl<String>(
      validators: [Validators.required, Validators.maxLength(50)],
    ),
    'last_name': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
      Validators.maxLength(50)
    ]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'password_confirmation': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'mobile_number': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'date_of_birth': FormControl<DateTime>(
        validators: [Validators.required, Validators.maxLength(50)]),
  }, validators: [
    const MustMatchValidator('password', 'password_confirmation', false)
  ]);

  var formOtpConfirmation = FormGroup({
    'otp_number': FormControl<String>(
      validators: [Validators.required, Validators.maxLength(50)],
    ),
  });

  Future<void> sendOtp() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Registrando usuario',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      await userRepository
          .registerUser(UserRegisterModel.fromJson(formUserRegistrer.value));

      Get.back();
      ModalOtpValidation().modal(
        context: Get.context!,
        formOtpConfirmation: formOtpConfirmation,
      );
    } on CustomException catch (e) {
      Get.back();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: e.error.error,
      );
    } on Exception catch (_) {
      Get.back();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: ErrorModel().uncontrolledError().error!,
      );
    }
  }

  Future<void> registerUser() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Registrando usuario',
      );

      await userRepository
          .registerUser(UserRegisterModel.fromJson(formUserRegistrer.value));

      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: 'Proceso exitoso',
      );
    } on CustomException catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: e.error.error,
      );
    } on Exception catch (_) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        text: ErrorModel().uncontrolledError().error!,
      );
    }
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void validateFormatPassword() {
    formUserRegistrer.control("password").valueChanges.listen((value) {
      if (value != null) {
        print('>>>>>>>>>');
        print(value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]')));
        showValidationPassword.value = true;
        hasEspecialCaracter.value =
            value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
        hasMinCaracter.value = (value.length >= 6);
        hasCapital.value = value.contains(RegExp(r'[A-Z]'));
        hasLower.value = value.contains(RegExp(r'[a-z]'));
        hasNumber.value = value.contains(RegExp(r'[0-9]'));
      }
    });
  }
}
