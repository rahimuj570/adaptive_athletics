import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/bindings/register_binding.dart';
import 'package:newproject/app/modules/auth/views/sign_up_view.dart';
import 'package:newproject/app/modules/auth/views/splash_page.dart';
import '../modules/calendar/bindings/calendar_binding.dart';
import '../modules/calendar/views/calendar_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/navigation.dart';
import '../modules/plan/bindings/plan_binding.dart';
import '../modules/plan/views/plan_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.register,
      page: () => const SignUpView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const Navbar(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.splash,
      page: () => const SplashScreen(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.calendar,
      page: () => const CalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.plan,
      page: () => const PlanView(),
      binding: PlanBinding(),
    ),
    GetPage(
      name: _Paths.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
