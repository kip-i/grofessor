import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'sample_state.dart';
import 'dart:async';
import '../home/home_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class SampleScreenController extends StateNotifier<SampleScreenState>
    with WidgetsBindingObserver {
  late Timer _timer;
  bool isActive = false;
  bool resultFlag = false;
  final GlobalKey<NavigatorState> navigatorKey;
  SampleScreenController(this.navigatorKey) : super(const SampleScreenState()) {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addObserver(this); // アプリのライフサイクルを監視
  }

  final Stopwatch _stopwatch = Stopwatch(); // ストップウォッチのインスタンスを作成

  @override
  void dispose() {
    isActive = false;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!isActive) return;
    if (state == AppLifecycleState.resumed) {
      // アプリが前面に戻ったときにタイマーを再開
      _stopwatch.reset();
      resultFlag = await getNavigationToResult();
      // リザルト画面に遷移するかどうかを判定
      if (resultFlag) {
        navigatorKey.currentState
            ?.pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      print('アプリがバックグラウンドに移動しました');
      // アプリがバックグラウンドに移動したときにタイマーを停止
      // saveTime(_stopwatch.elapsed.inMilliseconds);
      saveTime(_stopwatch.elapsed.inSeconds);
      setNavigationToResult();
      _stopwatch.stop();
      _timer.cancel();
    }
  }

  void startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      state = state.copyWith(totalDuration: _stopwatch.elapsed);
    });
  }

  void stopDuration(int seconds) {
    debugPrint('stopDuration: $seconds');
    saveTime(seconds);
    setNavigationToResult();
    _stopwatch.stop();
    _timer.cancel();
    state = state.copyWith(totalDuration: _stopwatch.elapsed);
    navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (context) => MyApp()));
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

  Future<void> setNavigationToResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? time = await getTime();
    if (time > 0) {
      print('あああああああああああああああああ: $time');
      prefs.setBool('isSetNavigationToResult', true);
    } else {
      prefs.setBool('isSetNavigationToResult', false);
    }
  }

  Future<bool> getNavigationToResult() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSetNavigationToResult = prefs.getBool('isSetNavigationToResult');
    return isSetNavigationToResult ?? false;
  }
}
