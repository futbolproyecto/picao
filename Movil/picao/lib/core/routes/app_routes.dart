part of 'app_pages.dart';

abstract class Routes {
  static const login = _Paths.login;
  static const userRegister = _Paths.userRegister;
  static const chagePassword = _Paths.chagePassword;
  static const home = _Paths.home;
  static const splash = _Paths.splash;
}

abstract class _Paths {
  static const login = '/login';
  static const userRegister = '/user-register';
  static const chagePassword = '/chage-password';
  static const home = '/home';
  static const splash = '/splash';
}
