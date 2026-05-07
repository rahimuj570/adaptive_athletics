import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/plan/views/add_plan_view.dart';
import '../../../../res/colors/app_color.dart';
import '../controllers/calendar_controller.dart';
import '../models/activity.dart';
import '../widget/regular_activity_card.dart';
import '../widget/strength_activity_card.dart';
import '../widget/week_day_card.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<CalendarController>();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Calendar',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Your weekly schedule',
                              style: TextStyle(
                                color: AppColor.textAreaColor2,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.bgBlackColor,
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              Get.to(AddPlanView());
                            },
                            icon: Icon(
                              Icons.bolt,
                              color: AppColor.whiteColor,
                              size: 18.sp,
                            ),
                            label: Text(
                              'Add',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 10.h,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.sp),

                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _NavButton(
                            icon: Icons.chevron_left,
                            onTap: c.isLoading.value ? null : c.previousWeek,
                          ),
                          Text(
                            c.weekRange,
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          _NavButton(
                            icon: Icons.chevron_right,
                            onTap: c.isLoading.value ? null : c.nextWeek,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Obx(() {
                      if (c.isLoading.value) {
                        return SizedBox(
                          height: 220.h,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.defaultColor,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }
                      if (c.weekSchedule.isEmpty) return SizedBox();

                      return Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: WeekDayCard(
                                    schedule: c.weekSchedule[0],
                                    isSelected: c.selectedDayIndex.value == 0,
                                    onTap: () => c.selectDay(0),
                                  ),
                                ),
                                _VDivider(),
                                Expanded(
                                  child: WeekDayCard(
                                    schedule: c.weekSchedule[1],
                                    isSelected: c.selectedDayIndex.value == 1,
                                    onTap: () => c.selectDay(1),
                                  ),
                                ),
                                _VDivider(),
                                Expanded(
                                  child: WeekDayCard(
                                    schedule: c.weekSchedule[2],
                                    isSelected: c.selectedDayIndex.value == 2,
                                    onTap: () => c.selectDay(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: WeekDayCard(
                                    schedule: c.weekSchedule[3],
                                    isSelected: c.selectedDayIndex.value == 3,
                                    onTap: () => c.selectDay(3),
                                  ),
                                ),
                                _VDivider(),
                                Expanded(
                                  child: WeekDayCard(
                                    schedule: c.weekSchedule[4],
                                    isSelected: c.selectedDayIndex.value == 4,
                                    onTap: () => c.selectDay(4),
                                  ),
                                ),
                                _VDivider(),
                                Expanded(
                                  child: WeekDayCard(
                                    schedule: c.weekSchedule[5],
                                    isSelected: c.selectedDayIndex.value == 5,
                                    onTap: () => c.selectDay(5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),

                    SizedBox(height: 30.h),

                    Text(
                      'Coming Up',
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'This activities you have today !',
                      style: TextStyle(color: Colors.grey[500], fontSize: 14),
                    ),
                    SizedBox(height: 16.h),

                    Obx(() {
                      if (c.isLoading.value) {
                        return Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            color: AppColor.bgBlueColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.defaultColor,
                              strokeWidth: 2,
                            ),
                          ),
                        );
                      }

                      final int? selectedIdx = c.selectedDayIndex.value;

                      final dayActivities =
                          (selectedIdx != null &&
                              selectedIdx < c.weekSchedule.length)
                          ? c.weekSchedule[selectedIdx].activities
                          : [];

                      if (dayActivities.isEmpty &&
                          c.selectedDayIndex.value == null) {
                        return Container(
                          padding: EdgeInsets.all(20.sp),
                          decoration: BoxDecoration(
                            color: AppColor.bgBlueColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Center(
                            child: Text(
                              'No activity planned for this day',
                              style: TextStyle(
                                color: AppColor.text2Color,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        //  itemCount: dayActivities.length,
                        itemCount: 1,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (_, i) {
                          final activity = dayActivities[i];
                          if (activity.cardType ==
                              ActivityCardType.strengthTraining) {
                            return StrengthActivityCard(activity: activity);
                          }
                          return RegularActivityCard(activity: activity);
                        },
                      );
                    }),
                    SizedBox(height: 84.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _NavButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: onTap == null ? 0.3 : 1.0,
        duration: Duration(milliseconds: 200),
        child: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColor.bgBlackColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColor.whiteColor, size: 22.sp),
        ),
      ),
    );
  }
}

class _VDivider extends StatelessWidget {
  const _VDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1.r, color: AppColor.dividerColor);
  }
}
