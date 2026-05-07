import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/views/otp_verify_view.dart';
import 'package:newproject/app/services/base_url/urls.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController forgetEmailController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> forget({String? email}) async {
    isLoading.value = true;
    NetworkResponseModel responseModel = await getNetworkCaller().postCall(
      BaseUrl.sentEmailForgotPassword,
      {"email": email ?? forgetEmailController.text},
      false,
    );

    if (responseModel.isSuccess) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(
        'forgot_password_email',
        email ?? forgetEmailController.text.trim(),
      );
      Get.showSnackbar(
        GetSnackBar(
          title: 'Success',
          message: 'OTP sent to your email',
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
      Get.off(OtpVerifyView());
    } else {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: responseModel.responseData['email'][0],
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }

    isLoading.value = false;
  }
}
