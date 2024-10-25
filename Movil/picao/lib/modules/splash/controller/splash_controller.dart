import 'package:get/get.dart';
import 'package:picao/core/constants/constant_secure_storage.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/data/service/secure_storage.dart';

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
