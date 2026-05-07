import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/plan/controllers/plan_controller.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../controllers/settings_controller.dart';

class TimeBlocksView extends StatelessWidget {
  const TimeBlocksView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PlanController());
    final List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    final List<String> times = [
      '5am',
      '6am',
      '7am',
      '8am',
      '9am',
      '10am',
      '11am',
      '12am',
      '1pm',
      '2pm',
      '3pm',
      '4pm',
      '5pm',
      '6pm',
      '7pm',
      '8pm',
      '9pm',
      '10pm',
      '11pm',
      '12pm',
      '1am',
      '2am',
      '3am',
      '4am',
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 24.h),
              CustomButton(
                onPress: () async {
                  Get.back();
                },
                title: 'Done',
              ),
              SizedBox(height: 24.h),
              _buildAvailabilityHeader(controller),
              SizedBox(height: 30.h),
              _buildGridHeader(days),
              Expanded(
                child: ListView.builder(
                  itemCount: times.length,
                  itemBuilder: (context, row) {
                    return _buildTimeRow(times[row], row, controller);
                  },
                ),
              ),
              _buildLegend(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvailabilityHeader(PlanController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.white, size: 20.r),
            SizedBox(width: 8.w),
            Text(
              'Weekly Availability',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Obx(
          () => Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              controller.availableHours,
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridHeader(List<String> days) {
    return Row(
      children: [
        SizedBox(width: 60.w), // Space for time labels
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: days
                .map(
                  (d) => Text(
                    d,
                    style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeRow(String time, int rowIndex, PlanController controller) {
    return SizedBox(
      height: 40.h,
      child: Row(
        children: [
          SizedBox(
            width: 60.w,
            child: Text(
              time,
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
          Expanded(
            child: Row(
              children: List.generate(7, (colIndex) {
                int cellIndex = (rowIndex * 7) + colIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => controller.toggleCell(cellIndex),
                    child: Obx(
                      () => Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.2),
                            width: 0.5,
                          ),
                          color: controller.blockedCells.contains(cellIndex)
                              ? const Color(0xFFD63031) // Red for blocked
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // _legendItem(const Color(0xFF74B9FF), 'Available'),
          SizedBox(width: 20.w),
          _legendItem(const Color(0xFFD63031), 'Blocked'),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12.r,
          height: 12.r,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ],
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
        spacing: 12.h,
        children: [
          Text(
            'Plan History',
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 114.w,
            child: Text(
              'Past Rides & Runs',
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
      centerTitle: true,
    );
  }
}
