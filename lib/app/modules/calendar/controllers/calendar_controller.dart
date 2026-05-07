import 'package:get/get.dart';

import '../../../../res/components/dummy_backend.dart';
import '../models/activity.dart';
import '../models/day_schedule.dart';

class CalendarController extends GetxController {
  final RxInt weekOffset = 0.obs;
  final RxList<DaySchedule> weekSchedule = <DaySchedule>[].obs;
  final RxBool isLoading = false.obs;
  final RxnInt selectedDayIndex = RxnInt(null);
  final RxInt selectedNavIndex = 1.obs;

  String get weekRange {
    if (weekSchedule.isEmpty) return '';
    final first = weekSchedule.first;
    final last = weekSchedule.last;
    if (first.monthLabel == last.monthLabel) {
      return '${first.monthLabel} ${first.dayNumber} - ${last.dayNumber}';
    }
    return '${first.monthLabel} ${first.dayNumber} - ${last.monthLabel} ${last.dayNumber}';
  }

  Activity? get selectedActivity {
    final idx = selectedDayIndex.value;
    if (idx == null || weekSchedule.isEmpty) return _firstActivity;
    return weekSchedule[idx].activity ?? _firstActivity;
  }

  Activity? get _firstActivity {
    for (final d in weekSchedule) {
      if (d.activity != null) return d.activity;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    _fetchWeek();
  }

  void previousWeek() {
    weekOffset.value -= 1;
    selectedDayIndex.value = null;
    _fetchWeek();
  }

  void nextWeek() {
    weekOffset.value += 1;
    selectedDayIndex.value = null;
    _fetchWeek();
  }

  void selectDay(int index) {
    selectedDayIndex.value = index;
  }

  void setNavIndex(int index) => selectedNavIndex.value = index;

  Future<void> _fetchWeek() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 400));
    weekSchedule.assignAll(DummyBackend.fetchWeek(weekOffset.value));
    isLoading.value = false;
  }
}
