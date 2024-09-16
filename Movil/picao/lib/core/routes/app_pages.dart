import 'package:get/get.dart';
import 'package:picao/modules/user/bindings/user_binding.dart';
import 'package:picao/modules/user/views/login_page.dart';


part 'app_routes.dart';

class AppPages {
  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => LoginPage(),
      binding: UserBindings(),
    ),
    // Otras rutas
  ];
}
