import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../res/colors/app_color.dart';

class PlanHistoryView extends StatelessWidget {
  const PlanHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                _settingsItem(),
                SizedBox(height: 20.h),
                _settingsItem(),
                SizedBox(height: 20.h),
                _settingsItem(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColor.hintTextColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
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
      title: Column(
        spacing: 5.h,
        children: [
          Text(
            'Plan History',
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 114.w,
            child: Text(
              'Past Rides & Runs',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.text2Color,
                fontSize: 14.sp,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: 5.h),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _settingsItem() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/img_1.png'),
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColor.bgColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tempo Intervals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Cycling',
                    style: TextStyle(
                      color: AppColor.text2Color,
                      fontSize: 12.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      width: 1,
                      color: AppColor.textAreaColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    _buildMetricItem('Distance', '24.2 km'),
                    _buildMetricItem('Time', '60m'),
                    _buildMetricItem('Avg Pace', '90 km/h'),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12.r,
                        color: AppColor.text2Color,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '2026-02-05',
                        style: TextStyle(
                          color: AppColor.text2Color,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        size: 12.r,
                        color: AppColor.text2Color,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '11°C',
                        style: TextStyle(
                          color: AppColor.text2Color,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
