import 'package:flutter/material.dart';

import '../const/color.dart';

class MeasurementsStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0, // 幅を指定
      height: 60.0, // 高さを指定
      decoration: BoxDecoration(
        border: Border.all(
          color: blackbordFrameColor,
          width: 4.0,
        ),
        borderRadius: BorderRadius.circular(8.0), // 角を丸くする
      ),
      child: ElevatedButton(
        onPressed: () {
          // ボタンが押された時の処理を追加
        },
        style: ElevatedButton.styleFrom(
          primary: blackbordColor, // ボタンの背景色
          onPrimary: blackbordWhiteColor, // テキストの色
          padding: EdgeInsets.all(4.0), // ボタンの内側の余白
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0), // ボタンの角の丸み
          ),
        ),
        child: Text(
          '計測開始',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
