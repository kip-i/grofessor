import 'package:flutter/material.dart';

import '../const/color.dart';

class MeasurementsStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0, // 幅を指定
      height: 70.0, // 高さを指定
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: blackbordFrameColor,
      //     width: 4.0,
      //   ),
      //   borderRadius: BorderRadius.circular(8.0), // 角を丸くする
      // ),
      // decoration: BoxDecoration(
      //   border: Border(bottom: BorderSide(color: blackbordFrameColor, width: 4.0)),),
      child: ElevatedButton(
        onPressed: () {
          // ボタンが押された時の処理を追加
        },
        style: ElevatedButton.styleFrom(
          primary: blackbordColor, // ボタンの背景色
          onPrimary: blackbordWhiteColor, // テキストの色
          padding: EdgeInsets.all(6.0), // ボタンの内側の余白
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(
            Icons.timer,
            size: 45.0,
            color:  blackbordWhiteColor,
          ),
          Container(
            margin: EdgeInsets.all(4.0), 
            child: Text(
              '計測開始',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ]
        ,)
        
      
      ),
    );
  }
}

//使えそうなIcon
//Play Arrow, timer
