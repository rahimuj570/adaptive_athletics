import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/home/views/navigation.dart';
import 'package:newproject/app/modules/home/widget/customAppbar.dart';
import 'package:newproject/widgets/show_custom_snackbar.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/background.dart';
import '../../../../widgets/custom_input_widget.dart';
import '../../../../widgets/custom_slider.dart';
import '../controllers/plan_controller.dart';

class CheckInView extends GetView<PlanController> {
  const CheckInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title: '',
        subtitle: '',
        // title: 'Play Creation',
        // subtitle: 'play creation and you create your plan here',
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Background(
            image: ImageAssets.ci,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 20.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildCheckInHeader(),
                              SizedBox(height: 36.h),

                              _buildMetricSlider(
                                label: 'Sleep',
                                icon: ImageAssets.sleep,
                                color: const Color(0xFFC27AFF),
                                value: '5/10',
                                sliderValue: controller.sleep,
                                onSliderChanged: (value) =>
                                    controller.updateSleep(value),
                              ),
                              SizedBox(height: 36.h),
                              _buildMetricSlider(
                                label: 'Energy',
                                icon: ImageAssets.energy,
                                color: const Color(0xFFF0B100),
                                value: '5/10',
                                sliderValue: controller.energy,
                                onSliderChanged: (value) =>
                                    controller.updateEnergy(value),
                              ),
                              SizedBox(height: 36.h),
                              _buildMetricSlider(
                                label: 'Soreness',
                                icon: ImageAssets.soreness,
                                color: const Color(0xFFFF2056),
                                value: '5/10',
                                isReversed: true,
                                sliderValue: controller.soreness,
                                onSliderChanged: (value) =>
                                    controller.updateSoreness(value),
                              ),
                              SizedBox(height: 36.h),
                              _buildMetricSlider(
                                label: 'Mood',
                                icon: ImageAssets.mood,
                                color: AppColor.bgGreenColor,
                                value: '5/10',
                                sliderValue: controller.mood,
                                onSliderChanged: (value) =>
                                    controller.updateMood(value),
                              ),
                              SizedBox(height: 36.h),

                              _buildWeightInput(),
                              SizedBox(height: 36.h),

                              _buildSubmitButton(),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildCheckInHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(ImageAssets.checkIn, width: 24.r, height: 24.r),
            SizedBox(width: 16.w),
            Text(
              'Weekly Check-In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 13.h),
        Text(
          "Tell us how you're feeling for personalized recommendations",
          style: TextStyle(
            color: const Color(0xFF939393),
            fontSize: 14.sp,
            height: 1.43,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricSlider({
    required String label,
    required String icon,
    required Color color,
    required String value,
    bool isReversed = false,
    required RxDouble sliderValue,
    required Function(double) onSliderChanged,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  width: 20.r,
                  height: 20.h,
                ),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Obx(
              () => Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF393939),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  "${sliderValue.toStringAsFixed(0)}/10",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.h),
        CustomSlider(
          color: color,
          value: sliderValue,
          min: 0,
          max: 10,
          onChanged: onSliderChanged,
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isReversed ? 'High' : 'Low',
              style: TextStyle(
                color: const Color(0xFFF1F1F1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              isReversed ? 'Low' : 'High',
              style: TextStyle(
                color: const Color(0xFFF1F1F1),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeightInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              ImageAssets.weight,
              colorFilter: const ColorFilter.mode(
                Color(0xFF2B7FFF),
                BlendMode.srcIn,
              ),
              width: 20.r,
              height: 20.h,
            ),
            SizedBox(width: 8.w),
            Text(
              'Weight (lbs)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        CustomInputWidget(
          onChanged: (e) {},
          backgroundColor: AppColor.textAreaColor3,
          hintText: 'Optional',
          hintTextColor: AppColor.text2Color,
          hintFontSize: 14.sp,
          hintFontWeight: FontWeight.w400,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return InkWell(
      onTap: () async {
        showCustomSnackBar(
          title: 'Successfully Created',
          message: 'You have sucessfully created the your work plan',
        );

        bool isSuccess = await controller.savePlan();
        if (isSuccess) {
          Future.delayed(Duration(milliseconds: 600), () {
            Get.offAll(Navbar());
          });
        } else {
          Get.snackbar(
            'Error',
            'Something went wrong',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 17.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColor.buttonColor1, AppColor.defaultColor],
          ),
          borderRadius: BorderRadius.circular(99.r),
          border: Border.all(color: AppColor.defaultColor),
        ),
        alignment: Alignment.center,
        child: Text(
          'Submit Assessment',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
