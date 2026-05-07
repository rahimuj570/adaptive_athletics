import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newproject/app/services/base_url/urls.dart';
import 'package:newproject/app/services/network_response_model.dart';
import 'package:newproject/app/setup_network_caller.dart';

class PlanController extends GetxController {
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController ftpController = TextEditingController();

  var planList = <Map<String, String>>[].obs;

  RxBool myFtp = false.obs;
  RxBool ftpTest = false.obs;
  RxBool heartRate = false.obs;
  RxBool powerMeter = false.obs;

  var hoursPerWeek = 10.0.obs;
  void updateHoursPerWeek(double val) => hoursPerWeek.value = val;

  var sleep = 10.0.obs;
  void updateSleep(double val) => sleep.value = val;

  var energy = 10.0.obs;
  void updateEnergy(double val) => energy.value = val;

  var soreness = 10.0.obs;
  void updateSoreness(double val) => soreness.value = val;

  var mood = 10.0.obs;
  void updateMood(double val) => mood.value = val;

  RxnDouble weight = RxnDouble();
  void updateWeight(double val) => mood.value = val;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    planList.assignAll([
      // {
      //   'title': 'Endurance Ride',
      //   'subtitle': 'Steady pace for 2 hours to build base fitness.',
      // },
      // {
      //   'title': 'High Intensity Intervals',
      //   'subtitle': 'Short bursts of maximum effort with active recovery.',
      // },
      // {
      //   'title': 'Recovery Session',
      //   'subtitle': 'Light spinning to flush out the legs.',
      // },
      // {
      //   'title': 'Endurance Ride',
      //   'subtitle': 'Steady pace for 2 hours to build base fitness.',
      // },
      // {
      //   'title': 'High Intensity Intervals',
      //   'subtitle': 'Short bursts of maximum effort with active recovery.',
      // },
      // {
      //   'title': 'Recovery Session',
      //   'subtitle': 'Light spinning to flush out the legs.',
      // },
      // {
      //   'title': 'Endurance Ride',
      //   'subtitle': 'Steady pace for 2 hours to build base fitness.',
      // },
      // {
      //   'title': 'High Intensity Intervals',
      //   'subtitle': 'Short bursts of maximum effort with active recovery.',
      // },
      // {
      //   'title': 'Recovery Session',
      //   'subtitle': 'Light spinning to flush out the legs.',
      // },
      // {
      //   'title': 'Endurance Ride',
      //   'subtitle': 'Steady pace for 2 hours to build base fitness.',
      // },
      // {
      //   'title': 'High Intensity Intervals',
      //   'subtitle': 'Short bursts of maximum effort with active recovery.',
      // },
      // {
      //   'title': 'Recovery Session',
      //   'subtitle': 'Light spinning to flush out the legs.',
      // },
      // {
      //   'title': 'Endurance Ride',
      //   'subtitle': 'Steady pace for 2 hours to build base fitness.',
      // },
      // {
      //   'title': 'High Intensity Intervals',
      //   'subtitle': 'Short bursts of maximum effort with active recovery.',
      // },
      // {
      //   'title': 'Recovery Session',
      //   'subtitle': 'Light spinning to flush out the legs.',
      // },
    ]);
  }

  final RxString sport = ''.obs;
  final List<String> sports = <String>[
    'Cycling',
    'Running',
    'Swimming',
    'Yoga',
    'Strength Training',
  ].obs;
  final RxString startTime = '5:00 AM'.obs;
  final RxString endTime = '5:00 AM'.obs;
  final List<String> times = <String>[
    '12:00 AM',
    '12:30 AM',
    '1:00 AM',
    '1:30 AM',
    '2:00 AM',
    '2:30 AM',
    '3:00 AM',
    '3:30 AM',
    '4:00 AM',
    '4:30 AM',
    '5:00 AM',
    '5:30 AM',
    '6:00 AM',
    '6:30 AM',
    '7:00 AM',
    '7:30 AM',
    '8:00 AM',
    '8:30 AM',
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM',
    '4:30 PM',
    '5:00 PM',
    '5:30 PM',
    '6:00 PM',
    '6:30 PM',
    '7:00 PM',
    '7:30 PM',
    '8:00 PM',
    '8:30 PM',
    '9:00 PM',
    '9:30 PM',
    '10:00 PM',
    '10:30 PM',
    '11:00 PM',
    '11:30 PM',
  ].obs;
  final RxString level = ''.obs;
  final List<String> levels = <String>[
    'Intermediate',
    'Beginner',
    'Advanced',
  ].obs;

  final RxString strength = ''.obs;
  final List<String> strengts = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    // '7',
    // '8',
    // '9',
    // '10',
  ].obs;

  var blockedCells = <int>{}.obs;

  void toggleCell(int index) {
    if (blockedCells.contains(index)) {
      blockedCells.remove(index);
    } else {
      blockedCells.add(index);
    }
  }

  String get availableHours => "${168 - blockedCells.length}h available";

  Map<String, dynamic> buildRequestBody(PlanController controller) {
    return {
      "name": "My Training Plan",
      "timezone": "America/New_York",
      "start_date": DateTime.now().toString(),

      // Screen 1: Plan Details
      "zip_code": controller.zipCodeController.text.trim(),
      "sport": controller.sport.value,
      "strength_activities": int.tryParse(controller.strength.value) ?? 0,
      "hours_per_week": controller.hoursPerWeek.value.toInt(),
      "training_window": {
        "earliest_start": controller.startTime.value,
        "latest_start": controller.endTime.value,
      },
      "level": controller.level.value,
      "has_heart_rate_monitor": controller.heartRate.value,
      "has_power_meter": controller.powerMeter.value,
      "ftp": int.tryParse(controller.ftpController.text.trim()) ?? 0,
      "knows_ftp": controller.myFtp.value,
      "is_ftp_test": controller.ftpTest.value,
      "time_blocks": controller.blockedCells.toList(),

      // Screen 2: Weekly Check-In
      "check_in": {
        "sleep": controller.sleep.value.toInt(),
        "energy": controller.energy.value.toInt(),
        "soreness": controller.soreness.value.toInt(),
        "mood": controller.mood.value.toInt(),
        "weight": controller.weight.value ?? 0,
      },

      // Sessions (Optional: Can be an empty list)
      "sessions": [],
    };
  }

  Future<bool> savePlan() async {
    final requestBody = buildRequestBody(this);
    // print('Request Body: $requestBody');
    NetworkResponseModel responseModel = await getNetworkCaller().postCall(
      BaseUrl.postPlan,
      requestBody,
      true,
    );
    return responseModel.isSuccess;
  }

  void debugPrintState() {
    print("===== PlanController State =====");
    print("ZipCode: ${zipCodeController.text}");
    print("FTP: ${ftpController.text}");
    print("PlanList: $planList");
    print("myFtp: ${myFtp.value}");
    print("ftpTest: ${ftpTest.value}");
    print("heartRate: ${heartRate.value}");
    print("powerMeter: ${powerMeter.value}");
    print("hoursPerWeek: ${hoursPerWeek.value}");
    print("sleep: ${sleep.value}");
    print("energy: ${energy.value}");
    print("soreness: ${soreness.value}");
    print("mood: ${mood.value}");
    print("weight: ${weight.value}");
    print("sport: ${sport.value}");
    print("startTime: ${startTime.value}");
    print("endTime: ${endTime.value}");
    print("level: ${level.value}");
    print("strength: ${strength.value}");
    print("blockedCells: ${blockedCells}");
    print("AvailableHours: $availableHours");
    print("================================");
  }
}
