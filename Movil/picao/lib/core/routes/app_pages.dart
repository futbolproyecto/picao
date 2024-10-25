import 'package:get/get.dart';
import 'package:picao/core/bindings/initial_binding.dart';
import 'package:picao/modules/home/views/home_page.dart';
import 'package:picao/modules/login/views/login_page.dart';
import 'package:picao/modules/splash/views/splash_page.dart';
import 'package:picao/modules/home/bindings/home_bindigs.dart';
import 'package:picao/modules/user/bindings/user_binding.dart';
import 'package:picao/modules/user/views/user_register_page.dart';
import 'package:picao/modules/splash/bindings/splash_bindings.dart';
import 'package:picao/modules/user/views/recover_password_page.dart';

part 'app_routes.dart';

class AppPages {
  static const login = Routes.login;
  static const userRegister = Routes.userRegister;
  static const chagePassword = Routes.chagePassword;
  static const home = Routes.home;
  static const splash = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => const LoginPage(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.userRegister,
      page: () => const UserRegisterPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.chagePassword,
      page: () => const RecoverPasswordPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
  ];
}
