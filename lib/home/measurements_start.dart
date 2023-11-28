import 'package:flutter/material.dart';

import '../const/color.dart';

class MeasurementsStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0, // 幅を指定
      height: 60.0, // 高さを指定
      child: ElevatedButton(
        onPressed: () {
          // ボタンが押された時の処理を追加
        },
        style: ElevatedButton.styleFrom(
          primary: accentColor, // ボタンの背景色
          onPrimary: Colors.white, // テキストの色
          padding: EdgeInsets.all(16.0), // ボタンの内側の余白
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // ボタンの角の丸み
          ),
        ),
        child: Text(
          '計測開始',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
