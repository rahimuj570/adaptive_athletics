import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:get/get.dart';

class ExerciseTileController extends GetxController {
  final String youtubeId;
  YoutubePlayerController? ytController;

  ExerciseTileController({required this.youtubeId});

  void onExpansionChanged(bool isExpanded) {
    if (isExpanded && ytController == null) {
      ytController = YoutubePlayerController(
        initialVideoId: youtubeId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
      update();
    } else if (!isExpanded && ytController != null) {
      ytController!.pause();
    }
  }

  @override
  void onClose() {
    ytController?.dispose();
    super.onClose();
  }
}
