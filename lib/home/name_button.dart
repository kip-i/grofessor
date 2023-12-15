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
          _showDialog(context);
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
  // ダイアログを表示する関数
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final haveItemProvider = Provider.of<HaveItemProvider>(context);
        final nickNameProvider = Provider.of<NickNameProvider>(context);
        final userProvider = Provider.of<UserProvider>(context);
        final userId = userProvider.userId;
        print('havenicknamelist: ${haveItemProvider.haveNickNameList}');
        return AlertDialog(
          title: Column(
            children: [
              Text(
                "称号を変更",
                style: TextStyle(color: Colors.white),
              ),
              Divider(color: blackbordWhiteColor, thickness: 4.0), // 横線を引く
            ],
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              color: blackbordColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    thickness: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: blackbordColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListView.builder(
                        itemCount: haveItemProvider.haveNickNameList.length,
                        itemBuilder: (BuildContext context, int index) {
                          print('haveItemProvider.haveNickNameList[index]: ${haveItemProvider.haveNickNameList[index]}');
                          print('haveItemProvider.haveNickNameIdList[index]: ${haveItemProvider.haveNickNameIdList[index]}' );
                          return _buildSelectableCard(
                              haveItemProvider.haveNickNameList[index],
                              haveItemProvider.haveNickNameIdList[index],
                              nickNameProvider,
                              userId,
                              context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "閉じる",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
          contentPadding: EdgeInsets.all(25.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(width: 10.0, color: blackbordFrameColor),
          ),
          backgroundColor: blackbordColor,
        );
      },
    );
  }

  Widget _buildSelectableCard(String x, String id,nickNameProvider, userId, context) {
    return GestureDetector(
      onTap: () {
        // タップされたときの処理を追加
        print('選択された称号: $x, $id, $userId');
        nickNameProvider.setNickName(userId, id, x);
        Navigator.of(context).pop();
      },
      child: Card(
        color: blackbordColor,
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Text(
            '$x',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
