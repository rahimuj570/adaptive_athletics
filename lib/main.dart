import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/modules/auth/controllers/auth_controller.dart';
import 'app/modules/calendar/controllers/calendar_controller.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/plan/controllers/plan_controller.dart';
import 'app/modules/settings/controllers/settings_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';
import 'res/colors/app_color.dart';
import 'res/components/api_service.dart';
import 'res/components/notification_service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('📩 Background message received: ${message.data}');
  } catch (e, stackTrace) {
    debugPrint('❌ Error in background message handler: $e');
    debugPrint('Stack trace: $stackTrace');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    final initMsg = await FirebaseMessaging.instance.getInitialMessage();
    if (initMsg != null) {
      NotificationService.initialMessage = initMsg;
    }

    debugPrint('✅ Firebase initialized successfully');
  } catch (e) {
    debugPrint('❌ Error initializing Firebase: $e');
  }

  Get.put(ApiService());
  Get.put(AuthController());
  Get.put(HomeController());
  Get.put(CalendarController());
  Get.put(SettingsController());
  Get.put(PlanController());

  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Dog Application",
          debugShowCheckedModeBanner: false,

          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColor.whiteColor,
            useMaterial3: true,
          ),
        );
      },
    ),
  );
}
