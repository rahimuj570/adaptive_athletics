part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const register = _Paths.register;
  static const home = _Paths.home;
  static const add = _Paths.add;
  static const splash = _Paths.splash;
  static const settings = _Paths.settings;
  static const calendar = _Paths.calendar;
  static const plan = _Paths.plan;
  static const chat = _Paths.chat;
}

abstract class _Paths {
  _Paths._();
  static const register = '/register';
  static const home = '/home';
  static const splash = '/splash';
  static const add = '/add';
  static const settings = '/settings';
  static const calendar = '/calendar';
  static const plan = '/plan';
  static const chat = '/chat';
}
