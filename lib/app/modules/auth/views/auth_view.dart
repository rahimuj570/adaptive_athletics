import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/bindings/register_binding.dart';
import 'package:newproject/app/modules/auth/controllers/login_controller.dart';
import 'package:newproject/app/modules/home/views/navigation.dart';
import 'package:newproject/widgets/show_custom_snackbar.dart';
import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_input_widget.dart';
import 'forget_password_view.dart';
import 'sign_up_view.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
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
                          'Adaptive Athletics',
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
                      'Login',
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
                      'Please Enter your email and password',
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
                      hintText: 'User Email',
                      textEditingController: controller.emailController,
                      onChanged: (value) => (),
                    ),
                    SizedBox(height: 17.h),
                    CustomInputWidget(
                      hintText: 'Password',
                      obscureText: true,
                      textEditingController: controller.passwordController,
                      onChanged: (value1) => (),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.to(
                              ForgetPasswordView(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: AppColor.hintTextColor,
                              fontSize: 14.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.isRemembered.toggle();
                          },
                          child: Obx(
                            () => Container(
                              width: 17,
                              height: 17,
                              decoration: BoxDecoration(
                                color: controller.isRemembered.value
                                    ? AppColor.defaultColor
                                    : Colors.transparent,
                                border: Border.all(
                                  color: controller.isRemembered.value
                                      ? Colors.transparent
                                      : AppColor.textGreyColor,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  color: controller.isRemembered.value
                                      ? AppColor.textWhiteColor
                                      : Colors.transparent,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Remember Me',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.h),
                    Obx(
                      () => CustomButton(
                        title: 'Login',
                        linearGradient: true,
                        onPress: () async {
                          bool isSuccess = await controller.login();
                          if (isSuccess) {
                            controller.emailController.clear();
                            controller.passwordController.clear();
                            Get.offAll(Navbar());
                          } else {
                            Get.snackbar(
                              'Error',
                              'Invalid email or password',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              icon: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            );
                          }
                        },
                        //  controller.isLoading.value
                        // ? null
                        // : controller.login,
                        loading: controller.isLoading.value,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        radius: 30.r,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () =>
                          Get.offAll(SignUpView(), binding: RegisterBinding()),
                      child: SizedBox(
                        width: 343.w,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Don’t have any account?',
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 14.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign Up',
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
