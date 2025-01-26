import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:picao/data/service/secure_storage.dart';
import 'package:picao/core/exception/custom_exception.dart';
import 'package:picao/modules/widgets/ui_alert_message.dart';
import 'package:picao/core/exception/models/error_model.dart';
import 'package:picao/modules/login/models/sesion_model.dart';
import 'package:picao/core/constants/constant_secure_storage.dart';
import 'package:picao/data/repositories/login/login_repository.dart';
import 'package:picao/modules/login/models/login_request_model.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository;
  LoginController({required this.loginRepository});

  var formLogin = FormGroup({
    'email_or_mobile_number': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
  });

  var user = Rxn<SesionModel>();
  var obscureText = true.obs;

  Future<void> login() async {
    try {
      formLogin.unfocus();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Validando informacion',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      final response = await loginRepository
          .login(LoginRequestModel.fromJson(formLogin.value));

      final sesionModel = SesionModel.fromJson(response);

      SecureStorage()
          .addNewItem(ConstantSecureStorage.tokenSesion, sesionModel.token);

      SecureStorage().addNewItem(
          ConstantSecureStorage.idUsuer, sesionModel.idUsuer.toString());

      Get.back();
      Get.toNamed(AppPages.home);
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
}
