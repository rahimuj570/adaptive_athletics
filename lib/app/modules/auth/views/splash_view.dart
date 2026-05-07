import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/services/auth_prefs_service.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import 'auth_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.splash),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 310.w,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Train ',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 30.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                    TextSpan(
                      text: 'Smarter, ',
                      style: TextStyle(
                        color: AppColor.linearColor,
                        fontSize: 30.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                    TextSpan(
                      text: 'Not Harder',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 30.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: 310.w,
              child: Text(
                'Personalized workout plans that adapt to your weather, your schedule, and your goals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.text2Color,
                  fontSize: 14.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),
            ),
            SizedBox(height: 28.h),
            CustomButton(
              width: 343,
              onPress: () async {
                Get.to(() => AuthView());
              },
              title: 'Get Started ',
              trailing: true,
              trailingIcon: ImageAssets.play,
              trailingIconHeight: 17.h,
              trailingIconWeight: 16.w,
              linearGradient: true,
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
