import 'package:flutter/material.dart';
import 'package:grofessor/_state.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadNicknameData() async {
  String jsonString = await rootBundle.loadString('lib/data/nick_name.json');
  return jsonDecode(jsonString);
}

void showDialogNickname(BuildContext context, selectedElement) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final gachaProvider = Provider.of<GachaProvider>(context, listen: false);
  final nickNameProvider = Provider.of<NickNameProvider>(context, listen: false);
  // int index = int.parse(selectedElement.substring(1));
  // String nickName = gachaProvider.allNickNameList[index];
  loadNicknameData().then((nicknames) {
    String nickName = nicknames[selectedElement];

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Color.fromARGB(255, 143, 98, 82),
              width: 6.0,
            ),
          ),
          content: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                const Text(
                  '称号をゲット！！',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                   color: const Color.fromRGBO(3, 169, 244, 1), // 水色の背景色
                   padding: const EdgeInsets.all(8), // パディングを追加
                   child: Text(
                      //  'ああああああ',
                        nickName,
                        style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                         color: Colors.black,
                          ),
                       ),
                      ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                // Container(
                //   color: Colors.lightBlue, // 水色の背景色
                //   padding: const EdgeInsets.all(8), // パディングを追加
                //   child: const Text(
                //     'いいいいいい',
                //     style: TextStyle(
                //       fontSize: 15,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const Text(
                  'この称号に変更しますか?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        nickNameProvider.setNickName(userProvider.userId, selectedElement, nickName);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 66, 183, 70),
                        foregroundColor: Colors.red,
                      ),
                      child: const Text(
                        'これに変更する',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 170, 177, 171),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        '       閉じる       ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
 });
}