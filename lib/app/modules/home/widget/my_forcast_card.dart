import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../model/forecast.dart';

class MyForecastCard extends StatelessWidget {
  final ForecastData data;

  const MyForecastCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String statusText;
    String assetPath;

    switch (data.status) {
      case WeatherStatus.ideal:
        bgColor = const Color(0xFF9FF3C2);
        textColor = const Color(0xFF0E9E4D);
        statusText = 'Ideal';
        assetPath = ImageAssets.ideal;
        break;
      case WeatherStatus.alert:
        bgColor = const Color(0xFFFFE082);
        textColor = const Color(0xFFC67C00);
        statusText = 'Alert';
        assetPath = ImageAssets.alert;
        break;
      case WeatherStatus.danger:
        bgColor = const Color(0xFFFFCDD2);
        textColor = const Color(0xFFD32F2F);
        statusText = 'Danger';
        assetPath = ImageAssets.danger;
        break;
    }

    return Container(
      width: 92.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration:  BoxDecoration(color: AppColor.bgColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8.h,
        children: [
          Text(
            data.day,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
            ),
          ),

          SvgPicture.asset(assetPath, width: 14.w, height: 14.h),

          Text(
            '${data.highTemp} ${data.lowTemp}',
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
            ),
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 4.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.textAreaColor),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.w,
              children: [
                SvgPicture.asset(ImageAssets.weather, width: 8.w),
                Text(
                  data.rainChance,
                  style: TextStyle(
                    color: AppColor.textAreaColor,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5.w,
            children: [
              SvgPicture.asset(ImageAssets.wind, width: 8.w),
              Text(
                data.windSpeed,
                style: TextStyle(
                  color: const Color(0xFF4C82A0),
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 3.h),
            decoration: ShapeDecoration(
              color: bgColor,
              shape: const StadiumBorder(),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                color: textColor,
                fontSize: 8.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
