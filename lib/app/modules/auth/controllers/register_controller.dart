import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/models/register_request_model.dart';
import 'package:newproject/app/modules/auth/views/auth_view.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';
import 'package:newproject/app/services/base_url/urls.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final RxBool _isPasswordVisible = false.obs;
  final RxBool _isConfirmPasswordVisible = false.obs;
  final RxBool _isLoading = false.obs;
  final RxBool isAgreeWithPolicy = false.obs;

  RxBool get getIsPasswordVisible => _isPasswordVisible;
  RxBool get getIsConfirmPasswordVisible => _isConfirmPasswordVisible;
  RxBool get getIsLoading => _isLoading;

  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;
  }

  Future<void> register() async {
    _isLoading.value = true;
    RegisterRequestModel registerRequestModel = RegisterRequestModel(
      firstName: nameController.text.trim(),
      lastName: nameController.text.trim(),
      email: signupEmailController.text.trim(),
      password: signupPasswordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );

    NetworkResponseModel responseModel = await getNetworkCaller().postCall(
      BaseUrl.registerUrl,
      registerRequestModel.toJson(),
      false,
    );

    if (responseModel.isSuccess) {
      nameController.clear();
      signupEmailController.clear();
      signupPasswordController.clear();
      confirmPasswordController.clear();
      Get.showSnackbar(
        GetSnackBar(
          title: 'Success',
          message: 'Registration successful',
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
      Get.offAll(AuthView());
    }

    _isLoading.value = false;
  }
}
