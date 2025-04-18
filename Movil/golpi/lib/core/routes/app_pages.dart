import 'package:get/get.dart';
import 'package:golpi/core/bindings/initial_binding.dart';
import 'package:golpi/modules/home/views/principal_page.dart';
import 'package:golpi/modules/login/views/login_page.dart';
import 'package:golpi/modules/splash/views/splash_page.dart';
import 'package:golpi/modules/home/bindings/home_bindigs.dart';
import 'package:golpi/modules/team/bindings/team_binding.dart';
import 'package:golpi/modules/team/views/manage_team_page.dart';
import 'package:golpi/modules/team/views/register_team_page.dart';
import 'package:golpi/modules/user/bindings/user_binding.dart';
import 'package:golpi/modules/user/views/profile_page.dart';
import 'package:golpi/modules/user/views/user_register_page.dart';
import 'package:golpi/modules/splash/bindings/splash_bindings.dart';
import 'package:golpi/modules/user/views/recover_password_page.dart';

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
      page: () => const PrincipalPage(),
      binding: HomeBinding(),
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
