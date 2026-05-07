import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../res/colors/app_color.dart' show AppColor;
import '../widgets/event_model.dart';

class SettingsController extends GetxController {
  var miniTemp = 22.0.obs;
  var maxTemp = 24.0.obs;
  var rain = 45.0.obs;
  var wind = 45.0.obs;

  void updateMiniTemp(double val) => miniTemp.value = val;
  void updateMaxTemp(double val) => maxTemp.value = val;
  void updateRain(double val) => rain.value = val;
  void updateWind(double val) => wind.value = val;

  RxBool isCelsius = false.obs;
  RxBool isUnits = false.obs;
  RxBool isClock = false.obs;

  var isDaylightOnly = true.obs;

  void toggleDaylight(bool value) {
    isDaylightOnly.value = value;
  }

  var alert = true.obs;

  void toggleAlert(bool value) {
    alert.value = value;
  }

  var reminder = true.obs;

  void toggleReminder(bool value) {
    reminder.value = value;
  }

  var sync = true.obs;

  void toggleSync(bool value) {
    sync.value = value;
  }

  var adaptation = true.obs;

  void toggleAdaptation(bool value) {
    adaptation.value = value;
  }

  static const _storageKey = 'event_planning_events';
  final RxList<EventModel> events = <EventModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString selectedSport = 'Cycling'.obs;
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString selectedDistance = '1.0'.obs;
  final TextEditingController eventNameController = TextEditingController();

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

  @override
  void onInit() {
    super.onInit();
    _loadEvents();
  }

  @override
  void onClose() {
    eventNameController.dispose();
    super.onClose();
  }

  void setSport(String sport) => selectedSport.value = sport;

  void setDate(DateTime date) => selectedDate.value = date;

  void setDistance(double km) => selectedDistance.value = km.toString();

  Future<void> addEvent() async {
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

    final event = EventModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sport: selectedSport.value,
      eventName: name,
      date: selectedDate.value,
      distanceKm: double.parse(selectedDistance.value),
    );

    events.add(event);
    await _persist();

    eventNameController.clear();
    selectedSport.value = 'Cycling';
    selectedDate.value = DateTime.now();
    selectedDistance.value = '1.0';

    Navigator.pop(Get.context!);
    Get.snackbar(
      'Event Added',
      '"${event.eventName}" has been saved!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColor.linearColor,
      colorText: AppColor.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
    );
  }

  Future<void> deleteEvent(String id) async {
    events.removeWhere((e) => e.id == id);
    await _persist();
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

  Future<void> _loadEvents() async {
    isLoading.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList(_storageKey);
      if (raw != null && raw.isNotEmpty) {
        events.assignAll(raw.map((e) => EventModel.fromJson(e)).toList());
      } else {
        events.assignAll(_dummyEvents);
        await _persist();
      }
    } catch (_) {
      events.assignAll(_dummyEvents);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        _storageKey,
        events.map((e) => e.toJson()).toList(),
      );
    } catch (_) {}
  }

  static final List<EventModel> _dummyEvents = [
    EventModel(
      id: '1',
      sport: 'Running',
      eventName: 'Marathon',
      date: DateTime(2026, 6, 15),
      distanceKm: 42.2,
    ),
    EventModel(
      id: '2',
      sport: 'Cycling',
      eventName: 'Tour de City',
      date: DateTime(2026, 4, 20),
      distanceKm: 100.0,
    ),
    EventModel(
      id: '3',
      sport: 'Swimming',
      eventName: 'Open Water Race',
      date: DateTime(2026, 7, 5),
      distanceKm: 5.0,
    ),
    EventModel(
      id: '4',
      sport: 'Triathlon',
      eventName: 'Iron Man',
      date: DateTime(2026, 9, 12),
      distanceKm: 50.0,
    ),
  ];
}
