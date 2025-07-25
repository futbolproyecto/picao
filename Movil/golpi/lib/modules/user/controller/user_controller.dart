import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/core/models/country_model.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/modules/widgets/ui_alert_message.dart';
import 'package:golpi/core/exception/models/error_model.dart';
import 'package:golpi/modules/widgets/modal_otp_validation.dart';
import 'package:golpi/data/repositories/user/user_repository.dart';
import 'package:golpi/modules/user/models/user_register_model.dart';
import 'package:golpi/modules/user/models/change_password_model.dart';

class UserController extends GetxController {
  final UserRepository userRepository;
  UserController({required this.userRepository});

  @override
  void onInit() {
    validateFormatPasswordUser();
    validateFormatPasswordRecoverPassword();
    getAllCountry();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
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
  var scrollController = ScrollController();
  var isValidateEmail = true.obs;
  var isEmailValidated = false.obs;
  var termsAndConditionsError = Rx<String?>(null);
  var listContries = [CountryModel()].obs;

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
    'mobile_number': FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(10),
      Validators.maxLength(50),
      Validators.number(),
    ]),
    'date_of_birth': FormControl<DateTime>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'terms_and_conditions':
        FormControl<bool>(value: false, validators: [Validators.requiredTrue]),
    'cell_prefix': FormControl<String>(validators: [Validators.required]),
  }, validators: [
    const MustMatchValidator('password', 'password_confirmation', false)
  ]);

  var formOtpConfirmation = FormGroup({
    'otp_number': FormControl<String>(
      validators: [Validators.required, Validators.maxLength(50)],
    ),
  });

  var formEmailRecoveryPassword = FormGroup({
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
      ],
    ),
  });

  var formChangePassword = FormGroup({
    'password': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'password_confirmation': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
  }, validators: [
    const MustMatchValidator('password', 'password_confirmation', false)
  ]);

  Future<void> sendOtpMobileNumber() async {
    try {
      formUserRegistrer.unfocus();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Confirmando informacion',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      await userRepository.sendOtpMobileNumber(
          mobileNumber:
              '${formUserRegistrer.control('cell_prefix').value}${formUserRegistrer.control('mobile_number').value}');

      Get.back();
      UiAlertMessage(Get.context!).custom(
          child: ModalOtpValidation().validateOtp(
            context: Get.context!,
            formOtpConfirmation: formOtpConfirmation,
            message: S().menesajeConfirmarOtp(
                formUserRegistrer.control('mobile_number').value),
          ),
          actions: [
            UiButtoms(
                    onPressed: () async {
                      await validateOtp();
                    },
                    title: S().validar)
                .textButtom(
                    color: Theme.of(Get.context!).colorScheme.primaryContainer),
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

  Future<void> sendOtpEmail() async {
    try {
      formEmailRecoveryPassword.unfocus();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Confirmando informacion',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      await userRepository
          .sendOtpEmail(formEmailRecoveryPassword.control('email').value);

      Get.back();
      UiAlertMessage(Get.context!).custom(
          child: ModalOtpValidation().validateOtpEmail(
            context: Get.context!,
            formOtpEmailConfirmation: formOtpConfirmation,
            email: formEmailRecoveryPassword.control('email').value,
          ),
          actions: [
            UiButtoms(
                    onPressed: () async {
                      Get.back();
                      await validateOtpEmail();
                    },
                    title: S().validar)
                .textButtom(
                    color: Theme.of(Get.context!).colorScheme.primaryContainer),
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

  Future<void> validateOtp() async {
    try {
      if (formOtpConfirmation.valid) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.loading,
          title: 'Cargando...',
          text: 'Validando otp',
          barrierDismissible: false,
          disableBackBtn: true,
        );

        await userRepository.validateOtp(
            formOtpConfirmation.control('otp_number').value,
            formUserRegistrer.control('mobile_number').value);

        Get.back();
        formOtpConfirmation.reset();
        registerUser();
      } else {
        formOtpConfirmation.markAllAsTouched();
      }
    } on CustomException catch (e) {
      Get.back();
      formOtpConfirmation.reset();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      Get.back();
      formOtpConfirmation.reset();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> validateOtpEmail() async {
    try {
      formOtpConfirmation.markAllAsTouched();
      if (formOtpConfirmation.valid) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.loading,
          title: 'Cargando...',
          text: 'Validando otp',
          barrierDismissible: false,
          disableBackBtn: true,
        );

        await userRepository.validateOtpEmail(
            formOtpConfirmation.control('otp_number').value,
            formEmailRecoveryPassword.control('email').value);

        isEmailValidated.value = true;
        isValidateEmail.value = false;

        Get.back();
      }
    } on CustomException catch (e) {
      Get.back();
      formOtpConfirmation.reset();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      Get.back();
      formOtpConfirmation.reset();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> registerUser() async {
    try {
      Get.back();
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
      UiAlertMessage(Get.context!).success(
          message: S().exitoRegistrar,
          barrierDismissible: false,
          actionButtom: () {
            formUserRegistrer.reset();
            formOtpConfirmation.reset();
            Get.offNamed(AppPages.login);
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

  Future<void> changePassword() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Cambiando contraseña',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      ChangePasswordModel changePasswordModel = ChangePasswordModel(
          email: formEmailRecoveryPassword.control('email').value,
          password: formChangePassword.control('password').value,
          otp: formOtpConfirmation.control('otp_number').value);

      await userRepository.changePassword(changePasswordModel);

      Get.back();
      UiAlertMessage(Get.context!).success(
          message: S().exitoActualizarClave,
          barrierDismissible: false,
          actionButtom: () {
            formEmailRecoveryPassword.reset();
            formChangePassword.reset();
            formOtpConfirmation.reset();
            Get.offNamed(AppPages.login);
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

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void validateFormatPasswordUser() {
    formUserRegistrer.control("password").valueChanges.listen((value) {
      if (value != null) {
        showValidationPassword.value = true;
        _scrollToBottom();
        hasEspecialCaracter.value =
            value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
        hasMinCaracter.value = (value.length >= 6);
        hasCapital.value = value.contains(RegExp(r'[A-Z]'));
        hasLower.value = value.contains(RegExp(r'[a-z]'));
        hasNumber.value = value.contains(RegExp(r'[0-9]'));
      } else {
        showValidationPassword.value = false;
      }
    });
  }

  void validateFormatPasswordRecoverPassword() {
    formChangePassword.control("password").valueChanges.listen((value) {
      if (value != null) {
        showValidationPassword.value = true;
        _scrollToBottom();
        hasEspecialCaracter.value =
            value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
        hasMinCaracter.value = (value.length >= 6);
        hasCapital.value = value.contains(RegExp(r'[A-Z]'));
        hasLower.value = value.contains(RegExp(r'[a-z]'));
        hasNumber.value = value.contains(RegExp(r'[0-9]'));
      } else {
        showValidationPassword.value = false;
      }
    });
  }

  Future<void> getAllCountry() async {
    try {
      isLoading.value = true;
      listContries.value = await userRepository.getAllCountry();

      listContries.sort((a, b) =>
          int.parse(a.cellPrefix!).compareTo(int.parse(b.cellPrefix!)));

      final defaultCountry = listContries.firstWhere(
        (c) => c.isoCode == 'CO',
        orElse: () => listContries.first,
      );

      formUserRegistrer.control('cell_prefix').value =
          defaultCountry.cellPrefix;
      isLoading.value = false;
    } on CustomException catch (e) {
      isLoading.value = false;
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      isLoading.value = false;
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  void _scrollToBottom() {
    if (showValidationPassword.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      });
    }
  }
}
