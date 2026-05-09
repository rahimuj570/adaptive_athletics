class EventResponseModel {
  final String id;
  final String name;
  final String? plan;
  final String? sportType;
  final DateTime scheduledDate;
  final double? distanceKm;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventResponseModel({
    required this.id,
    required this.name,
    this.plan,
    this.sportType,
    required this.scheduledDate,
    this.distanceKm,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventResponseModel.fromJson(Map<String, dynamic> json) {
    return EventResponseModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      plan: json['plan'],
      sportType: json['sport_type'],
      scheduledDate: DateTime.parse(json['scheduled_date']),
      distanceKm: json['distance_km'] != null
          ? (json['distance_km'] as num).toDouble()
          : null,
      isCompleted: json['is_completed'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
