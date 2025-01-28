import 'package:get/get.dart';
import 'package:golpi/core/constants/constant_secure_storage.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/data/service/secure_storage.dart';

class SplashController extends GetxController {
  SplashController();

  @override
  void onInit() {
    validateToken();
    super.onInit();
  }

  void validateToken() async {
    final token = await SecureStorage().read(ConstantSecureStorage.tokenSesion);
    if (token != null) {
      Get.offNamed(AppPages.home);
    } else {
      Get.offNamed(AppPages.login);
    }
  }
}
