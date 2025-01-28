part of 'app_pages.dart';

abstract class Routes {
  static const login = _Paths.login;
  static const registerUser = _Paths.registerUser;
  static const chagePassword = _Paths.chagePassword;
  static const home = _Paths.home;
  static const splash = _Paths.splash;
  static const profile = _Paths.profile;
  static const registerTeam = _Paths.registerTeam;
  static const manageTeam = _Paths.manageTeam;
}

abstract class _Paths {
  static const login = '/login';
  static const registerUser = '/register-user';
  static const chagePassword = '/chage-password';
  static const home = '/home';
  static const splash = '/splash';
  static const profile = '/profile';
  static const registerTeam = '/register-team';
  static const manageTeam = '/manage-team';
}
