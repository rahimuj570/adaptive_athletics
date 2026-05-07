import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_input_widget.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 32.h),
                Stack(
                  children: [
                    Container(
                      width: 110.w,
                      height: 110.h,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/image/img.png'),
                          fit: BoxFit.cover,
                        ),
                        shape: OvalBorder(
                          side: BorderSide(
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: AppColor.textAreaColor,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => Get.to(EditProfileView()),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: ShapeDecoration(
                            color: AppColor.defaultColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1.50,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x1E000000),
                                blurRadius: 4.50,
                                offset: Offset(2, 6),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: Icon(Icons.camera),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
                _header('Name'),
                SizedBox(height: 12.h),
                CustomInputWidget(onChanged: (onChanged) {}),
                SizedBox(height: 16.h),
                _header('Email'),
                SizedBox(height: 12.h),
                CustomInputWidget(onChanged: (onChanged) {}),
                SizedBox(height: 16.h),
                _header('Location'),
                SizedBox(height: 12.h),
                CustomInputWidget(onChanged: (onChanged) {}),
                SizedBox(height: 140.h),
                CustomButton(onPress: () async {}, title: 'Confirm'),
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
          margin: EdgeInsets.only(left: 16.w,top: 5.h,bottom: 5.h),
          decoration: BoxDecoration(
            color: AppColor.bgBlackColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(Icons.chevron_left, color: Colors.white, size: 24.w),
        ),
      ),
      title: Text(
        'Edit Profile',
        style: TextStyle(
          color: AppColor.whiteColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _header(String title) {
    return SizedBox(
      width: 344.w,
      child: Text(
        title,
        style: TextStyle(
          color: AppColor.textColor,
          fontSize: 14.sp,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
