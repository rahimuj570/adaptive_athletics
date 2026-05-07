import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../controllers/settings_controller.dart';

class UnitView extends StatelessWidget {
  const UnitView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.find();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32.h),
                _settingsChips(
                  title: 'Marathon',
                  subtitle: 'System-wide Metric',
                  p1: '°C',
                  p2: '°Ft',
                  icon: ImageAssets.miniTemp,
                  color: const Color(0xFF99E500),
                  isFirstActive: controller.isCelsius,
                  onToggle: (val) => controller.isCelsius.value = val,
                ),
                SizedBox(height: 12.h),
                _settingsChips(
                  title: 'Distance Units',
                  subtitle: 'GPS & Tracking',
                  p1: 'KM',
                  p2: 'MI',
                  icon: ImageAssets.meter,
                  color: AppColor.greenColor1,
                  isFirstActive: controller.isUnits,
                  onToggle: (val) => controller.isUnits.value = val,
                ),
                SizedBox(height: 12.h),
                _settingsChips(
                  title: 'Time Format',
                  subtitle: 'Event Scheduling',
                  p1: '24H',
                  p2: '12H',
                  icon: ImageAssets.meter,
                  color: const Color(0xFF51A2FF),
                  isFirstActive: controller.isClock,
                  onToggle: (val) => controller.isClock.value = val,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      leadingWidth: 60.w,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: EdgeInsets.only(left: 16.w, top: 5.h, bottom: 5.h),
          decoration: BoxDecoration(
            color: AppColor.bgBlackColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(Icons.chevron_left, color: Colors.white, size: 24.w),
        ),
      ),
      title: Text(
        'Unit Configurations',
        style: TextStyle(
          color: AppColor.whiteColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _settingsChips({
    required String title,
    required String subtitle,
    required String p1,
    required String p2,
    required String icon,
    required Color color,
    required RxBool isFirstActive,
    required Function(bool) onToggle,
  }) {
    return Container(
      width: double.infinity,
      height: 63.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: ShapeDecoration(
        color: AppColor.bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: ShapeDecoration(
                  color: color.withAlpha(38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    width: 20.r,
                    height: 20.r,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                width: 130.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppColor.text2Color,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Obx(
            () => Container(
              height: 37.h,
              padding: EdgeInsets.all(4.r),
              decoration: ShapeDecoration(
                color: const Color(0xFF020618),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF1D293D)),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _toggleOption(
                    label: p1,
                    isActive: isFirstActive.value,
                    activeColor: color,
                    onTap: () => onToggle(true),
                  ),
                  _toggleOption(
                    label: p2,
                    isActive: !isFirstActive.value,
                    activeColor: color,
                    onTap: () => onToggle(false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toggleOption({
    required String label,
    required bool isActive,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 27.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: ShapeDecoration(
          color: isActive ? activeColor : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          shadows: isActive
              ? [
                  BoxShadow(
                    color: activeColor.withAlpha(54),
                    blurRadius: 15,
                    offset: const Offset(0, 10),
                    spreadRadius: -3,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isActive
                  ? const Color(0xFF020618)
                  : const Color(0xFF62748E),
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
