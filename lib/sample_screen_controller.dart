import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'sample_state.dart';
import 'dart:async';
import 'package:screen_brightness/screen_brightness.dart';
import 'test_home.dart';

class SampleScreenController extends StateNotifier<SampleScreenState>
    with WidgetsBindingObserver {
  late Timer _timer;
  SampleScreenController() : super(const SampleScreenState()) {
    WidgetsBinding.instance.addObserver(this); // アプリのライフサイクルを監視
  }

  final Stopwatch _stopwatch = Stopwatch(); // ストップウォッチのインスタンスを作成

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // アプリが前面に戻ったときにタイマーを再開
      debugPrint('resumed');
      _stopwatch.reset();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      // アプリがバックグラウンドに移動したときにタイマーを停止
      debugPrint('paused');
      _stopwatch.stop();
      _timer?.cancel();
    }
  }

  void startTimer() {
    ScreenBrightness brightness = ScreenBrightness();
    brightness.setScreenBrightness(0.2);
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      state = state.copyWith(totalDuration: _stopwatch.elapsed);
    });
    debugPrint('start');
  }

  void stopDuration() {
    _stopwatch.stop();
    _timer?.cancel();
    state = state.copyWith(totalDuration: _stopwatch.elapsed);
    debugPrint('stop');
  }

  void resetDuration() {
    _stopwatch.reset();
    _timer?.cancel();
    state = state.copyWith(totalDuration: _stopwatch.elapsed);
    debugPrint('reset');
  }
}
