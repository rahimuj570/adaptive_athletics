import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/auth/controllers/user_controller.dart';
import 'package:newproject/app/modules/auth/models/login_response_model.dart';
import 'package:newproject/app/services/base_url/urls.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RxString base64Image = ''.obs;

  @override
  void onInit() async {
    UserController userController = Get.put(UserController());
    Rxn<LoginResponseModel> user = userController.user;
    fullNameController.text = user.value!.firstName;
    addressController.text = user.value!.address1 ?? '';
    phoneController.text = user.value!.phone1 ?? '';
    base64Image.value = user.value!.image ?? '';
    super.onInit();
  }

  Future<void> updateUser() async {
    //     {
    //   "email": "user@example.com",
    //   "first_name": "string",
    //   "last_name": "string",
    //   "image": "string",
    //   "address1": "string",
    //   "phone1": "string"
    // }
    isLoading.value = true;
    NetworkResponseModel responseModel = await getNetworkCaller()
        .patchCall(BaseUrl.updateUser, {
          "first_name": fullNameController.text,
          "address1": addressController.text,
          "phone1": phoneController.text,
          "image": 'data:image/png;base64,${base64Image.value}',
        }, true);

    if (responseModel.isSuccess) {
      Get.showSnackbar(
        GetSnackBar(
          title: 'Success',
          message: 'Profile updated successfully',
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
      Get.back();
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
    isLoading.value = false;
  }
}
