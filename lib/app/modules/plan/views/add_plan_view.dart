import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/home/widget/customAppbar.dart';
import 'package:newproject/app/modules/settings/views/time_blocks_view.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/background.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../../widgets/custom_slider.dart';
import '../controllers/plan_controller.dart';
import 'check_in_view.dart';

class AddPlanView extends GetView<PlanController> {
  const AddPlanView({super.key});

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
        child: Background(
          image: ImageAssets.pa,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 20.h,
                        ),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Color(0x2B707070),
                              Color(0x2BC21626),
                              Color(0x2BAD46FF),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 30.r,
                                  height: 30.r,
                                  padding: EdgeInsets.all(6.r),
                                  decoration: BoxDecoration(
                                    color: AppColor.linearColor,
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Icon(
                                    Icons.edit_calendar,
                                    color: Colors.white,
                                    size: 16.r,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Text(
                                  'Make Your Plan',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: 20.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),

                            ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 320.w),
                              child: Text(
                                'Completed workouts will be preserved. Only future workouts will be updated.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.text2Color,
                                  fontSize: 14.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        padding: EdgeInsets.all(17.r),
                        decoration: ShapeDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputField(
                              controller: controller.zipCodeController,
                              label: 'Zip Code',
                              hint: 'e.g. 90201',
                              icon: ImageAssets.location,
                              color: const Color(0xFFD86617),
                              inputType: TextInputType.number,
                            ),
                            SizedBox(height: 26.h),

                            _buildDropdownField(
                              label: 'Sports',
                              value: 'Cycling',
                              icon: ImageAssets.cycle,
                              color: const Color(0xFF1E8F49),
                              hintText: 'Select Sports',
                              controller: controller.sport,
                              items: controller.sports,
                            ),
                            SizedBox(height: 26.h),

                            _buildDropdownField(
                              label: 'Strength Training Activities',
                              value: '1',
                              icon: ImageAssets.training,
                              color: const Color(0xFFFB2C36),
                              hintText: 'Select Training Activities',
                              controller: controller.strength,
                              items: controller.strengts,
                            ),
                            SizedBox(height: 26.h),

                            _buildSliderSection(
                              label: 'Hours Per Week',
                              value: '5h',
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
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
                            _buildLabel(
                              'Training Window',
                              ImageAssets.clock,
                              color: const Color(0xFF0A82A0),
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTimeInput(
                                    'Earliest Start',
                                    '5:00 AM',
                                    controller.startTime,
                                    controller.times,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: _buildTimeInput(
                                    'Latest Start',
                                    '5:00 AM',
                                    controller.endTime,
                                    controller.times,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            _buildLabel(
                              'Level',
                              ImageAssets.level,
                              color: AppColor.blueColor,
                            ),
                            SizedBox(height: 16.h),

                            CustomDropdown(
                              height: 48.h,
                              controller: controller.level,
                              title: '',
                              items: controller.levels,
                              hintText: 'Select Level',
                            ),
                            SizedBox(height: 24.h),

                            _buildOptionTile(
                              label: 'I have heart rate monitor',
                              isSelected: controller.heartRate,
                              icon: Icons.favorite_border,
                            ),
                            SizedBox(height: 16.h),
                            _buildOptionTile(
                              label: 'I have a power meter',
                              isSelected: controller.powerMeter,
                              icon: Icons.bolt,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(17.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildOptionTile(
                              label: 'I know my FTP',
                              isSelected: controller.myFtp,
                            ),
                            SizedBox(height: 16.h),
                            _buildOptionTile(
                              label: 'FTP Test',
                              isSelected: controller.ftpTest,
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              height: 48.h,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                controller: controller.ftpController,
                                decoration: InputDecoration(
                                  hintText: 'Enter FTP',
                                  hintStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),
                      InkWell(
                        onTap: () {
                          Get.to(TimeBlocksView());
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: ShapeDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12.r),
                                    decoration: ShapeDecoration(
                                      color: const Color(0x26336B8A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                      ImageAssets.blocks,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    'Time Blocks',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white.withAlpha(127),
                                size: 16.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        onPress: () async {
                          Get.to(CheckInView());
                        },
                        title: 'Next',
                        leading: true,
                        leadingIcon: ImageAssets.thunder,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required String label,
    required RxBool isSelected,
    IconData icon = Icons.tab,
  }) {
    return GestureDetector(
      onTap: () => isSelected.toggle(),
      child: Obx(
        () => Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(35),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Row(
            children: [
              Container(
                width: 18.r,
                height: 18.r,
                decoration: BoxDecoration(
                  color: isSelected.value
                      ? const Color(0xFF0074F9)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(
                    width: 1.5.r,
                    color: const Color(0xFF0074F9),
                  ),
                ),
                child: isSelected.value
                    ? Icon(Icons.check, size: 12.r, color: Colors.white)
                    : null,
              ),
              SizedBox(width: 20.w),
              if (icon != Icons.tab)
                Icon(icon, color: Colors.white, size: 16.r),
              if (icon != Icons.tab) SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  label,
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
      ),
    );
  }

  Widget _buildTimeInput(
    String title,
    String hintText,
    RxString controller,
    List<String> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdown(
          height: 48.h,
          controller: controller,
          title: title,
          titleFontWeight: FontWeight.w500,
          titleColor: AppColor.whiteColor,
          titleFontSize: 14,
          items: items,
          hintText: hintText,
          useRawItems: false,
          multiSelect: false,
          backgroundColor: Colors.white.withValues(alpha: 0.14),
          borderColor: Colors.white.withValues(alpha: 0.14),
          borderWidth: .0.r,
          iconColor: AppColor.whiteColor,
          menuItemColor: AppColor.whiteColor,
          menuBackgroundColor: Colors.black.withValues(alpha: 0.8),
          selectedTextColor: AppColor.whiteColor,
          borderRadius: 6.r,
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required String icon,
    required Color color,
    required TextEditingController controller,
    TextInputType? inputType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, icon, color: color),
        SizedBox(height: 14.h),
        Container(
          height: 48.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(6.r),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            keyboardType: inputType,
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            style: TextStyle(color: AppColor.whiteColor, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required String icon,
    required Color color,
    required String hintText,
    required RxString controller,
    required List<String> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label, icon, color: color),
        SizedBox(height: 14.h),
        CustomDropdown(
          height: 48.h,
          controller: controller,
          title: '',
          items: items,
          hintText: hintText,
          useRawItems: false,
          multiSelect: false,
          backgroundColor: Colors.white.withValues(alpha: 0.14),
          borderColor: Colors.white.withValues(alpha: 0.14),
          borderWidth: .0.r,
          iconColor: AppColor.whiteColor,
          menuItemColor: AppColor.whiteColor,
          menuBackgroundColor: Colors.black.withValues(alpha: 0.8),
          selectedTextColor: AppColor.whiteColor,
          borderRadius: 6.r,
        ),
      ],
    );
  }

  Widget _buildSliderSection({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '# ',
                style: TextStyle(
                  color: const Color(0xFFA855F7),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: label,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: CustomSlider(
                color: AppColor.linearColor,
                value: controller.hoursPerWeek,
                onChanged: controller.updateHoursPerWeek,
                min: 3,
                max: 30,
              ),
            ),
            SizedBox(width: 10.w),
            Obx(
              () => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0x3F0075DF),
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: const Color(0xFF0075DF)),
                ),
                child: Text(
                  controller.hoursPerWeek.toStringAsFixed(0),
                  style: TextStyle(
                    color: const Color(0xFFF1F1F1),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabel(String text, String icon, {Color color = Colors.white}) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          width: 18.w,
          height: 18.h,
        ),
        SizedBox(width: 7.w),
        Text(
          text,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
