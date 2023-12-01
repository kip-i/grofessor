import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_default.dart';
import 'home_during_time.dart';

class HomeSelector extends StatelessWidget {
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

  // SharedPreferencesからduringの値を取得するメソッド
  Future<bool> getDuring() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('during') ?? false;
  }
}
