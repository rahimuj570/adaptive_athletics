import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/models/login_response_model.dart';
import 'package:newproject/app/modules/auth/services/auth_prefs_service.dart';
import 'package:newproject/app/services/base_url/urls.dart';
import 'package:newproject/app/setup_network_caller.dart';

class UserController extends GetxController {
  var user = Rxn<LoginResponseModel>();

  Future<void> getUser() async {
    debugPrint('Token: ${await AuthPrefsService().getToken()}');

    final responseModel = await getNetworkCaller().getCall(
      BaseUrl.getUser,
      true,
    );

    if (responseModel.isSuccess) {
      user.value = LoginResponseModel.fromJson(
        responseModel.responseData['data'],
      );
    }
  }

  Future<void> updateUser() async {
    //
  }
}
