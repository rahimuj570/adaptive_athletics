import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/controllers/user_controller.dart';
import 'package:newproject/app/modules/auth/models/login_response_model.dart';
import 'package:newproject/app/modules/auth/services/auth_prefs_service.dart';
import 'package:newproject/app/modules/auth/views/splash_view.dart';
import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import 'edit_profile_view.dart';
import 'event_planning_view.dart';
import 'membership_view.dart';
import 'notifications_settings_view.dart';
import 'plan_history_view.dart';
import 'privacy_policy_view.dart';
import 'terms_and_condition_view.dart';
import 'unit_view.dart';
import 'weather_preference.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    userController.getUser();
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 110.w,
                      height: 110.h,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/image/img.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: OvalBorder(
                          side: BorderSide(
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: AppColor.textAreaColor,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => Get.to(EditProfileView()),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: ShapeDecoration(
                            color: AppColor.defaultColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.50,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: AppColor.whiteColor,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x1E000000),
                                blurRadius: 4.50,
                                offset: Offset(2, 6),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Icon(Icons.camera),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 200.w,
                  child: Obx(
                    () => Text(
                      userController.user.value!.firstName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 24.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: 200.w,
                  child: Obx(
                    () => Text(
                      userController.user.value!.address1 ?? 'Address : N/A',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.hintTextColor,
                        fontSize: 14.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 38.h),
                _settingsHeader('Integrations  & Subscription'),
                SizedBox(height: 16.h),
                _stravaApi(),
                SizedBox(height: 12.h),
                _membership(),
                SizedBox(height: 12.h),
                _settingsHeader('History'),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () => Get.to(PlanHistoryView()),
                  child: _settingsChips(
                    'Plan History',
                    ImageAssets.thunder,
                    AppColor.linearColor,
                    null,
                  ),
                ),
                SizedBox(height: 14.h),
                _settingsHeader('General Settings'),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () => Get.to(WeatherPreference()),
                  child: _settingsChips(
                    'Weather Preference',
                    ImageAssets.wind,
                    AppColor.linearColor,
                    'Custom',
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(EventPlanningView()),
                  child: _settingsChips(
                    'Event Planning',
                    ImageAssets.calender,
                    const Color(0xFF51A2FF),
                    null,
                  ),
                ),
                // InkWell(
                //   onTap: () => Get.to(TimeBlocksView()),
                //   child: _settingsChips(
                //     'Time Blocks',
                //     ImageAssets.blocks,
                //     const Color(0xFF336B8A),
                //     null,
                //   ),
                // ),
                InkWell(
                  onTap: () => Get.to(NotificationsSettingsView()),
                  child: _settingsChips(
                    'Notifications',
                    ImageAssets.settings,
                    const Color(0xFF90A1B9),
                    'Daily',
                  ),
                ),
                SizedBox(height: 12.h),
                _settingsHeader('Display Preferences'),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () => Get.to(UnitView()),
                  child: _settingsChips(
                    'Unit Configurations',
                    ImageAssets.settings,
                    const Color(0xFF90A1B9),
                    null,
                  ),
                ),
                SizedBox(height: 12.h),
                _settingsHeader('Legal & Support'),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () => Get.to(PrivacyPolicyView()),
                  child: _settingsChips(
                    'Privacy Policy',
                    ImageAssets.settings,
                    AppColor.greenColor1,
                    'View',
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(TermsAndConditionView()),
                  child: _settingsChips(
                    'T&C',
                    ImageAssets.tc,
                    const Color(0xFF51A2FF),
                    'View',
                  ),
                ),
                SizedBox(height: 12.h),
                _settingsHeader('Log Out'),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: _buildLogOut(context),
                      ),
                      barrierDismissible: false,
                      barrierColor: Colors.black.withValues(alpha: 0.8),
                    );
                  },
                  child: _settingsChips(
                    'Log Out',
                    ImageAssets.logout,
                    const Color(0xFF904E4E),
                    null,
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Disconnect',
                    style: TextStyle(
                      color: const Color(0xFFB40009),
                      fontSize: 12.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                InkWell(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: _buildDisconnect(context),
                      ),
                      barrierDismissible: false,
                      barrierColor: Colors.black.withValues(alpha: 0.8),
                    );
                  },
                  child: _settingsChips(
                    'Disconnect Profile',
                    ImageAssets.disconnect,
                    const Color(0xFFFF2056),
                    null,
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingsHeader(String title) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          color: AppColor.text2Color,
          fontSize: 12.sp,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _stravaApi() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: ShapeDecoration(
        color: AppColor.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                padding: EdgeInsets.all(10.sp),
                decoration: ShapeDecoration(
                  color: const Color(0x33FF6800),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                child: SvgPicture.asset(
                  ImageAssets.energy,
                  width: 20.r,
                  height: 20.r,
                  colorFilter: ColorFilter.mode(
                    const Color(0xFFFF6900),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Strava API',
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 16.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Connected',
                    style: TextStyle(
                      color: const Color(0xFF888888),
                      fontSize: 12.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),

          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.r, color: AppColor.textAreaColor2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.sync, color: AppColor.whiteColor, size: 14.r),
                  SizedBox(width: 8.w),
                  Text(
                    'Sync Now',
                    style: TextStyle(
                      color: AppColor.whiteColor,
                      fontSize: 12.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _membership() {
    return InkWell(
      onTap: () => Get.to(MembershipView()),
      child: Container(
        width: double.infinity,
        height: 63.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: const Color(0xFF080A19),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.60, color: const Color(0xFF1E1E1E)),
            borderRadius: BorderRadius.circular(6.r),
          ),
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
                    color: const Color(0xFF1E2832),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.r,
                        height: 20.r,
                        child: SvgPicture.asset(
                          ImageAssets.membership,
                          colorFilter: ColorFilter.mode(
                            const Color(0xFFFF6900),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Membership',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Your membership status',
                      style: TextStyle(
                        color: const Color(0xFF757575),
                        fontSize: 12.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColor.textColor,
              size: 16.r,
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsChips(String title, String icon, Color color, String? view) {
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
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: SvgPicture.asset(
                        icon,
                        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              SizedBox(
                width: 250.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 14.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (view != null)
                      Text(
                        view,
                        style: TextStyle(
                          color: const Color(0xFF757575),
                          fontSize: 12.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColor.textColor,
            size: 16.r,
          ),
        ],
      ),
    );
  }

  Widget _buildLogOut(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: AppColor.textAreaColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Color(0xFF904E4E).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Color(0xFF904E4E).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: SvgPicture.asset(
                ImageAssets.logout,
                width: 24.r,
                height: 24.r,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          Text(
            'Confirm Logout',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Are you sure you want to log out of your session? You will need to sign in again to access your goals.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.text2Color,
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
          SizedBox(height: 32.h),

          Row(
            children: [
              Expanded(
                child: _buildDialogButton(
                  label: 'Cancel',
                  onTap: () => Get.back(),
                  bgColor: AppColor.whiteColor,
                  textColor: AppColor.blackColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildDialogButton(
                  label: 'Logout',
                  onTap: () {
                    AuthPrefsService().removeToken();
                    Get.offAll(SplashView());
                  },
                  bgColor: const Color(0xFFF24646),
                  textColor: AppColor.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisconnect(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: AppColor.textAreaColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Color(0xFFFF2056).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Color(0xFFFF2056).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: SvgPicture.asset(
                ImageAssets.disconnect,
                width: 24.r,
                height: 24.r,
              ),
            ),
          ),
          SizedBox(height: 5.h),

          Text(
            'Disconnect Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Are you sure you want to delete this app ? This action cannot be undone ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.text2Color,
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
          SizedBox(height: 32.h),

          Row(
            children: [
              Expanded(
                child: _buildDialogButton(
                  label: 'Cancel',
                  onTap: () => Get.back(),
                  bgColor: AppColor.whiteColor,
                  textColor: AppColor.blackColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildDialogButton(
                  label: 'Delete',
                  onTap: () {
                    // e.g., authController.logout();
                    Get.offAll(SplashView());
                  },
                  bgColor: const Color(0xFFF24646),
                  textColor: AppColor.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDialogButton({
    required String label,
    required VoidCallback onTap,
    required Color bgColor,
    required Color textColor,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6.r),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
