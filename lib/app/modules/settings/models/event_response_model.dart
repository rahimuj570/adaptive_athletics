// {
// "id": "d978398f-aae8-403c-8e17-ec821d954870",
//             "plan": null,
//             "name": "sss",
//             "sport_type": "Cycling",
//             "scheduled_date": "2026-05-09T10:39:47.247699Z",
//             "distance_km": null,
//             "is_completed": false,
//             "created_at": "2026-05-09T04:39:50.443764Z",
//             "updated_at": "2026-05-09T04:39:50.443785Z"
// }
class EventResponseModel {
  final String id;
  final String name;
  final String? plan;
  final String sportType;
  final DateTime scheduledDate;
  final double? distanceKm;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventResponseModel({
    required this.name,
    required this.sportType,
    required this.scheduledDate,
    required this.id,
    required this.plan,
    required this.distanceKm,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventResponseModel.fromJson(Map<String, dynamic> json) {
    return EventResponseModel(
      id: json['id'],
      name: json['name'],
      plan: json['plan'],
      sportType: json['sport_type'],
      scheduledDate: DateTime.parse(json['scheduled_date']),
      distanceKm: json['distance_km'],
      isCompleted: json['is_completed'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
