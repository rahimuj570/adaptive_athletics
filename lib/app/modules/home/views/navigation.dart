import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../calendar/views/calendar_view.dart';
import '../../plan/views/plan_view.dart';
import '../../settings/views/settings_view.dart';
import '../controllers/home_controller.dart';
import 'home_view.dart';

class Navbar extends GetView<HomeController> {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    debugPrint("Your role is ${authController.selectedRole.value}");

    final pages = [
      const HomeView(),
      CalendarView(),
      PlanView(),
      SettingsView(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Obx(() => pages[controller.currentIndex.value]),
          Positioned(
            bottom: 15.h,
            left: 15.w,
            right: 15.w,
            child: Obx(
              () => Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: AppColor.whiteColor.withValues(alpha: 0.25),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.50,
                      color: AppColor.whiteColor.withValues(alpha: 0.50),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x19515151),
                      blurRadius: 8,
                      offset: Offset(0, -5),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  child: GNav(
                    backgroundColor: Colors.transparent,
                    color: AppColor.textColor,
                    activeColor: AppColor.whiteColor,
                    gap: 0,
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 14.h,
                    ),
                    tabMargin: EdgeInsets.symmetric(horizontal: 2.w),
                    selectedIndex: controller.currentIndex.value,
                    onTabChange: (index) =>
                        controller.currentIndex.value = index,
                    tabs: [
                      _buildCustomTab(index: 0, iconPath: ImageAssets.home),
                      _buildCustomTab(index: 1, iconPath: ImageAssets.calender),
                      _buildCustomTab(index: 2, iconPath: ImageAssets.thunder),
                      _buildCustomTab(index: 3, iconPath: ImageAssets.settings),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GButton _buildCustomTab({required int index, required String iconPath}) {
    return GButton(
      icon: Icons.home,

      iconActiveColor: AppColor.whiteColor,
      backgroundGradient: const LinearGradient(
        begin: Alignment(0.50, 0.00),
        end: Alignment(0.50, 1.00),
        colors: [AppColor.buttonColor1, AppColor.defaultColor],
      ),
      borderRadius: BorderRadius.circular(100),
      leading: Obx(() {
        final bool isActive = controller.currentIndex.value == index;
        return SvgPicture.asset(
          iconPath,
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            isActive ? AppColor.whiteColor : AppColor.textColor,
            BlendMode.srcIn,
          ),
        );
      }),
    );
  }
}
