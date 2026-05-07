import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:newproject/app/modules/auth/views/change_password_view.dart';
import 'package:newproject/app/services/base_url/urls.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationController extends GetxController {
  TextEditingController otpController = TextEditingController();

  RxBool isOtpVerified = false.obs;

  RxBool isLoading = false.obs;

  Future<void> verifyOtp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    debugPrint(preferences.getString('forgot_password_email'));
    debugPrint(otpController.text.trim());
    isLoading.value = true;
    final NetworkResponseModel responseModel = await getNetworkCaller()
        .postCall(BaseUrl.authPasswordVerify, {
          "email": preferences.getString('forgot_password_email'),
          "otp": otpController.text.trim(),
        }, false);
    isLoading.value = false;
    if (responseModel.isSuccess) {
      preferences.setString('forgot_password_otp', otpController.text.trim());
      isOtpVerified.value = true;

      otpController.clear();
      Get.off(ChangePasswordView());
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: responseModel.responseData['details'],
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void resendOtp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Get.put(
      ForgotPasswordController(),
    ).forget(email: preferences.getString('forgot_password_email'));
  }
}
