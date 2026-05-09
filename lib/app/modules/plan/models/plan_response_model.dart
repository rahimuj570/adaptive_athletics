// "id": "490c72cd-ed94-4c5b-874a-029c494ddb84",
//             "name": "My Training Plan",
//             "timezone": "America/New_York",
//             "start_date": "2026-05-07T15:31:50.085572Z",
//             "ftp": 1232,
//             "power_zones": [],
//             "sessions": [],
//             "created_at": "2026-05-07T09:31:52.377320Z",
//             "updated_at": "2026-05-07T09:31:52.377327Z"
class PlanResponseModel {
  final String id;
  final String name;
  final String timezone;
  final DateTime startDate;
  final int ftp;
  final List<dynamic> powerZones;
  final List<dynamic> sessions;
  final DateTime createdAt;
  final DateTime updatedAt;

  PlanResponseModel({
    required this.id,
    required this.name,
    required this.timezone,
    required this.startDate,
    required this.ftp,
    required this.powerZones,
    required this.sessions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PlanResponseModel.fromJson(Map<String, dynamic> json) {
    return PlanResponseModel(
      id: json['id'],
      name: json['name'],
      timezone: json['timezone'],
      startDate: DateTime.parse(json['start_date']),
      ftp: json['ftp'],
      powerZones: json['power_zones'],
      sessions: json['sessions'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
