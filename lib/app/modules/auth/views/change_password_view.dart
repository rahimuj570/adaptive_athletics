import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/controllers/change_password_controller.dart';
import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_input_widget.dart';
import '../controllers/auth_controller.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePasswordController changePasswordConroller = Get.put(
    ChangePasswordController(),
  );
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RxBool toggle1 = true.obs;
  final RxBool toggle2 = true.obs;
  final String? origin = Get.arguments?['origin'] as String?;

  @override
  void dispose() {
    confirmPasswordController.dispose();
    changePasswordConroller.dispose();
    super.dispose();
  }

  String? validatePassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords do not match. Please enter the same password in both fields.';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one digit.';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  Future<void> onSavePassword() async {
    final password = changePasswordConroller.setPasswordController.text;
    final confirmPassword = confirmPasswordController.text;
    final error = validatePassword(password, confirmPassword);

    if (error != null) {
      Get.snackbar(
        'Error',
        error,
        backgroundColor: Colors.red,
        colorText: AppColor.whiteColor,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    await changePasswordConroller.setPassword();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.blackColor,
        body: SafeArea(
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

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h),
                    Text(
                      'Reset Password',
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
                      'Please enter your new password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.text2Color,
                        fontSize: 16.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    CustomInputWidget(
                      hintText: 'Password',
                      obscureText: true,
                      onChanged: (value) => (),
                      textEditingController:
                          changePasswordConroller.setPasswordController,
                    ),
                    SizedBox(height: 24.h),
                    CustomInputWidget(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      onChanged: (value) => (),
                      textEditingController: confirmPasswordController,
                    ),
                    SizedBox(height: 34.h),
                    Obx(
                      () => CustomButton(
                        title: 'Save Password',
                        fontWeight: FontWeight.w700,
                        onPress: changePasswordConroller.isLoading.value
                            ? null
                            : onSavePassword,
                        loading: changePasswordConroller.isLoading.value,
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
