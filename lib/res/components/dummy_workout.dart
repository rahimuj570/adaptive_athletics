import '../../app/modules/calendar/models/exercise_model.dart';
import '../../app/modules/calendar/models/workout_model.dart';

class DummyWorkout {
  DummyWorkout._();

  static const WorkoutModel fullBody30 = WorkoutModel(
    id: 'full-body-30',
    badge: 'Full Body · 30 Minutes',
    title: 'Today Strength Training Workout',
    description:
        'Build total-body strength with compound movements. '
        'Engage every major muscle group and torch calories in just 30 minutes.',
    thumbnailUrl:
        'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800&q=80',
    exercises: [
      ExerciseModel(
        id: 'ex2',
        name: 'Leg Press Machine',
        duration: '10 Mins',
        durationSeconds: 600,
        sets: '3 sets · 12 reps',
        muscle: 'Quads, Hamstrings',
        youtubeId: 'IZxyjW7MPJQ',
      ),
      ExerciseModel(
        id: 'ex3',
        name: 'Cycling Lunges',
        duration: '10 Mins',
        durationSeconds: 600,
        sets: '3 sets · 10 reps each',
        muscle: 'Glutes, Quads',
        youtubeId: 'QOVaHwm-Q6U',
      ),
    ],
  );

  /// All available workouts – extend freely.
  static List<WorkoutModel> get all => [fullBody30];
}
