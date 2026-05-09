import 'package:newproject/app/modules/calendar/models2/calendar_model.dart';

class CalendarResponseModel {
  final String today;
  final int daysCount;
  final String city;
  final List<CalendarModel> calendar;
  final int totalWorkoutCount;
  final List<dynamic> comingUpStrength;

  CalendarResponseModel({
    required this.today,
    required this.daysCount,
    required this.city,
    required this.calendar,
    required this.totalWorkoutCount,
    required this.comingUpStrength,
  });

  factory CalendarResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return CalendarResponseModel(
      today: data['today'] ?? '',
      daysCount: data['days_count'] ?? 0,
      city: data['city'] ?? '',
      calendar: (data['calendar'] as List)
          .map((c) => CalendarModel.fromJson(c))
          .toList(),
      totalWorkoutCount: data['total_workout_count'] ?? 0,
      comingUpStrength: data['coming_up_strength'] ?? [],
    );
  }
}
