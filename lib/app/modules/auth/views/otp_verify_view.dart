import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/controllers/otp_verification_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/show_custom_snackbar.dart';
import '../controllers/auth_controller.dart';

class OtpVerifyView extends StatefulWidget {
  const OtpVerifyView({super.key});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
  final OtpVerificationController otpVerificationController = Get.put(
    OtpVerificationController(),
  );
  final RxInt secondsRemaining = 60.obs;
  final RxString formattedTime = '01:00'.obs;
  Timer? timer;
  final FocusNode _pinFocusNode = FocusNode();
  // final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
    // _otpController.clear();
  }

  @override
  void dispose() {
    _pinFocusNode.unfocus();
    Future.microtask(() {
      timer?.cancel();
      _pinFocusNode.dispose();
      // _otpController.dispose();
    });
    super.dispose();
  }

  void startTimer() {
    secondsRemaining.value = 60;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsRemaining.value > 0 && mounted) {
        secondsRemaining.value--;
        final minutes = (secondsRemaining.value ~/ 60).toString().padLeft(
          2,
          '0',
        );
        final seconds = (secondsRemaining.value % 60).toString().padLeft(
          2,
          '0',
        );
        formattedTime.value = '$minutes:$seconds';
      } else {
        t.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: SvgPicture.asset(ImageAssets.backward),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 60.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 344.w,
                              child: Text(
                                'Enter the code',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontSize: 24.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Text(
                              'A code was sent to your email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 14.sp,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SizedBox(
                          height: 56.h,
                          width: double.infinity,
                          child: PinCodeTextField(
                            appContext: context,
                            length: 4,
                            textStyle: TextStyle(
                              color: AppColor.whiteColor,
                              fontSize: 24.sp,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                              height: 1.40,
                              letterSpacing: 0.24,
                            ),
                            animationType: AnimationType.fade,
                            cursorColor: AppColor.textColor,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldHeight: 48.h,
                              fieldWidth: 74.w,
                              activeColor: AppColor.textAreaColor,
                              selectedColor: AppColor.defaultColor,
                              inactiveColor: AppColor.textAreaColor,
                              activeFillColor: AppColor.textAreaColor,
                              selectedFillColor: AppColor.textAreaColor,
                              inactiveFillColor: AppColor.textAreaColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            animationDuration: const Duration(
                              milliseconds: 300,
                            ),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            controller: otpVerificationController.otpController,
                            focusNode: _pinFocusNode,
                            onChanged: (value) {
                              otpVerificationController.otpController.text =
                                  value;
                              if (value.length == 4) {
                                otpVerificationController.isOtpVerified.value =
                                    true;
                              } else {
                                otpVerificationController.isOtpVerified.value =
                                    false;
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Didn’t receive a code? ',
                                  style: TextStyle(
                                    color: AppColor.textColor,
                                    fontSize: 15.sp,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.60,
                                  ),
                                ),
                                Obx(
                                  () => InkWell(
                                    onTap: secondsRemaining.value == 0
                                        ? () {
                                            otpVerificationController
                                                .resendOtp();
                                            startTimer();
                                          }
                                        : null,
                                    child: Text(
                                      'Resend',
                                      style: TextStyle(
                                        color: secondsRemaining.value == 0
                                            ? AppColor.defaultColor
                                            : AppColor.textColor,
                                        fontWeight: secondsRemaining.value == 0
                                            ? FontWeight.bold
                                            : FontWeight.w600,
                                        fontSize: 14.sp,
                                        fontFamily: 'DM Sans',
                                        letterSpacing: 0.60,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Obx(
                              () => Text(
                                'Resend available in ${formattedTime.value}',
                                style: TextStyle(
                                  color: AppColor.defaultColor,
                                  fontSize: 15.sp,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.60,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 50.h),
                            Obx(
                              () => CustomButton(
                                linearGradient: true,
                                title: 'Done',
                                buttonColor:
                                    otpVerificationController
                                        .isOtpVerified
                                        .value
                                    ? AppColor.defaultColor
                                    : AppColor.subTitleColor,
                                buttonColor1:
                                    otpVerificationController
                                        .isOtpVerified
                                        .value
                                    ? AppColor.buttonColor1
                                    : AppColor.subTitleColor,
                                borderColor: AppColor.borderareaColor,
                                textColor: AppColor.textWhiteColor,
                                loading:
                                    otpVerificationController.isLoading.value,
                                onPress: () async {
                                  otpVerificationController.isOtpVerified.value
                                      ? otpVerificationController
                                                .isLoading
                                                .value
                                            ? null
                                            : otpVerificationController
                                                  .verifyOtp()
                                      : showCustomSnackBar(
                                          title: 'Error',
                                          message:
                                              'Empty : Fill All OTP Fields',
                                          backgroundColor: AppColor.redColor,
                                          isSuccess: false,
                                        );
                                },
                              ),
                            ),
                            SizedBox(height: 220.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Auth View')));
  }
}
