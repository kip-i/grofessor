import 'package:flutter/material.dart';
import 'package:grofessor/home/home_state.dart';
import 'package:grofessor/test_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:provider/provider.dart';


import 'home_default.dart';
import 'home_during_time.dart';
import '../_state.dart';

class HomeSelector extends StatefulWidget {
  const HomeSelector({Key? key});

  @override
  State<HomeSelector> createState() => _HomeSelector();
}

class _HomeSelector extends State<HomeSelector> {
  var _timer;

  // @override
  // void initState() {
  //   super.initState();
  //   _timer = Timer.periodic(
  //     Duration(minutes: 1), (Timer timer) {
  //       DateTime now = DateTime.now();

  //       String hour = now.hour.toString();
  //       String minute = now.minute.toString();

  //       // 指定した時間になったら処理を実行
  //       if (now.hour == classProvider.classTimeList[0][0] && now.minute == 0) {
  //         print('指定した時間になりました！');
  //         // ここに特定の処理を追加
  //       }
  //     }
  //   );
  // }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final homeProvider = Provider.of<HomeProvider>(context);
    // homeProvider.getDuring();
    final classProvider = Provider.of<ClassProvider>(context);
    List<List<int>> classTime = classProvider.classTimeList;
    List<List<bool>> classFlagList = classProvider.classFlagList;

    // classTime = [[9, 0, 10, 30], [10, 40, 12, 10], [13, 0, 14, 30], [14, 40, 16, 10], [16, 20, 17, 50], [18, 0, 19, 30], [19, 40, 21, 10]];

    _timer = Timer.periodic(
      Duration(minutes: 1), (Timer timer) {
      // Duration(seconds: 1), (Timer timer) {
        // DateTime now = DateTime.now();
        DateTime now = DateTime.now().toUtc().add(const Duration(hours: 9));
        // 曜日を取得
        int dayOfWeek = now.weekday;
        
        int hour = now.hour;
        int minute = now.minute;
        print('$hour:$minute');

        // 現在の時刻がどの時間割に該当するかを判断
        int currentPeriod = -1;
        for (int i = 0; i < classTime.length; i++) {
          if (hour > classTime[i][0] || (hour == classTime[i][0] && minute >= classTime[i][1])) {
            if (hour < classTime[i][2] || (hour == classTime[i][2] && minute < classTime[i][3])) {
              if (classFlagList[dayOfWeek - 1][i] == true) {
                currentPeriod = i + 1; // 時間割は1から始まると仮定
                break;
              }
            }
          }
        }

        // 授業中かどうかを判断
        if (currentPeriod != -1) {
          print('現在は $currentPeriod 限目の授業中です。');
          homeProvider.setDuring(true);
        } else {
          print('現在は授業時間外です。');
          homeProvider.setDuring(false);
        }
      }
    );
  }

  @override
  void dispose(){
    // 破棄される時に停止する.
    _timer.cancel();
    super.dispose();
  }
  // late Timer _timer;
  
  // @override
  // void initState() {
  //   super.initState();
  //   // initState メソッド内で Timer を初期化
  //   _timer = Timer.periodic(Duration(seconds: 60), (Timer timer) {
  //     checkDuringTime();
  //   });
  // }

  // @override
  // void dispose() {
  //   // dispose メソッド内で Timer をキャンセル
  //   _timer.cancel();
  //   super.dispose();
  // }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // 非同期でSharedPreferencesを取得
      // dataが0がdefault、1がduringTime、2がresult
      future: getResultMode(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // SharedPreferencesの取得がまだ完了していない場合はローディングなどを表示
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // エラーがある場合はエラーメッセージを表示
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == 2) {
          return HomeDefault();
        } else if (snapshot.data == 1) {
          return HomeDuringTime();
        } else {
          return HomeDefault();
        }
      },
    );
  }


  getResultMode() async {
    // SharedPreferencesのインスタンスを生成
    final prefs = await SharedPreferences.getInstance();
    // SharedPreferencesからisSetNavigationToResultを取得
    final resultFlag = prefs.getBool('isSetNavigationToResult');
    print('resultFlag: ' + resultFlag.toString());
    if (resultFlag == null || resultFlag == false) {
      // isSetNavigationToResultがnullの場合はfalseを返す
      final during = prefs.getBool('during');
      print('during: ' + during.toString());
      if (during == true) {
        return 1;
      } else {
        return 0;
      }
    }
    // resultFlagがnullの場合はfalseを返す
    return 2;
  }

  // checkDuringTime() {
  //   // 現在時刻の取得
  //   final now = DateTime.now();
  //   final characterProvider = Provider.of<CharacterProvider>(context);
  //   final classProvider = Provider.of<ClassProvider>(context);
    
    
  // }
  
}

