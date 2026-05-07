import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/controllers/login_controller.dart';
import 'package:newproject/app/modules/auth/controllers/user_controller.dart';
import 'package:newproject/app/modules/auth/models/login_response_model.dart';
import 'package:newproject/app/modules/auth/services/auth_prefs_service.dart';
import 'package:newproject/app/modules/plan/views/plan_view.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/show_custom_snackbar.dart';
import '../../chat/views/chat_view.dart';
import '../controllers/home_controller.dart';
import '../widget/my_forcast_card.dart';
import 'notification_view.dart';
import 'ride_details.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    userController.getUser();
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // showCustomSnackBar(
                            //   title: 'Successfully Completed',
                            //   message:
                            //       'You have completed the training. This data will be save in the plan history ',
                            // );
                          },
                          child: Container(
                            width: 44.sp,
                            height: 44.sp,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  userController.user.value?.image ??
                                      'assets/image/img.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        InkWell(
                          onTap: () {
                            // showCustomSnackBar(
                            //   title: 'Successfully Completed',
                            //   message:
                            //       'You have completed the training. This data will be save in the plan history.',
                            //   isSuccess: false,
                            // );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4.h,
                            children: [
                              SizedBox(
                                width: 115.w,
                                child: Text(
                                  'Welcome back,',
                                  style: TextStyle(
                                    color: AppColor.text2Color,
                                    fontSize: 12.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: .660.sw,
                                child: Obx(
                                  () => Text(
                                    userController.user.value?.firstName ?? '',
                                    style: TextStyle(
                                      color: AppColor.textColor,
                                      fontSize: 18.sp,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => Get.to(NotificationView()),
                          child: Container(
                            width: 40.sp,
                            height: 40.sp,
                            decoration: ShapeDecoration(
                              color: AppColor.textAreaColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.notifications,
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 36.h),
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(_showWeather());
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.sp),
                        decoration: ShapeDecoration(
                          color: AppColor.orangeColorLight,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 0.40,
                              color: AppColor.orangeColorLight2,
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Row(
                          spacing: 12.w,
                          children: [
                            Container(
                              padding: EdgeInsets.all(13.sp),
                              decoration: ShapeDecoration(
                                color: AppColor.orangeColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: SvgPicture.asset(ImageAssets.weather),
                            ),
                            Column(
                              spacing: 6.h,
                              children: [
                                SizedBox(
                                  width: .57.sw,
                                  child: Text(
                                    'Weather Alert',
                                    style: TextStyle(
                                      color: AppColor.orangeColorLight3,
                                      fontSize: 14.sp,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: .57.sw,
                                  child: Text(
                                    'Storm forecasted for Wednesday. We\'ve optimized your schedule.',
                                    style: TextStyle(
                                      color: AppColor.orangeColorLight4,
                                      fontSize: 10.sp,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 36.w,
                              height: 36.h,
                              padding: EdgeInsets.all(12.sp),
                              decoration: ShapeDecoration(
                                color: AppColor.orangeColorLight,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                              child: SvgPicture.asset(
                                ImageAssets.forward,
                                colorFilter: ColorFilter.mode(
                                  AppColor.orangeTextColorLight,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 36.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 11.w,
                        vertical: 14.h,
                      ),
                      decoration: ShapeDecoration(
                        color: AppColor.textAreaColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      AppColor.linearColor,
                                      AppColor.defaultColor,
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  ImageAssets.bike,
                                  width: 20.w,
                                  height: 20.h,
                                  colorFilter: ColorFilter.mode(
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
                                      'Bike Intervals',
                                      style: TextStyle(
                                        color: AppColor.textColor,
                                        fontSize: 14.sp,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      'Endurance workout focusing on base fitness',
                                      style: TextStyle(
                                        color: AppColor.text2Color,
                                        fontSize: 12.sp,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 5.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColor.textAreaColor2,
                                  shape: StadiumBorder(),
                                ),
                                child: Text(
                                  'Today at 7:30',
                                  style: TextStyle(
                                    color: AppColor.text2Color,
                                    fontSize: 8.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                horizontal: BorderSide(
                                  color: AppColor.textAreaColor2,
                                  width: 1.w,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildStatItem(
                                  ImageAssets.clock,
                                  '55m',
                                  AppColor.text2Color,
                                ),
                                _buildStatItem(
                                  ImageAssets.hard,
                                  'Hard',
                                  AppColor.greenColor,
                                ),
                                _buildStatItem(
                                  ImageAssets.outdoor,
                                  'Outdoor',
                                  AppColor.text2Color,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          CustomButton(
                            height: 49,
                            onPress: () async {
                              Get.to(RideDetails());
                            },
                            title: 'View',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 36.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(9.r),
                          decoration: ShapeDecoration(
                            color: AppColor.bgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: SvgPicture.asset(
                            ImageAssets.forecast,
                            width: 20.w,
                            height: 20.h,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '7-Day Forecast',
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 16.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'San Francisco, CA',
                                style: TextStyle(
                                  color: AppColor.textAreaColor2,
                                  fontSize: 12.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: ShapeDecoration(
                            color: AppColor.bgGreenColor.withAlpha(54),
                            shape: StadiumBorder(
                              side: BorderSide(
                                width: 1.w,
                                color: AppColor.bgGreenColor.withAlpha(54),
                              ),
                            ),
                          ),
                          child: Text(
                            '7 ideal days',
                            style: TextStyle(
                              color: AppColor.greenColor1,
                              fontSize: 10.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      height: 160.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.weeklyForecast.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final item = controller.weeklyForecast[index];
                          return MyForecastCard(data: item);
                        },
                      ),
                    ),
                    SizedBox(height: 36.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 109.w,
                          child: Text(
                            'Coming Up',
                            style: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 16.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(PlanView());
                          },
                          child: Row(
                            spacing: 4.w,
                            children: [
                              Text(
                                'View All',
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 10.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SvgPicture.asset(
                                ImageAssets.forward,
                                width: 12.w,
                                height: 12.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    _comingUp('Long Ride', 'Sat, Feb 7 - 1h 58m'),
                    SizedBox(height: 12.h),
                    _comingUp('Bike Interval', 'Sun, Feb 8 - 2h'),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
              Positioned(
                right: 15.w,
                bottom: 85.h,
                child: InkWell(
                  onTap: () {
                    Get.to(ChatView());
                  },
                  child: Container(
                    width: 54.sp,
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 16.h,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.50, -0.00),
                        end: Alignment(0.50, 1.00),
                        colors: [
                          AppColor.buttonColor1.withAlpha(115),
                          AppColor.defaultColor.withAlpha(115),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: SvgPicture.asset(ImageAssets.message),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          width: 16.w,
          height: 16.h,
          icon,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 12.sp,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
                        color: AppColor.text2Color,
                        fontSize: 12.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(ImageAssets.coming, width: 24.w),
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
                  color: AppColor.linearColor,
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
                  AppColor.linearColor,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showWeather() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 25.h),
      decoration: ShapeDecoration(
        color: AppColor.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weather Optimization',
                style: TextStyle(
                  color: AppColor.whiteColor,
                  fontSize: 16.sp,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(Get.context!),
                child: Container(
                  padding: EdgeInsets.all(9.r),
                  decoration: const BoxDecoration(
                    color: AppColor.textAreaColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    size: 16.r,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.r),
            decoration: ShapeDecoration(
              color: AppColor.orangeColorLight,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.r, color: AppColor.orangeColorLight2),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bolt,
                      color: AppColor.orangeColorLight3,
                      size: 24.r,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Storm Forecast: Thu Feb 26',
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  "Expected heavy rain and 25mph winds. We've moved your Long Endurance Ride to Tuesday and swapped your recovery session to Wednesday indoors.",
                  style: TextStyle(
                    color: AppColor.orangeColorLight3,
                    fontSize: 12.sp,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Proposed Schedule',
              style: TextStyle(
                color: AppColor.text2Color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 16.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColor.textAreaColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                _buildScheduleRow(
                  'Wednesday',
                  'Long Ride (Moved)',
                  AppColor.greenColor2,
                ),
                Divider(color: AppColor.textAreaColor2, height: 20.h),
                _buildScheduleRow(
                  'Thursday',
                  'Recovery (Swapped)',
                  AppColor.text2Color,
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: _buildButton(
                    text: 'Discard',
                    color: AppColor.textAreaColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: InkWell(
                  onTap: () {
                    showCustomSnackBar(
                      title: 'Successfully Swapped',
                      message: 'You have Successfully swapped your schedule',
                    );
                    // Get.snackbar(
                    //   'Successfully Swapped',
                    //   'You have Successfully swapped your schedule',
                    //   duration: Duration(seconds: 1),
                    // );
                    // ScaffoldMessenger(
                    //   child: SnackBar(
                    //     content: SnackBar(
                    //       content: Text('You have successfully swapped'),
                    //     ),
                    //   ),
                    // );
                    Future.delayed(Duration(seconds: 2), () {
                      Get.back();
                    });
                  },
                  child: _buildButton(
                    text: 'Accept All',
                    gradient: const LinearGradient(
                      colors: [AppColor.buttonColor1, AppColor.defaultColor],
                    ),
                    hasBorder: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleRow(String day, String task, Color taskColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          task,
          style: TextStyle(
            color: taskColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    Color? color,
    Gradient? gradient,
    bool hasBorder = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: ShapeDecoration(
        color: color,
        gradient: gradient,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
          side: hasBorder
              ? BorderSide(color: AppColor.defaultColor, width: 1.r)
              : BorderSide.none,
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: AppColor.whiteColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
