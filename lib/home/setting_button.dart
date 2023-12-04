import 'package:flutter/material.dart';

class SettingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey, // 背景色を灰色に設定
        borderRadius: BorderRadius.circular(8.0), // 角を丸くする
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // シャドウの方向（下に2ポイントずれ）
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.settings, color: Colors.white), // アイコンの色を白に設定
        onPressed: () {
          // ボタンが押されたときの処理を追加
        },
      ),
    );
  }
}
