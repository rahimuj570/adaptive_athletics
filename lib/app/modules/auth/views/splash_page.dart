import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/services/auth_prefs_service.dart';
import 'package:newproject/app/modules/auth/views/splash_view.dart';
import 'package:newproject/app/modules/home/views/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateTogetSTarted();
  }

  void navigateTogetSTarted() async {
    // Navigate after 2 seconds
    await Future.delayed(const Duration(seconds: 3), () async {
      // if (await AuthPrefsService().getToken() == null ||
      //     await AuthPrefsService().getRememberMe() == false) {
      Get.off(
        () => const SplashView(),
      ); // Replace HomePage with your target page
      // } else {
      //   Get.off(() => const Navbar());
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: Center(
        child: SvgPicture.asset(
          'assets/icon/splash.svg',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
