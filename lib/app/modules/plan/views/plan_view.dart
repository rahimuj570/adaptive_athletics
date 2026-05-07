import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/background.dart';
import '../controllers/plan_controller.dart';
import 'add_plan_view.dart';

class PlanView extends GetView<PlanController> {
  const PlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Background(
          image: ImageAssets.ep,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24.h),
                  _buildHeader(),
                  SizedBox(height: 12.h),

                  Expanded(
                    child: Obx(() {
                      if (controller.planList.isEmpty) {
                        return _buildEmptyState();
                      }
                      return _buildPlanList();
                    }),
                  ),
                ],
              ),

              Positioned(
                right: 15.w,
                bottom: 85.h,
                child: InkWell(
                  onTap: () => Get.to(AddPlanView()),
                  child: Container(
                    width: 50.sp,
                    height: 50.sp,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.50, -0.00),
                        end: Alignment(0.50, 1.00),
                        colors: [AppColor.buttonColor1, AppColor.buttonColor1],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Icon(Icons.add, size: 24.r, color: AppColor.whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Plan List',
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Set Your Training Goals',
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No plan yet',
        style: TextStyle(
          color: AppColor.textColor.withAlpha(127),
          fontSize: 30.sp,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPlanList() {
    return ListView.separated(
      padding: EdgeInsets.only(
        left: 16.w,
        bottom: 80.h,
        right: 16.w,
        top: 20.h,
      ),
      itemCount: controller.planList.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final plan = controller.planList[index];
        return _comingUp(plan['title'] ?? '', plan['subtitle'] ?? '');
      },
    );
  }

  Widget _comingUp(String title, String subtitle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.r),
          decoration: ShapeDecoration(
            color: AppColor.textAreaColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.r),
                topRight: Radius.circular(6.r),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [AppColor.linearColor, AppColor.defaultColor],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: SvgPicture.asset(
                  ImageAssets.bike,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    AppColor.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 14.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color(
                          0xFF9E9E9E,
                        ), 
                        fontSize: 12.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                ImageAssets.coming,
                width: 24.w, 
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColor.textAreaColor,
            border: Border(
              top: BorderSide(width: 0.5.r, color: AppColor.textAreaColor2),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(6.r),
              bottomRight: Radius.circular(6.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Click here to see the details',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF4BA6D1),
                  fontSize: 10.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8.w),
              SvgPicture.asset(
                ImageAssets.see, 
                width: 14.w,
                height: 14.h,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF4BA6D1),
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
