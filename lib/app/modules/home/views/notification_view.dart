import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../controllers/home_controller.dart';
import '../widget/notifications.dart';

class NotificationView extends GetView<HomeController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        appBar: AppBar(
          backgroundColor: AppColor.blackColor,
          elevation: 0,
          leadingWidth: 60.w,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: SvgPicture.asset(ImageAssets.backward),
            ),
          ),
          title: Text(
            'Notification',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 20.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 21.w, right: 26.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) {
                      return WeatherNotificationTile(
                        data: controller.notifications[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherNotificationTile extends StatelessWidget {
  final Notifications data;

  const WeatherNotificationTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.w, color: AppColor.textAreaColor2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: const BoxDecoration(
              color: AppColor.textAreaColor,
              shape: BoxShape.circle,
            ),
            child: Icon(data.icon, color: AppColor.whiteColor, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.message,
                  style: TextStyle(
                    color: AppColor.textColor,
                    fontSize: 14.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  data.title,
                  style: TextStyle(
                    color: AppColor.text2Color,
                    fontSize: 12.sp,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
