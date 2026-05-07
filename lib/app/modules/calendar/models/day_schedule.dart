import 'activity.dart';

enum WorkoutType { longRide, easyRide, tempoRide, strengthTraining, restDay }

enum WeatherType { snow, cloud, sun, storm }

class DaySchedule {
  final String dayName;
  final int dayNumber;
  final String monthLabel;
  final WeatherType weather;
  final int temperature;
  final WorkoutType workoutType;
  final String? workoutLabel;
  final String? workoutDuration;
  final Activity? activity;
  final List<Activity> activities;

  const DaySchedule({
    required this.dayName,
    required this.dayNumber,
    required this.monthLabel,
    required this.weather,
    required this.temperature,
    required this.workoutType,
    this.workoutLabel,
    this.workoutDuration,
    this.activity,
    this.activities = const [],
  });
}
