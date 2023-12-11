import 'package:flutter/material.dart';
import 'package:grofessor/_state.dart';
import 'package:grofessor/state.dart';
import 'package:provider/provider.dart';

class ExperienceBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final achieveProvider = Provider.of<AchieveProvider>(context);
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
          value: achieveProvider.thisTime / achieveProvider.needTime,
          backgroundColor: Colors.grey[300], // プログレスバーの背景色
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // プログレスバーの色
        ),
      ),
    );
  }
}
