import 'package:get/get.dart';
import 'package:picao/core/bindings/initial_binding.dart';
import 'package:picao/modules/home/views/home_page.dart';
import 'package:picao/modules/login/views/login_page.dart';
import 'package:picao/modules/splash/views/splash_page.dart';
import 'package:picao/modules/home/bindings/home_bindigs.dart';
import 'package:picao/modules/team/bindings/team_binding.dart';
import 'package:picao/modules/team/views/manage_team_page.dart';
import 'package:picao/modules/team/views/register_team_page.dart';
import 'package:picao/modules/user/bindings/user_binding.dart';
import 'package:picao/modules/user/views/profile_page.dart';
import 'package:picao/modules/user/views/user_register_page.dart';
import 'package:picao/modules/splash/bindings/splash_bindings.dart';
import 'package:picao/modules/user/views/recover_password_page.dart';

part 'app_routes.dart';

class AppPages {
  static const login = Routes.login;
  static const userRegister = Routes.registerUser;
  static const chagePassword = Routes.chagePassword;
  static const home = Routes.home;
  static const splash = Routes.splash;
  static const profile = Routes.profile;
  static const registerTeam = Routes.registerTeam;
  static const manageTeam = Routes.manageTeam;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => const LoginPage(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.registerUser,
      page: () => const RegisterUserPage(),
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
      bindings: [HomeBinding(), TeamBinding()],
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.profile,
      page: () => const ProfilePage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.registerTeam,
      page: () => const RegisterTeamPage(),
      binding: TeamBinding(),
    ),
    GetPage(
      name: _Paths.manageTeam,
      page: () => const ManageTeamPage(),
      binding: TeamBinding(),
    ),
  ];
}
