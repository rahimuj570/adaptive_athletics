import 'package:flutter/src/widgets/editable_text.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/models/login_response_model.dart';
import 'package:newproject/app/modules/auth/services/auth_prefs_service.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';
import 'package:newproject/app/services/base_url/urls.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var loginResponseModel = Rxn<LoginResponseModel>();

  RxBool isRemembered = false.obs;
  RxBool isLoading = false.obs;

  Future<bool> login() async {
    NetworkResponseModel responseModel = await getNetworkCaller()
        .postCall(BaseUrl.loginUrl, {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }, false);

    if (responseModel.isSuccess) {
      AuthPrefsService().saveToken(
        responseModel.responseData['data']['access'],
      );
      AuthPrefsService().saveRefreshToken(
        responseModel.responseData['data']['refresh'],
      );
      loginResponseModel.value = LoginResponseModel.fromJson(
        responseModel.responseData['data']['user'],
      );
      AuthPrefsService().saveRememberMe(isRemembered.value);
      AuthPrefsService().saveUser(loginResponseModel.value!);
      return true;
    }

    return false;
  }

  // void loadUser() async {
  //   loginResponseModel = await AuthPrefsService().getUser();
  // }
}
