import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/home/views/ride_details/powerProfile.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/background.dart';
import '../../../../widgets/custom_button.dart';
import '../controllers/home_controller.dart';

class RideDetails extends GetView<HomeController> {
  const RideDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body: Background(
          image: ImageAssets.rd,
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w, right: 18.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(14.r),
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColor.linearColor,
                                    AppColor.defaultColor,
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                              ),
                              child: SvgPicture.asset(
                                ImageAssets.bike,
                                width: 24.w,
                                height: 24.h,
                                colorFilter: ColorFilter.mode(
                                  AppColor.whiteColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              width: 150.w,
                              child: Text(
                                'Bike Interval',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 20.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            SizedBox(
                              width: 150.w,
                              child: Text(
                                'Feb 8 at 11:30 AM',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.text2Color,
                                  fontSize: 14.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 8.w,
                          children: [
                            _buildBadges(icon: ImageAssets.hard, label: 'Hard'),
                            _buildBadges(
                              icon: ImageAssets.outdoor,
                              label: 'Outdoor',
                            ),
                          ],
                        ),
                        SizedBox(height: 48.h),
                        Row(
                          spacing: 10.w,
                          children: [
                            Expanded(
                              child: _buildWeatherStatCard(
                                icon: ImageAssets.forecast,
                                iconBgColor: const Color(0x269AE600),
                                iconColor: AppColor.greenColor,
                                value: '12°-7°',
                                valueColor: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: _buildWeatherStatCard(
                                icon: ImageAssets.weather,
                                iconBgColor: AppColor.linearColor.withAlpha(38),
                                iconColor: AppColor.linearColor,
                                value: '1%',
                                valueColor: AppColor.linearColor,
                              ),
                            ),
                            Expanded(
                              child: _buildWeatherStatCard(
                                icon: ImageAssets.wind,
                                iconBgColor: const Color(0x264C82A0),
                                iconColor: const Color(0xFF4C82A0),
                                value: '6 mph',
                                valueColor: const Color(0xFF4C82A0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 17.h,
                          ),
                          decoration: ShapeDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Warm up, then do bike intervals at 80-90% FTP with recovery spins',
                              style: TextStyle(
                                color: AppColor.textColor,
                                fontSize: 14.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 1.43,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(14.r),
                          decoration: ShapeDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10.r),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF0074F9),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          ImageAssets.powerProfile,
                                          colorFilter: ColorFilter.mode(
                                            AppColor.whiteColor,
                                            BlendMode.srcIn,
                                          ),
                                          width: 20.w,
                                          height: 20.h,
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Text(
                                        'Power Profile',
                                        style: TextStyle(
                                          color: AppColor.textColor,
                                          fontSize: 18.sp,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1.r,
                                          color: const Color(0xFF5B5B5B),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'FTP: 250w',
                                      style: TextStyle(
                                        color: AppColor.textColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              // Wrap(
                              //   spacing: 20.w,
                              //   runSpacing: 10.h,
                              //   alignment: WrapAlignment.center,
                              //   children: [
                              //     _buildPowerLabel('325w'),
                              //     _buildPowerLabel('170w'),
                              //     _buildPowerLabel('85w'),
                              //     _buildPowerLabel('0w'),
                              //     _buildPowerLabel('0m'),
                              //     _buildPowerLabel('5.9m'),
                              //     _buildPowerLabel('6m'),
                              //     _buildPowerLabel('35.9m'),
                              //     _buildPowerLabel('39.9m'),
                              //     _buildPowerLabel('36m'),
                              //     _buildPowerLabel(
                              //       'FTP',
                              //       color: const Color(0xFFFF8904),
                              //     ),
                              //   ],
                              // ),
                              PowerProfile(),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(18.r),
                          decoration: ShapeDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.r),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF00B847),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                      ImageAssets.zone,
                                      colorFilter: ColorFilter.mode(
                                        AppColor.whiteColor,
                                        BlendMode.srcIn,
                                      ),
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    'Power Zones',
                                    style: TextStyle(
                                      color: AppColor.textColor,
                                      fontSize: 18.sp,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              Column(
                                children: [
                                  _buildZoneRow(
                                    'Z1',
                                    '<138w',
                                    const Color(0xFF44A7FF),
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildZoneRow(
                                    'Z2',
                                    '140 - 188w',
                                    const Color(0xFF00E275),
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildZoneRow(
                                    'Z3',
                                    '190-225w',
                                    const Color(0xFFFFCA00),
                                    isTarget: true,
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildZoneRow(
                                    'Z4',
                                    '228-263w',
                                    const Color(0xFFFF8B16),
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildZoneRow(
                                    'Z5',
                                    '265-300w',
                                    const Color(0xFFFF666C),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(19.r),
                          decoration: ShapeDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10.r),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFAB3CF9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                      ImageAssets.workout,
                                      colorFilter: ColorFilter.mode(
                                        AppColor.whiteColor,
                                        BlendMode.srcIn,
                                      ),
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Text(
                                    'Workout Structure',
                                    style: TextStyle(
                                      color: AppColor.textColor,
                                      fontSize: 18.sp,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 28.h),

                              Column(
                                children: [
                                  _buildWorkoutBlock(
                                    title: 'Warm-up',
                                    duration: '6m',
                                    power: '125w',
                                    description:
                                        'Easy spinning, gradually increase effort',
                                    indicatorColor: const Color(0xFF44A7FF),
                                  ),
                                  SizedBox(height: 10.h),
                                  _buildWorkoutBlock(
                                    title: 'Tempo Block',
                                    duration: '15m',
                                    power: '210w',
                                    description:
                                        'Sustained effort at moderate intensity',
                                    indicatorColor: const Color(0xFFFFCA00),
                                  ),
                                  SizedBox(height: 10.h),
                                  _buildWorkoutBlock(
                                    title: 'Cool-down',
                                    duration: '6m',
                                    power: '125w',
                                    description: 'Lower heart rate and recover',
                                    indicatorColor: const Color(0xFF44A7FF),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Column(
                          children: [
                            _buildDataRow(
                              label: 'Date',
                              value: 'Feb 8, Sat, at 11:21 AM',
                              isFirst: true,
                            ),
                            _buildDataRow(label: 'Time', value: '01:00:00'),
                            _buildDataRow(
                              label: 'Distance',
                              value: '1.00 km',
                              isLast: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 17.h,
                          ),
                          decoration: ShapeDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 3.w,
                            children: [
                              SizedBox(
                                width: 155.w,
                                child: Text(
                                  'Type',
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: 14.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 170.w,
                                child: Text(
                                  'Cycling',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: 14.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Goal',
                            style: TextStyle(
                              color: AppColor.textColor,
                              fontSize: 12.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Column(
                          children: [
                            _buildDataRow(
                              label: 'Targeted Date',
                              value: 'Feb 8 at 11:21 AM',
                              isFirst: true,
                            ),
                            _buildDataRow(
                              label: 'Event Name',
                              value: 'Marathon',
                              isLast: true,
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        CustomButton(
                          onPress: () async {
                            Get.back();
                          },
                          title: 'Complete Workout',
                          leading: true,
                          leadingIcon: ImageAssets.coming,
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: SvgPicture.asset(ImageAssets.backward),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow({
    required String label,
    required String value,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 17.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.vertical(
          top: isFirst ? Radius.circular(10.r) : Radius.zero,
          bottom: isLast ? Radius.circular(10.r) : Radius.zero,
        ),
        border: !isLast
            ? Border(
                bottom: BorderSide(color: const Color(0xFF2B3241), width: 1.w),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 14.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFFF1F1F1),
              fontSize: 14.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutBlock({
    required String title,
    required String duration,
    required String power,
    required String description,
    required Color indicatorColor,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 12.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        _buildBadge(duration, isOutlined: true),
                        SizedBox(width: 8.w),
                        _buildBadge(power, isOutlined: false),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, {required bool isOutlined}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : const Color(0x3F0075DF),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: isOutlined ? AppColor.textColor : const Color(0xFF0075DF),
          width: 1.r,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFFF1F1F1),
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildZoneRow(
    String zone,
    String range,
    Color color, {
    bool isTarget = false,
  }) {
    return Container(
      padding: isTarget
          ? EdgeInsets.all(10.r)
          : EdgeInsets.symmetric(horizontal: 10.r),
      decoration: isTarget
          ? ShapeDecoration(
              color: const Color(0xFF293757),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 16.r,
                height: 16.r,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              SizedBox(width: 15.w),
              Text(
                zone,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 14.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Text(
                range,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 14.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (isTarget) ...[
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF0075DF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Text(
                    'Target',
                    style: TextStyle(
                      color: const Color(0xFFF1F1F1),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPowerLabel(
    String text, {
    Color color = const Color(0xFFF1F1F1),
  }) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 14.sp,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildBadges({required String icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: ShapeDecoration(
        color: AppColor.bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4.w,
        children: [
          SvgPicture.asset(icon, width: 10.w, height: 10.h),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherStatCard({
    required String icon,
    required Color iconBgColor,
    required Color iconColor,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: valueColor,
              fontSize: 14.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
