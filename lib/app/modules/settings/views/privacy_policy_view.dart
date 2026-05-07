import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:newproject/app/modules/settings/controllers/privacy_controller.dart';

import '../../../../res/colors/app_color.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    PrivacyController privacyController = Get.put(PrivacyController());
    privacyController.fetchPrivacy();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32.h),
                  if (privacyController.isLoading.value)
                    Center(child: CircularProgressIndicator()),
                  SizedBox(
                    width: 360.w,
                    child: Text(
                      privacyController.privacyContent.value,
                      style: TextStyle(
                        color: AppColor.text2Color,
                        fontSize: 12.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),
                  // _header(
                  //   "1. Data Collection",
                  //   'We collect fitness data imported from your Strava account (activities, heart rate, distance) and your location data to provide accurate weather-based training adaptations.',
                  // ),
                  // SizedBox(height: 28.h),
                  // _header(
                  //   '2. Use of Information',
                  //   'Your data is used solely to generate personalized training plans and adapt them based on local weather conditions. We do not sell your personal training history to third parties.',
                  // ),
                  // SizedBox(height: 28.h),
                  // _header(
                  //   '3. API Connections',
                  //   'By connecting Strava, you authorize us to access your public profile and activities. You can revoke this access at any time via the Profile settings or your Strava dashboard.',
                  // ),
                  // SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(String title, String subtitle) {
    return Column(
      children: [
        SizedBox(
          width: 360.w,
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 14.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: 360.w,
          child: Text(
            subtitle,
            style: TextStyle(
              color: AppColor.text2Color,
              fontSize: 12.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ),
      ],
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
        'Privacy Policy',
        style: TextStyle(
          color: AppColor.whiteColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }
}
