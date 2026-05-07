import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';



/// use way
// required RxDouble sliderValue,
// required Function(double) onSliderChanged,
//
// CustomSlider(
// color: AppColor.linearColor,
// value: sliderValue,
// onChanged: onSliderChanged,
// ),
//
// var hoursPerWeek = 10.0.obs;
// void updateHoursPerWeek(double val) => hoursPerWeek.value = val;
//
// CustomSlider(
// color: AppColor.linearColor,
// value: controller.hoursPerWeek,
// onChanged: controller.updateHoursPerWeek,
// min: 0,
// max: 168,
// )



class CustomSlider extends StatelessWidget {
  final Color color;
  final RxDouble value;
  final Function(double) onChanged;
  final double min;
  final double max;

  const CustomSlider({
    super.key,
    required this.color,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 4.h,
          activeTrackColor: color,
          inactiveTrackColor: const Color(0xFF313A4F),
          thumbColor: Colors.white,
          overlayColor: color.withAlpha(54),
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 8.r,
            elevation: 4,
          ),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 16.r),
          trackShape: const RoundedRectSliderTrackShape(),
        ),
        child: Slider(
          value: value.value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      );
    });
  }
}