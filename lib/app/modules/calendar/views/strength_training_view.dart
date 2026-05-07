import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/components/dummy_workout.dart';
import '../controllers/strength_training_controller.dart';
import '../models/workout_model.dart';
import 'exercise_tile.dart';

class StrengthTrainingView extends StatelessWidget {
  final WorkoutModel workout;

  const StrengthTrainingView({
    super.key,
    this.workout = DummyWorkout.fullBody30,
  });

  @override
  Widget build(BuildContext context) {
    final c = Get.put(
      StrengthTrainingController(workout: workout),
      tag: workout.id,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildHeroSliver(workout),
              SliverToBoxAdapter(child: _buildInfoSection(c, workout)),
            ],
          ),
          _backButton(),
        ],
      ),
      bottomNavigationBar: _buildStartBar(c),
    );
  }

  Widget _buildHeroSliver(WorkoutModel w) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      expandedHeight: 240.h,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(w.thumbnailUrl, fit: BoxFit.cover),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xFF0A0A0A)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
            const Center(
              child: Icon(
                Icons.play_circle_outline_rounded,
                color: Colors.white70,
                size: 72,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(StrengthTrainingController c, WorkoutModel w) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _badge(w.badge),
          SizedBox(height: 12.h),
          Text(
            w.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              height: 1.25,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            w.description,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13.sp,
              height: 1.6,
            ),
          ),
          SizedBox(height: 36.h),
          Obx(
            () => Column(
              children: List.generate(
                w.exercises.length,
                (i) => ExerciseTile(
                  exercise: w.exercises[i],
                  isExpanded: c.expandedIndex.value == i,
                  onTap: () => c.toggleExpand(i),
                  onStart: () => c.startExercise(w.exercises[i]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStartBar(StrengthTrainingController c) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: GestureDetector(
          onTap: c.startFullWorkout,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColor.buttonColor1, AppColor.defaultColor],
              ),
              borderRadius: BorderRadius.circular(50.r),
              boxShadow: [
                BoxShadow(
                  color: AppColor.buttonColor1.withAlpha(90),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Start Workout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return SafeArea(
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          margin: EdgeInsets.only(left: 12.w, top: 12.h),
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.white12),
          ),
          child: const Icon(Icons.chevron_left, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4D4D).withAlpha(38),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFFF4D4D).withAlpha(90)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFFFF4D4D),
          fontSize: 11.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
