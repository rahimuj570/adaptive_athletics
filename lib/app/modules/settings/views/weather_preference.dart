import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_slider.dart';
import '../controllers/settings_controller.dart';

class WeatherPreference extends GetView<SettingsController> {
  const WeatherPreference({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        appBar: AppBar(
          backgroundColor: AppColor.blackColor,
          elevation: 0,
          leadingWidth: 60.w,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: SvgPicture.asset(ImageAssets.backward),
            ),
          ),
          title: Column(
            spacing: 8.h,
            children: [
              Text(
                'Weather Preference',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 20.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Input your personal preference',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.textAreaColor2,
                  fontSize: 14.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 21.w, right: 26.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),
                  _weatherPreference(
                    icon: ImageAssets.miniTemp,
                    title: 'Minimum Temp',
                    parameter: '2°C',
                    sliderValue: controller.miniTemp,
                    onSliderChanged: controller.updateMiniTemp,
                  ),
                  SizedBox(height: 12.h),
                  _weatherPreference(
                    icon: ImageAssets.ideal,
                    title: 'Maximum Temp',
                    parameter: '30°C',
                    sliderValue: controller.maxTemp,
                    onSliderChanged: controller.updateMaxTemp,
                  ),
                  SizedBox(height: 12.h),
                  _weatherPreference(
                    icon: ImageAssets.miniTemp,
                    title: 'Rain Tolerance',
                    parameter: '15%',
                    sliderValue: controller.rain,
                    onSliderChanged: controller.updateRain,
                  ),
                  SizedBox(height: 12.h),
                  _weatherPreference(
                    icon: ImageAssets.miniTemp,
                    title: 'Max Wind Speed',
                    parameter: '2°C',
                    sliderValue: controller.wind,
                    onSliderChanged: controller.updateWind,
                  ),
                  SizedBox(height: 12.h),
                  _daylightToggleTile(),
                  SizedBox(height: 40.h),
                  CustomButton(
                    onPress: () async {},
                    title: 'Save & Optimize Plan',
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _weatherPreference({
    required String icon,
    required String title,
    required String parameter,
    required RxDouble sliderValue,
    required Function(double) onSliderChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 22.h),
      decoration: ShapeDecoration(
        color: AppColor.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 18.w,
                    height: 18.h,
                    colorFilter: const ColorFilter.mode(
                      AppColor.linearColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                parameter,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          CustomSlider(
            color: AppColor.linearColor,
            value: sliderValue,
            onChanged: onSliderChanged,
          ),
        ],
      ),
    );
  }

  Widget _daylightToggleTile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColor.bgColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wb_sunny_outlined,
                    color: Colors.white,
                    size: 18.r,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Daylight Only',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Obx(
                () => Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: controller.isDaylightOnly.value,
                    activeThumbColor: const Color(0xFFD0F7D1),
                    activeTrackColor: const Color(0xFF13CE66),
                    inactiveThumbColor: AppColor.textAreaColor2,
                    inactiveTrackColor: const Color(0xFF1E2832),
                    onChanged: (val) => controller.toggleDaylight(val),
                  ),
                ),
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFFA7D8F9),
            border: Border.all(color: AppColor.bgColor, width: 1.5),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.r),
              bottomRight: Radius.circular(10.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: AppColor.buttonColor1,
                size: 12.r,
              ),
              SizedBox(width: 6.w),
              Text(
                'Toggle if you want to avoid night training',
                style: TextStyle(
                  color: AppColor.buttonColor1,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
