import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/res/assets/image_assets.dart';

import '../../../../res/colors/app_color.dart';
import '../controllers/settings_controller.dart';
import '../widgets/event_model.dart';
import 'add_event_view.dart';

class EventPlanningView extends StatelessWidget {
  const EventPlanningView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController c = Get.find();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active Goals',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(
                      () => const AddEventView(),
                      transition: Transition.rightToLeft,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.linearColor,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 18.r),
                          SizedBox(width: 4.w),
                          Text(
                            'Add Event',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: Obx(() {
                  if (c.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColor.linearColor,
                        strokeWidth: 2.w,
                      ),
                    );
                  }
                  if (c.events.isEmpty) {
                    return _EmptyState();
                  }
                  return ListView.separated(
                    itemCount: c.events.length,
                    padding: EdgeInsets.only(bottom: 20.h),
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (_, i) =>
                        _EventItem(event: c.events[i], controller: c),
                  );
                }),
              ),
            ],
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
          margin: EdgeInsets.only(left: 16.w,top: 5.h,bottom: 5.h),
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
            'Event Planning',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Set Your Training Goals',
            style: TextStyle(
              color: const Color(0xFF8E8E93),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}

class _EventItem extends StatelessWidget {
  final EventModel event;
  final SettingsController controller;

  const _EventItem({required this.event, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: const Color(0xFF51A2FF).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              _sportIcon(event.sport),
              color: const Color(0xFF51A2FF),
              size: 22.r,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      event.formattedDate,
                      style: TextStyle(
                        color: const Color(0xFF8E8E93),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 3.r,
                      height: 3.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFF8E8E93),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${event.distanceKm % 1 == 0 ? event.distanceKm.toInt() : event.distanceKm} km',
                      style: TextStyle(
                        color: AppColor.linearColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _confirmDelete(context),
            child: Container(
              width: 36.r,
              height: 36.r,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: SvgPicture.asset(
                ImageAssets.delete,
                colorFilter: ColorFilter.mode(
                  Colors.red,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _sportIcon(String sport) {
    switch (sport.toLowerCase()) {
      case 'cycling':
        return Icons.directions_bike;
      case 'running':
        return Icons.directions_run;
      case 'swimming':
        return Icons.pool;
      case 'walking':
        return Icons.directions_walk;
      default:
        return Icons.calendar_month;
    }
  }

  void _confirmDelete(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        title: Text(
          'Delete Event',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Remove "${event.eventName}" from your goals?',
          style: TextStyle(color: const Color(0xFF8E8E93), fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColor.linearColor, fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteEvent(event.id);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.redAccent, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72.r,
            height: 72.r,
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              Icons.event_note_rounded,
              color: AppColor.linearColor,
              size: 36.r,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Active Goals',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Tap "Add Event" to set your first\ntraining goal.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 13.sp),
          ),
        ],
      ),
    );
  }
}
