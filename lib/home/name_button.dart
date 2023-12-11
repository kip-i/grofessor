import 'package:flutter/material.dart';
import 'package:grofessor/_state.dart';
import 'package:grofessor/state.dart';
import 'package:provider/provider.dart';

import '../const/color.dart';

class NameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nickProvider = Provider.of<NickNameProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final achieveProvider = Provider.of<AchieveProvider>(context);
    return Container(
      margin: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: blackbordFrameColor,
          width: 4.0,
        ),
        borderRadius: BorderRadius.circular(8.0), // 角を丸くする
      ),
      child: ElevatedButton(
        onPressed: () {
          // ボタンが押されたときの処理を追加
        },
        style: ElevatedButton.styleFrom(
          primary: blackbordColor, // ボタンの背景色を白に設定
          padding: EdgeInsets.all(8.0), // ボタン内の余白を設定
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0), // ボタンの角を丸める
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text(achieveProvider.paperNum.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    color: blackbordWhiteColor,
                  )),
            ),
            SizedBox(width: 6.0, height: 32.0, child: Container()),
            SizedBox(
                width: 4.0,
                height: 64.0,
                child: Container(
                  decoration: BoxDecoration(color: blackbordWhiteColor),
                )),
            SizedBox(width: 12.0, height: 32.0, child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: Text(
                    nickProvider.nickName,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: blackbordWhiteColor,
                    ),
                  ),
                ),
                SizedBox(width: 80.0, height: 6.0, child: Container()),
                SizedBox(
                    width: 80.0,
                    height: 4.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: blackbordWhiteColor,
                      ),
                    )),
                SizedBox(width: 80.0, height: 4.0, child: Container()),
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: Text(
                    userProvider.userName,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: blackbordWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
