
import 'exercise_model.dart';

class WorkoutModel {
  final String id;
  final String badge;
  final String title;
  final String description;
  final String thumbnailUrl;
  final List<ExerciseModel> exercises;

  const WorkoutModel({
    required this.id,
    required this.badge,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.exercises,
  });

  int get totalSeconds =>
      exercises.fold(0, (sum, e) => sum + e.durationSeconds);
}