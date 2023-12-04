import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'sample_state.dart';
import 'dart:async';
import 'test_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SampleScreenController extends StateNotifier<SampleScreenState>
    with WidgetsBindingObserver {
  late Timer _timer;
  bool isActive = false;
  final GlobalKey<NavigatorState> navigatorKey;
  SampleScreenController(this.navigatorKey) : super(const SampleScreenState()) {
    WidgetsBinding.instance.addObserver(this); // アプリのライフサイクルを監視
  }

  final Stopwatch _stopwatch = Stopwatch(); // ストップウォッチのインスタンスを作成

  @override
  void dispose() {
    isActive = false;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!isActive) return;
    if (state == AppLifecycleState.resumed) {
      // アプリが前面に戻ったときにタイマーを再開
      _stopwatch.reset();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      // アプリがバックグラウンドに移動したときにタイマーを停止
      saveTime(_stopwatch.elapsed.inMilliseconds);
      _stopwatch.stop();
      _timer.cancel();
      navigatorKey.currentState
          ?.pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }

  void startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      state = state.copyWith(totalDuration: _stopwatch.elapsed);
    });
  }

  void stopDuration() {
    _stopwatch.stop();
    _timer.cancel();
    state = state.copyWith(totalDuration: _stopwatch.elapsed);
  }

  void resetDuration() {
    _stopwatch.reset();
    _timer.cancel();
    state = state.copyWith(totalDuration: _stopwatch.elapsed);
  }

  Future<void> saveTime(int timeInMilliseconds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('time', timeInMilliseconds);
  }

  Future<int> getTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedTime = prefs.getInt('time');
    return savedTime ?? 0;
  }
}
