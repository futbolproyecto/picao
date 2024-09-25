import 'package:get/get.dart';
import 'package:picao/core/bindings/initial_binding.dart';
import 'package:picao/modules/login/views/login_page.dart';
import 'package:picao/modules/user/bindigs/user_binding.dart';
import 'package:picao/modules/user/views/user_register_pages.dart';

part 'app_routes.dart';

class AppPages {
  static const login = Routes.login;
  static const userRegister = Routes.userRegister;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => LoginPage(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.userRegister,
      page: () => UserRegisterPage(),
      binding: UserBinding(),
    ),
  ];
}
