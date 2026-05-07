
class ExerciseModel {
  final String id;
  final String name;
  final String duration;
  final int durationSeconds;
  final String sets;
  final String muscle;
  final String youtubeId;

  const ExerciseModel({
    required this.id,
    required this.name,
    required this.duration,
    required this.durationSeconds,
    required this.sets,
    required this.muscle,
    required this.youtubeId,
  });
}