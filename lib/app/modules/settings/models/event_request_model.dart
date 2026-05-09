// {
//     "name": [
//         "This field is required."
//     ],
//     "sport_type": [
//         "This field is required."
//     ],
//     "scheduled_date": [
//         "This field is required."
//     ]
// }
class EventRequestModel {
  final String name;
  final String sportType;
  final DateTime scheduledDate;
  final double distanceKm;

  EventRequestModel({
    required this.name,
    required this.sportType,
    required this.scheduledDate,
    required this.distanceKm,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'sport_type': sportType,
    'scheduled_date': scheduledDate.toString(),
    'distance_km': distanceKm,
  };
}
