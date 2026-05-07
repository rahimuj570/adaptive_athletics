import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/res/assets/image_assets.dart';

import '../../../../res/colors/app_color.dart';
import '../models/activity.dart';
import '../views/strength_training_view.dart';

class StrengthActivityCard extends StatelessWidget {
  final Activity activity;

  const StrengthActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.bgRedColor,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _DiagonalLinesPainter())),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(14.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.title,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            activity.cardDescription ?? '',
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 14.sp,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 14),
                    Container(
                      width: 40.w,
                      height: 40.h,
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(ImageAssets.muscle),
                    ),
                  ],
                ),
              ),

              Container(
                color: AppColor.textAreaColor5,
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(StrengthTrainingView());
                  },
                  child: Row(
                    spacing: 18.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Click here to see the details',
                        style: TextStyle(
                          color: AppColor.textRedColor,
                          fontSize: 10.w,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColor.textRedColor,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiagonalLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.whiteColor.withAlpha(13)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    const spacing = 40.0;
    for (double x = -size.height; x < size.width + size.height; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
