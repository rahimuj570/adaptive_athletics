import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:newproject/app/modules/plan/models/plan_response_model.dart';
import 'package:newproject/app/services/base_url/urls.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';

class PlanViewController extends GetxController {
  RxBool isFetching = true.obs;

  RxList<PlanResponseModel> plans = <PlanResponseModel>[].obs;

  Future<void> fetchPlans() async {
    isFetching.value = true;
    NetworkResponseModel responseModel = await getNetworkCaller().getCall(
      BaseUrl.getPlan,
      true,
    );
    if (responseModel.isSuccess) {
      plans.value = (responseModel.responseData['data'] as List)
          .map((e) => PlanResponseModel.fromJson(e))
          .toList();
    } else {
      Get.snackbar(
        'Error',
        responseModel.responseData['details'],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isFetching.value = false;
  }

  //wanna convert 2026-05-07T15:31:50.085572Z into Sun, Feb 8 - 2hrs
  String convertDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    String dayOfWeek = DateFormat('E').format(dateTime);
    String month = DateFormat('MMM').format(dateTime);
    String day = DateFormat('d').format(dateTime);
    String time = DateFormat('h:mm a').format(dateTime);
    return '$dayOfWeek, $month $day - $time';
  }
}
