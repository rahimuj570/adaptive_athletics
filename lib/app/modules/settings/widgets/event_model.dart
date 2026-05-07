import 'dart:convert';

class EventModel {
  final String id;
  final String sport;
  final String eventName;
  final DateTime date;
  final double distanceKm;

  EventModel({
    required this.id,
    required this.sport,
    required this.eventName,
    required this.date,
    required this.distanceKm,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'sport': sport,
    'eventName': eventName,
    'date': date.toIso8601String(),
    'distanceKm': distanceKm,
  };

  factory EventModel.fromMap(Map<String, dynamic> map) => EventModel(
    id: map['id'],
    sport: map['sport'],
    eventName: map['eventName'],
    date: DateTime.parse(map['date']),
    distanceKm: (map['distanceKm'] as num).toDouble(),
  );

  String toJson() => jsonEncode(toMap());
  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(jsonDecode(source));

  String get formattedDate {
    final d = date;
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}
