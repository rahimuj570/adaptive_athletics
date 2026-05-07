import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newproject/res/assets/image_assets.dart';
import 'package:newproject/widgets/background.dart';

import '../../../../res/colors/app_color.dart';
import '../controllers/timer_controller.dart';
import '../models/exercise_model.dart';

class TimerView extends StatelessWidget {
  final ExerciseModel? exercise;
  final int totalSeconds;
  final String? workoutTitle;

  const TimerView({
    super.key,
    this.exercise,
    this.totalSeconds = 1800,
    this.workoutTitle,
  });

  String get _label => exercise?.name ?? workoutTitle ?? 'Full Workout';

  String get _muscle => exercise?.muscle ?? 'Full Body';

  @override
  Widget build(BuildContext context) {
    final c = Get.put(
      TimerController(totalSeconds: totalSeconds, label: _label),
      tag: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Background(
          image: ImageAssets.ss,
          child: Obx(() {
            if (c.isFinished) return _FinishedScreen(c: c);

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.w, 70.h, 20.w, 24.h),
                  child: Column(
                    children: [
                      _headerInfo(_label, _muscle, c),
                      SizedBox(height: 36.h),

                      _CircularTimer(c: c, size: 220.r),
                      SizedBox(height: 32.h),

                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          TimerController.formatSeconds(totalSeconds),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Elapsed Time',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFF1F1F1),
                          fontSize: 16.sp,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 28.h),

                      _ProgressSection(c: c),
                      SizedBox(height: 36.h),

                      _Controls(c: c),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    margin: EdgeInsets.only(left: 12.w, top: 8.h),
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _headerInfo(String label, String muscle, TimerController c) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                muscle,
                style: TextStyle(color: Colors.white38, fontSize: 13.sp),
              ),
            ],
          ),
        ),
        Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: c.isRunning
                  ? const Color(0xFFFF4D4D).withAlpha(38)
                  : Colors.white.withAlpha(22),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: c.isRunning
                    ? const Color(0xFFFF4D4D).withAlpha(113)
                    : Colors.white24,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (c.isRunning)
                  _PulsingDot()
                else
                  Icon(Icons.pause_rounded, color: Colors.white54, size: 12.r),
                SizedBox(width: 6.w),
                Text(
                  c.isRunning ? 'LIVE' : 'PAUSED',
                  style: TextStyle(
                    color: c.isRunning
                        ? const Color(0xFFFF4D4D)
                        : Colors.white38,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat(reverse: true);
  late final Animation<double> _alpha = Tween(
    begin: 0.4,
    end: 1.0,
  ).animate(_ac);

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _alpha,
      child: Container(
        width: 8.r,
        height: 8.r,
        decoration: const BoxDecoration(
          color: Color(0xFFFF4D4D),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _CircularTimer extends StatelessWidget {
  final TimerController c;
  final double size;
  const _CircularTimer({required this.c, required this.size});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(size, size),
              painter: _ArcPainter(progress: c.progress),
            ),

            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TimerController.formatSeconds(c.remaining),
                  style: TextStyle(
                    color: c.isRunning ? Colors.white : Colors.white54,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    height: 1,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'REMAINING',
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 10.sp,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.defaultColor.withAlpha(38),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '${c.percent}% Done',
                    style: TextStyle(
                      color: AppColor.defaultColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  _ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final radius = (size.width - 16) / 2;
    const strokeW = 10.0;

    final bgPaint = Paint()
      ..color = Colors.white.withAlpha(17)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW;

    canvas.drawCircle(Offset(cx, cy), radius, bgPaint);

    final shader = const LinearGradient(
      colors: [AppColor.buttonColor1, AppColor.defaultColor],
    ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: radius));

    final arcPaint = Paint()
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeW
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter old) => old.progress != progress;
}

class _ProgressSection extends StatelessWidget {
  final TimerController c;
  const _ProgressSection({required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.h,
                children: [
                  Text(
                    'Session Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${c.percent}% Complete',
                    style: TextStyle(
                      color: AppColor.text2Color,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Text(
                '${TimerController.formatSeconds(c.remaining)} left',
                style: TextStyle(color: Colors.white38, fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: c.progress),
              duration: const Duration(milliseconds: 800),
              builder: (_, val, __) => LinearProgressIndicator(
                value: val,
                minHeight: 8.h,
                backgroundColor: Colors.white10,
                valueColor: const AlwaysStoppedAnimation(Color(0xFFFF4D4D)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  final TimerController c;
  const _Controls({required this.c});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: c.isRunning ? c.pause : c.play,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(vertical: 18.h),
                decoration: BoxDecoration(
                  gradient: c.isRunning
                      ? null
                      : const LinearGradient(
                          colors: [Color(0xFFFF4D4D), Color(0xFFFF8C00)],
                        ),
                  color: c.isRunning ? const Color(0xFF1E1E1E) : null,
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(
                    color: c.isRunning ? Colors.white24 : Colors.transparent,
                  ),
                  boxShadow: c.isPaused
                      ? [
                          BoxShadow(
                            color: const Color(0xFFFF4D4D).withAlpha(90),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      c.isRunning
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 22.r,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      c.isRunning ? 'Pause' : 'Resume',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          GestureDetector(
            onTap: () {
              Get.dialog(_StopConfirmDialog(onConfirm: c.stop));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 18.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFF4D4D).withAlpha(32),
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(
                  color: const Color(0xFFFF4D4D).withAlpha(108),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.stop_rounded,
                    color: const Color(0xFFFF4D4D),
                    size: 22.r,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Stop',
                    style: TextStyle(
                      color: const Color(0xFFFF4D4D),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StopConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const _StopConfirmDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF161616),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.stop_circle_outlined,
              color: const Color(0xFFFF4D4D),
              size: 48.r,
            ),
            SizedBox(height: 16.h),
            Text(
              'Stop Workout?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your current progress will be saved but the timer will stop.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 13.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      onConfirm();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4D4D),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Center(
                        child: Text(
                          'Stop',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FinishedScreen extends StatelessWidget {
  final TimerController c;
  const _FinishedScreen({required this.c});

  @override
  Widget build(BuildContext context) {
    final wasStopped = c.status.value == TimerStatus.stopped;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              wasStopped ? '🛑' : '🏆',
              style: const TextStyle(fontSize: 72),
            ),
            SizedBox(height: 20.h),
            Text(
              wasStopped ? 'Workout Stopped' : 'Workout Complete!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Duration: ${TimerController.formatSeconds(c.elapsed.value)}',
              style: TextStyle(color: Colors.white54, fontSize: 15.sp),
            ),
            SizedBox(height: 6.h),
            Text(
              '${c.percent}% complete',
              style: TextStyle(
                color: const Color(0xFFFF8C00),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 40.h),

            SizedBox(
              width: 160.r,
              height: 160.r,
              child: CustomPaint(
                painter: _ArcPainter(progress: c.progress),
                child: Center(
                  child: Text(
                    '${c.percent}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 48.h),

            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 18.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColor.buttonColor1, AppColor.defaultColor],
                  ),
                  borderRadius: BorderRadius.circular(50.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF4D4D).withAlpha(90),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Text(
                  '← Back to Workouts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
