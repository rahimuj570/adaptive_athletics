import 'package:newproject/app/modules/calendar/models2/weather_response_model.dart';
import 'package:newproject/app/modules/settings/models/event_response_model.dart';

class CalendarModel {
  final String date;
  final List<EventResponseModel> events;
  final List<dynamic> sessions; // define later if sessions have structure
  final int workoutCount;
  final WeatherModel? weather;

  CalendarModel({
    required this.date,
    required this.events,
    required this.sessions,
    required this.workoutCount,
    this.weather,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      date: json['date'] ?? '',
      events: (json['events'] as List)
          .map((e) => EventResponseModel.fromJson(e))
          .toList(),
      sessions: json['sessions'] ?? [],
      workoutCount: json['workout_count'] ?? 0,
      weather: json['weather'] != null
          ? WeatherModel.fromJson(json['weather'])
          : null,
    );
  }
}

enum WorkoutType { longRide, easyRide, tempoRide, strengthTraining, restDay }

enum WeatherType { snow, cloud, sun, storm }
