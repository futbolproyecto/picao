import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:picao/core/constants/constants.dart';
import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/core/exception/models/error_model.dart';
import 'package:picao/core/routes/app_pages.dart';

import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/modules/user/models/user_model.dart';
import 'package:picao/modules/widgets/modal_otp_validation.dart';
import 'package:picao/modules/widgets/ui_alert_message.dart';
import 'package:picao/modules/widgets/ui_buttoms.dart';
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
  var scrollController = ScrollController();

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
      Validators.maxLength(50)
    ]),
    'date_of_birth': FormControl<DateTime>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'terms_and_conditions':
        FormControl<bool>(value: false, validators: [Validators.requiredTrue]),
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
      formUserRegistrer.unfocus();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Confirmando informacion',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      await userRepository
          .sendOtp(formUserRegistrer.control('mobile_number').value);

      Get.back();
      UiAlertMessage(Get.context!).custom(
          child: ModalOtpValidation().validateOtp(
            context: Get.context!,
            formOtpConfirmation: formOtpConfirmation,
            mobileNumber: formUserRegistrer.control('mobile_number').value,
          ),
          actions: [
            UiButtoms(
                    onPressed: () {
                      Get.back();
                      validateOtp();
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

  Future<void> validateOtp() async {
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

        await userRepository.validateOtp(
            formOtpConfirmation.control('otp_number').value,
            formUserRegistrer.control('mobile_number').value);

        Get.back();
        formOtpConfirmation.reset();
        registerUser();
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
          message: 'La informacion se registro de manera exitosa',
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

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void validateFormatPassword() {
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
