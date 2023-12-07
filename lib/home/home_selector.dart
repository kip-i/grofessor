import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_default.dart';
import 'home_during_time.dart';

class HomeSelector extends StatefulWidget {
  const HomeSelector({Key? key});

  @override
  State<HomeSelector> createState() => _HomeSelector();
}

class _HomeSelector extends State<HomeSelector> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // 非同期でSharedPreferencesを取得
      future: getDuring(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // SharedPreferencesの取得がまだ完了していない場合はローディングなどを表示
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // エラーがある場合はエラーメッセージを表示
          return Text('Error: ${snapshot.error}');
        } else {
          // SharedPreferencesの取得が完了した場合は、HomeDefaultかHomeDuringTimeを表示
          final bool during = snapshot.data as bool;
          return during ? HomeDuringTime() : HomeDefault();
        }
      },
    );
  }

  getDuring() async {
    // SharedPreferencesのインスタンスを生成
    final prefs = await SharedPreferences.getInstance();
    // SharedPreferencesからduringを取得
    final during = prefs.getBool('during');
    // duringがnullの場合はfalseを返す
    return during ?? false;
  }
}
