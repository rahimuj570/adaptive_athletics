import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/controllers/forgot_password_controller.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_input_widget.dart';
import '../controllers/auth_controller.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPasswordController controller = Get.put(ForgotPasswordController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: SvgPicture.asset(ImageAssets.backward),
                ),
              ),
              SizedBox(height: 60.h),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  children: [
                    Text(
                      'Forget Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 24.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Enter the required details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.text2Color,
                        fontSize: 16.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 67.h),
                    CustomInputWidget(
                      hintText: 'Enter User Email',
                      textEditingController: controller.forgetEmailController,
                      onChanged: (value) => (),
                    ),
                    SizedBox(height: 38.h),
                    Obx(
                      () => CustomButton(
                        title: 'Get OTP',
                        linearGradient: true,
                        onPress: controller.isLoading.value
                            ? null
                            : () => controller.forget(),
                        loading: controller.isLoading.value,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        radius: 30.r,
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
