import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../res/colors/app_color.dart';
import '../models/day_schedule.dart';

class WeekDayCard extends StatelessWidget {
  final DaySchedule schedule;
  final bool isSelected;
  final VoidCallback onTap;

  const WeekDayCard({
    super.key,
    required this.schedule,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.selectColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              schedule.dayName,
              style: TextStyle(
                color: isSelected ? Colors.grey[300] : Colors.grey[500],
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              schedule.dayNumber.toString(),
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[300],
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _WeatherRow(schedule: schedule),
            SizedBox(height: 12),
            _WorkoutBadge(schedule: schedule),
          ],
        ),
      ),
    );
  }
}

class _WeatherRow extends StatelessWidget {
  final DaySchedule schedule;

  const _WeatherRow({required this.schedule});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (schedule.weather) {
      WeatherType.snow => (Icons.ac_unit, AppColor.defaultColor1),
      WeatherType.cloud => (Icons.cloud_outlined, AppColor.greenColor2),
      WeatherType.sun => (Icons.wb_sunny_outlined, AppColor.yellowColor),
      WeatherType.storm => (Icons.thunderstorm_outlined, AppColor.orangeColor),
    };

    final tempStr = schedule.weather == WeatherType.cloud
        ? '${schedule.temperature}'
        : '${schedule.temperature}°';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 14.sp),
        SizedBox(width: 4.w),
        Text(
          tempStr,
          style: TextStyle(
            color: color,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _WorkoutBadge extends StatelessWidget {
  final DaySchedule schedule;

  const _WorkoutBadge({required this.schedule});

  @override
  Widget build(BuildContext context) {
    if (schedule.workoutType == WorkoutType.restDay &&
        schedule.workoutLabel == null) {
      return Text(
        'Rest Day',
        style: TextStyle(color: AppColor.text2Color, fontSize: 10.sp),
      );
    }

    if (schedule.workoutType == WorkoutType.restDay &&
        schedule.workoutLabel != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Rest Day',
            style: TextStyle(color: AppColor.text2Color, fontSize: 10.sp),
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColor.textRedColor.withAlpha(54),
              border: Border.all(color: AppColor.textRedColor, width: 1.w),
              borderRadius: BorderRadius.circular(7.r),
            ),
            child: Text(
              schedule.workoutLabel!,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 10.w,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    }

    final label = schedule.workoutDuration != null
        ? '${schedule.workoutLabel} - ${schedule.workoutDuration}'
        : (schedule.workoutLabel ?? '');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColor.linearColor.withAlpha(54),
        border: Border.all(color: AppColor.linearColor, width: 1.w),
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColor.whiteColor,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
