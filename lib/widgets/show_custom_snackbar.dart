import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../res/colors/app_color.dart';

void showCustomSnackBar({
  required String title,
  required String message,
  Color backgroundColor = AppColor.successColor,
  Color textColor = AppColor.textWhiteColor,
  Duration duration = const Duration(milliseconds: 1600),
  bool isSuccess = true,
}) {
  Get.closeCurrentSnackbar();
  Get.rawSnackbar(
    messageText: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isSuccess
              ? [backgroundColor, backgroundColor]
              : [AppColor.errorColor, AppColor.errorColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withAlpha(51),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        children: [
          isSuccess
              ? Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: _iconWidget(const Color(0xFF13CE66), Icons.check),
                )
              : Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: _iconWidget(AppColor.redColor, Icons.error_outline),
                ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  message,
                  style: TextStyle(
                    // color: textColor.withOpacity(0.9),
                    color: textColor.withAlpha(230),
                    fontSize: 14.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
    duration: duration,
    animationDuration: const Duration(milliseconds: 300),
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.all(16.w),
    borderRadius: 12.r,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutCubic,
    reverseAnimationCurve: Curves.easeInCubic,
  );
}

Widget _iconWidget(Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(9.85.r),
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(52.78.r),
      ),
    ),
    child: Container(
      padding: EdgeInsets.all(4.38.r),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.48),
        ),
      ),
      child: Icon(icon, color: Colors.white, size: 16.w),
    ),
  );
}
