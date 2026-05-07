import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../../widgets/custom_input_widget.dart';
import '../controllers/settings_controller.dart';

class AddEventView extends StatelessWidget {
  const AddEventView({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                _SectionLabel(
                  icon: ImageAssets.cycle,
                  iconColor: const Color(0xFF4CAF50),
                  label: 'Sports',
                ),
                SizedBox(height: 10.h),
                CustomDropdown(
                  controller: c.selectedSport,
                  items: c.sports,
                  title: '',
                ),
                SizedBox(height: 24.h),
                _SectionLabel(label: 'Event Name'),
                SizedBox(height: 10.h),
                CustomInputWidget(
                  onChanged: (e) {},
                  hintText: 'Enter Event Name',
                  hintTextColor: AppColor.hintTextColor,
                  hintFontWeight: FontWeight.w400,
                  textEditingController: c.eventNameController,
                ),
                SizedBox(height: 24.h),
                _SectionLabel(label: 'Date'),
                SizedBox(height: 10),
                Obx(
                  () => _TappableField(
                    leading: const Icon(
                      Icons.calendar_month,
                      color: Colors.white70,
                      size: 18,
                    ),
                    label: c.formattedSelectedDate(),
                    onTap: () => _pickDate(context, c),
                  ),
                ),

                SizedBox(height: 24.h),

                _SectionLabel(label: 'Distance'),
                SizedBox(height: 10.h),

                CustomDropdown(
                  controller: c.selectedDistance,
                  items: c.distances,
                  title: '',
                ),
                SizedBox(height: 48.h),

                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColor.linearColor, Color(0xFF3A9BD5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: ElevatedButton(
                      onPressed: c.addEvent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child:  Text(
                        'Save Goal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 14.h),

                SizedBox(
                  width: double.infinity,
                  height: 54.h,
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side:  BorderSide(
                        color: AppColor.linearColor,
                        width: 1.5.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child:Text(
                      'Cancel',
                      style: TextStyle(
                        color: AppColor.linearColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

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
          margin: EdgeInsets.only(left: 16.w, top: 5.h, bottom: 5.h),
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
            'Add Event',
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Set Your Training Goals',
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

  Future<void> _pickDate(BuildContext context, SettingsController c) async {
    // 1. Create a "now" timestamp to use for both min and initial comparison
    final DateTime now = DateTime.now();

    // 2. Ensure initial date is not in the past relative to 'now'
    DateTime tempDate = c.selectedDate.value.isBefore(now)
        ? now
        : c.selectedDate.value;

    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => SizedBox(
        height: 320.h,
        child: Column(
          children: [
            // Handle Bar
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: const Color(0xFF8E8E93),
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Text(
                    'Select Date',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      c.setDate(tempDate);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: AppColor.linearColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  brightness:
                      Brightness.dark, // This forces the text to be white
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: Colors.white, // Custom color
                      fontSize: 18.sp, // Using ScreenUtil for consistency
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: tempDate,
                  minimumDate: now,
                  backgroundColor: Colors.transparent,
                  onDateTimeChanged: (dt) => tempDate = dt,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final String? icon;
  final Color iconColor;

  const _SectionLabel({
    required this.label,
    this.icon,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[SvgPicture.asset(icon!), SizedBox(width: 6.w)],
        Text(
          label,
          style: TextStyle(
            color: AppColor.text2Color,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _TappableField extends StatelessWidget {
  final Widget leading;
  final String label;
  final VoidCallback onTap;

  const _TappableField({
    required this.leading,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: AppColor.bgBlackColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white70,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
