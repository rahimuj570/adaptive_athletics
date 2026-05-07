import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/views/auth_view.dart';
import 'package:newproject/app/services/base_url/urls.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController extends GetxController {
  TextEditingController setPasswordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> setPassword() async {
    isLoading.value = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    NetworkResponseModel responseModel = await getNetworkCaller()
        .postCall(BaseUrl.passwordReset, {
          "email": preferences.getString('forgot_password_email'),
          "otp": preferences.getString('forgot_password_otp'),
          "new_password": setPasswordController.text.trim(),
          "confirm_password": setPasswordController.text.trim(),
        }, false);
    isLoading.value = false;
    if (responseModel.isSuccess) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Success',
          message: 'Password changed successfully',
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
      Get.offAll(AuthView());
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
}
