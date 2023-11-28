import 'package:flutter/material.dart';

class NameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 164, 108, 00),
          width: 4.0,
        ),
        borderRadius: BorderRadius.circular(8.0), // 角を丸くする
      ),
      child: ElevatedButton(
        onPressed: () {
          // ボタンが押されたときの処理を追加
        },
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 00, 75, 63), // ボタンの背景色を白に設定
          padding: EdgeInsets.all(8.0), // ボタン内の余白を設定
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0), // ボタンの角を丸める
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              child: Text('4',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                  )),
            ),
            SizedBox(width: 6.0, height: 32.0, child: Container()),
            SizedBox(
                width: 4.0,
                height: 64.0,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                )),
            SizedBox(width: 12.0, height: 32.0, child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: Text(
                    '2つ名あああ',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 80.0, height: 6.0, child: Container()),
                SizedBox(
                    width: 80.0,
                    height: 4.0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    )),
                SizedBox(width: 80.0, height: 4.0, child: Container()),
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'UserName',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
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
