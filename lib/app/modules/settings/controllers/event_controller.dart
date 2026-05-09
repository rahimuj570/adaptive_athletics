import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newproject/app/modules/settings/models/event_request_model.dart';
import 'package:newproject/app/services/base_url/urls.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';
import 'package:newproject/res/colors/app_color.dart';

class EventController extends GetxController {
  RxBool isLoading = false.obs;
  final List<String> sports = [
    'Cycling',
    'Running',
    'Swimming',
    'Triathlon',
    'Marathon',
    'Walking',
  ];

  final List<String> distances = [
    '1.0',
    '5.0',
    '10.0',
    '21.1',
    '42.2',
    '50.0',
    '100.0',
  ].obs;
  final RxList<EventRequestModel> events = <EventRequestModel>[].obs;
  final RxString selectedSport = 'Cycling'.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString selectedDistance = '1.0'.obs;
  final TextEditingController eventNameController = TextEditingController();
  void setSport(String sport) => selectedSport.value = sport;

  void setDate(DateTime date) => selectedDate.value = date;

  void setDistance(double km) => selectedDistance.value = km.toString();

  Future<void> addEvent() async {
    isLoading.value = true;
    final name = eventNameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar(
        'Missing Info',
        'Please enter an event name.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF1C2C3E),
        colorText: AppColor.whiteColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
      );
      return;
    }

    final event = EventRequestModel(
      name: name,
      sportType: selectedSport.value,
      scheduledDate: selectedDate.value,
    );

    NetworkResponseModel responseModel = await getNetworkCaller().postCall(
      BaseUrl.postEvent,
      event.toJson(),
      true,
    );

    if (responseModel.isSuccess) {
      Get.snackbar(
        'Event Added',
        '"${event.name}" has been saved!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.linearColor,
        colorText: AppColor.whiteColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
      );
      Navigator.pop(Get.context!);
    } else {
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.linearColor,
        colorText: AppColor.whiteColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 10,
      );
    }

    eventNameController.clear();
    selectedSport.value = 'Cycling';
    selectedDate.value = DateTime.now();
    selectedDistance.value = '1.0';

    isLoading.value = false;
  }

  String formattedSelectedDate() {
    final d = selectedDate.value;
    final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
    final minute = d.minute.toString().padLeft(2, '0');
    final ampm = d.hour >= 12 ? 'PM' : 'AM';
    final isToday = _isToday(d);
    if (isToday) return 'Today at $hour:$minute $ampm';
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} $hour:$minute $ampm';
  }

  bool _isToday(DateTime d) {
    final now = DateTime.now();
    return d.year == now.year && d.month == now.month && d.day == now.day;
  }
}
