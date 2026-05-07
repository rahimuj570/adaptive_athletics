import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/controllers/register_controller.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_input_widget.dart';
import 'auth_view.dart';

class SignUpView extends GetView<RegisterController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        body: SafeArea(
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                top: isKeyboardOpen ? 50.h : 100.h,
                left: 0,
                right: 0,
                bottom: 0,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          ImageAssets.logo,
                          width: 46.w,
                          height: 40.h,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'ADAPTIV Athletics',
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 18.sp,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 56.h),
                    Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.textColor,
                        fontSize: 24.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Please create your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.text2Color,
                        fontSize: 16.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomInputWidget(
                      hintText: 'User Name',
                      textEditingController: controller.nameController,
                      onChanged: (value) => (),
                    ),
                    SizedBox(height: 17.h),
                    CustomInputWidget(
                      hintText: 'User Email',
                      textEditingController: controller.signupEmailController,
                      onChanged: (value) => (),
                    ),
                    SizedBox(height: 17.h),
                    CustomInputWidget(
                      hintText: 'Password',
                      obscureText: true,
                      textEditingController:
                          controller.signupPasswordController,
                      onChanged: (value1) => (),
                    ),
                    SizedBox(height: 17.h),
                    CustomInputWidget(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      textEditingController:
                          controller.confirmPasswordController,
                      onChanged: (value1) => (),
                    ),
                    SizedBox(height: 54.h),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.isAgreeWithPolicy.toggle();
                          },
                          child: Obx(
                            () => Container(
                              width: 17,
                              height: 17,
                              decoration: BoxDecoration(
                                color: controller.isAgreeWithPolicy.value
                                    ? AppColor.defaultColor
                                    : Colors.transparent,
                                border: Border.all(
                                  color: controller.isAgreeWithPolicy.value
                                      ? Colors.transparent
                                      : AppColor.textGreyColor,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: controller.isAgreeWithPolicy.value
                                      ? AppColor.textWhiteColor
                                      : Colors.transparent,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'I agree to ADAPTIV’s ',
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 12.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'User Agreement',
                                style: TextStyle(
                                  color: AppColor.greenColor,
                                  fontSize: 12.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'and',
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 12.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 12.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: AppColor.greenColor,
                                  fontSize: 12.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: '.',
                                style: TextStyle(
                                  color: AppColor.textColor,
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
                    SizedBox(height: 28.h),
                    Obx(
                      () => CustomButton(
                        title: 'Sign Up',
                        onPress: controller.isAgreeWithPolicy.value
                            ? () => controller.register()
                            : () async => Get.snackbar(
                                'Error',
                                'Please agree to terms and conditions',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              ),
                        loading: controller.getIsLoading.value,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        radius: 30.r,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () => Get.offAll(AuthView()),
                      child: SizedBox(
                        width: 343.w,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'have any account ? ',
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 14.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Log In',
                                style: TextStyle(
                                  color: AppColor.blueColor,
                                  fontSize: 14.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
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
