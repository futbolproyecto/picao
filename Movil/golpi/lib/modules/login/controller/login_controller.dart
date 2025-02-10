import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/data/service/secure_storage.dart';
import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/modules/widgets/ui_alert_message.dart';
import 'package:golpi/core/exception/models/error_model.dart';
import 'package:golpi/modules/login/models/sesion_model.dart';
import 'package:golpi/core/constants/constant_secure_storage.dart';
import 'package:golpi/data/repositories/login/login_repository.dart';
import 'package:golpi/modules/login/models/login_request_model.dart';

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
      Get.deleteAll();
      Get.toNamed(AppPages.home);

      formLogin.reset();
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
