import 'package:flutter/material.dart';

class ExperienceBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 13.0,
      margin: EdgeInsets.only(left: 16.0),
      child: Card(
        elevation: 4.0, // 影の深さ
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // カードの角を丸める
        ),
        child: LinearProgressIndicator(
          value: 0.5,
          backgroundColor: Colors.grey[300], // プログレスバーの背景色
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // プログレスバーの色
        ),
      ),
    );
  }
}
