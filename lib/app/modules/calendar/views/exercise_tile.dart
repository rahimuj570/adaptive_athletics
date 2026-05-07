import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../res/assets/image_assets.dart';
import '../../../../res/colors/app_color.dart';
import '../controllers/exercise_tile_controller.dart';
import '../models/exercise_model.dart';

class ExerciseTile extends StatelessWidget {
  final ExerciseModel exercise;
  final bool isExpanded;
  final VoidCallback onTap;
  final VoidCallback onStart;

  const ExerciseTile({
    super.key,
    required this.exercise,
    required this.isExpanded,
    required this.onTap,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseTileController>(
      init: ExerciseTileController(youtubeId: exercise.youtubeId),
      tag: exercise.id.toString(),
      didUpdateWidget: (oldWidget, state) {
        state.controller?.onExpansionChanged(isExpanded);
      },
      builder: (controller) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF161616),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isExpanded
                  ? const Color(0xFFFF4D4D).withAlpha(108)
                  : Colors.white.withAlpha(17),
            ),
          ),
          child: Column(
            children: [
              _buildHeader(),
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: const SizedBox.shrink(),
                secondChild: _buildExpandedContent(controller),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            Container(
              width: 44.r,
              height: 44.r,
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: const Color(0xFFFF4D4D).withAlpha(32),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFFF4D4D).withAlpha(67),
                ),
              ),
              child: SvgPicture.asset(ImageAssets.muscle),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '${exercise.duration} · ${exercise.sets}',
                    style: TextStyle(color: Colors.white38, fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            _buildPlayIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayIcon() {
    return Container(
      width: 36.r,
      height: 36.r,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(38),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(ImageAssets.play),
    );
  }

  Widget _buildExpandedContent(ExerciseTileController controller) {
    return Padding(
      padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.adjust_rounded,
                color: Color(0xFFFF4D4D),
                size: 14,
              ),
              SizedBox(width: 6.w),
              Text(
                'Targets: ${exercise.muscle}',
                style: TextStyle(
                  color: const Color(0xFFFF4D4D),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          if (controller.ytController != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: YoutubePlayer(
                controller: controller.ytController!,
                showVideoProgressIndicator: true,
                progressIndicatorColor: const Color(0xFFFF4D4D),
              ),
            ),

          SizedBox(height: 12.h),
          _buildStartButton(),
        ],
      ),
    );
  }

  Widget _buildStartButton() {
    return GestureDetector(
      onTap: onStart,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColor.buttonColor1, AppColor.defaultColor],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
            SizedBox(width: 8.w),
            Text(
              'Start This Exercise',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
