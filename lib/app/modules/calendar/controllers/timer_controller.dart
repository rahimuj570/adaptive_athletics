import 'dart:async';

import 'package:get/get.dart';


enum TimerStatus { running, paused, stopped, finished }

class TimerController extends GetxController {
  final int totalSeconds;
  final String label;

  TimerController({required this.totalSeconds, required this.label});

  final elapsed = 0.obs;
  final status = TimerStatus.running.obs;

  Timer? _timer;

  int get remaining => totalSeconds - elapsed.value;
  double get progress => totalSeconds == 0 ? 0.0 : elapsed.value / totalSeconds;
  int get percent => (progress * 100).round();

  bool get isRunning => status.value == TimerStatus.running;
  bool get isPaused => status.value == TimerStatus.paused;
  bool get isFinished =>
      status.value == TimerStatus.finished ||
          status.value == TimerStatus.stopped;

  @override
  void onReady() {
    super.onReady();
    _startTick();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void play() {
    if (status.value != TimerStatus.paused) return;
    status.value = TimerStatus.running;
    _startTick();
  }

  void pause() {
    if (status.value != TimerStatus.running) return;
    status.value = TimerStatus.paused;
    _timer?.cancel();
  }

  void stop() {
    _timer?.cancel();
    status.value = TimerStatus.stopped;
  }

  void restart() {
    _timer?.cancel();
    elapsed.value = 0;
    status.value = TimerStatus.running;
    _startTick();
  }

  void _startTick() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (status.value != TimerStatus.running) return;
      if (elapsed.value >= totalSeconds) {
        _timer?.cancel();
        status.value = TimerStatus.finished;
        return;
      }
      elapsed.value++;
    });
  }

  static String formatSeconds(int secs) {
    final h = secs ~/ 3600;
    final m = (secs % 3600) ~/ 60;
    final s = secs % 60;
    return '${_pad(h)}.${_pad(m)}.${_pad(s)}';
  }

  static String _pad(int v) => v.toString().padLeft(2, '0');
}