import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../controllers/settings_controller.dart';

class MembershipView extends GetView<SettingsController> {
  const MembershipView({super.key});

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
            'Membership',
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
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    SvgPicture.asset(ImageAssets.card),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: 1.sw - 32.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 12.w,
                        children: [
                          SvgPicture.asset(ImageAssets.pro),
                          Text(
                            'Pro Member',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFFFB020),
                              fontSize: 18,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.h),
                    SizedBox(
                      width: 1.sw - 32.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 12.w,
                        children: [
                          SizedBox(
                            width: 115.w,
                            child: Text(
                              'Type',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 18.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            'Pro Member',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: const Color(0xFF13CE66),
                              fontSize: 18.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _item('Billing Date', '27-06-2025'),
                    SizedBox(height: 24.h),
                    _item('Billed Monthly', '\$9.99'),
                    SizedBox(height: 24.h),
                    _item('Expiry Date', '27 - 07 - 2025'),
                  ],
                ),
                Positioned(
                  bottom: 15.h,
                  right: 16.w,
                  left: 16.w,
                  child: CustomButton(
                    onPress: () async {},
                    title: 'Upgrade Now',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return SizedBox(
      width: 1.sw - 32.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 12.w,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              title,
              style: TextStyle(
                color: AppColor.whiteColor,
                fontSize: 18.sp,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: AppColor.whiteColor,
              fontSize: 18.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
