
import 'package:get/get.dart';

import '../models/exercise_model.dart';
import '../models/workout_model.dart';
import '../views/timer_view.dart';

class StrengthTrainingController extends GetxController {
  final WorkoutModel workout;
  StrengthTrainingController({required this.workout});

  final expandedIndex = (-1).obs;

  void toggleExpand(int index) {
    expandedIndex.value = (expandedIndex.value == index) ? -1 : index;
  }

  void startExercise(ExerciseModel exercise) {
    Get.to(
          () =>
          TimerView(exercise: exercise, totalSeconds: exercise.durationSeconds),
    );
  }

  void startFullWorkout() {
    Get.to(
          () => TimerView(
        exercise: null,
        totalSeconds: workout.totalSeconds,
        workoutTitle: workout.title,
      ),
    );
  }
}