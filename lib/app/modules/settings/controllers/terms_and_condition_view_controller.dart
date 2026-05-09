import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:newproject/app/services/base_url/urls.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';

class TermsAndConditionViewController extends GetxController {
  RxString privacyContent = "".obs;
  RxBool isLoading = true.obs;

  Future<void> fetchTerms() async {
    isLoading = true.obs;
    NetworkResponseModel responseModel = await getNetworkCaller().getCall(
      BaseUrl.getTerms,
      true,
    );
    if (responseModel.isSuccess) {
      privacyContent.value = responseModel.responseData['data']['content'];
      debugPrint(responseModel.responseData['data']['content']);
    } else {
      privacyContent.value = "";
      Get.showSnackbar(
        GetSnackBar(
          title: "Error",
          message: 'Failed to fetch terms and conditions',
          backgroundColor: Colors.red,
        ),
      );
    }
    isLoading = false.obs;
  }
}
