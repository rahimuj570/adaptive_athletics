import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../controllers/settings_controller.dart';

class NotificationsSettingsView extends StatelessWidget {
  const NotificationsSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController c = Get.find();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              spacing: 16.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                _settingsItem(
                  title: 'Weather Alerts',
                  subtitle: 'Real-time warnings when training is unsafe',
                  rxValue: c.alert,
                  onChanged: (val) => c.toggleAlert(val),
                ),
                _settingsItem(
                  title: 'Workout Reminders',
                  subtitle: 'Alert me 1 hour before scheduled sessions',
                  rxValue: c.reminder,
                  onChanged: (val) => c.toggleReminder(val),
                ),
                _settingsItem(
                  title: 'Strava Sync',
                  subtitle: 'Notification when activities are imported',
                  rxValue: c.sync,
                  onChanged: (val) => c.toggleSync(val),
                ),
                _settingsItem(
                  title: 'Adaptation Alerts',
                  subtitle: 'When your plan moves due to forecast changes',
                  rxValue: c.adaptation,
                  onChanged: (val) => c.toggleAdaptation(val),
                ),
                SizedBox(height: 32.h),
                CustomButton(onPress: () async {}, title: 'Save'),
                SizedBox(height: 32.h),
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
          margin: EdgeInsets.only(left: 16.w,top: 5.h,bottom: 5.h),
          decoration: BoxDecoration(
            color: AppColor.bgBlackColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(Icons.chevron_left, color: Colors.white, size: 24.w),
        ),
      ),
      title: Column(
        children: [
          Text(
            'Notifications',
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Alerts & Reminders',
            style: TextStyle(
              color: AppColor.text2Color,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  Widget _settingsItem({
    required String title,
    required String subtitle,
    required RxBool rxValue,
    required Function(bool) onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF8E8E93),
                    fontSize: 12.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 16.w),

          Obx(
            () => Transform.scale(
              scale: 0.8,
              child: Switch(
                value: rxValue.value,
                activeThumbColor: const Color(0xFFD0F7D1),
                activeTrackColor: const Color(0xFF13CE66),
                inactiveThumbColor: AppColor.textAreaColor2,
                inactiveTrackColor: const Color(0xFF1E2832),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
