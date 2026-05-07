import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../res/colors/app_color.dart';
import '../models/activity.dart';

class RegularActivityCard extends StatelessWidget {
  final Activity activity;

  const RegularActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.bgBlueColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.month,
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 13.sp,
                        ),
                      ),
                      Text(
                        activity.day.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.h),
                Container(width: 1.5.w, height: 60.h, color: AppColor.textAreaColor2),
                SizedBox(width: 16.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Text(
                        activity.title,
                        style: TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        activity.subtitle,
                        style: TextStyle(
                          color:AppColor.text2Color,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(spacing: 8.w,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: ShapeDecoration(
                        color: AppColor.textAreaColor2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Text(
                        activity.time,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColor.text2Color,
                          fontSize: 8,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Icon(
                      activity.isSunny
                          ? Icons.wb_sunny_outlined
                          : Icons.cloud_outlined,
                      color: activity.isSunny
                          ? AppColor.yellowColor
                          : AppColor.greenColor2,
                      size: 22.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(color: AppColor.textAreaColor2, height: 1.h),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric( vertical: 8.h),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Click here to see the details',
                      style: TextStyle(
                        color: AppColor.defaultColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color:AppColor.defaultColor,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
