import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:grofessor/_state.dart';
import 'package:grofessor/state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'firebase_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _userName = '';
  String _gender = '';
  bool _first = true;
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  String _msg = '';
  List<String> _ranking = [];

  @override
  Widget build(BuildContext context) {
    // final dataProvider = Provider.of<DataProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final nickNameProvider = Provider.of<NickNameProvider>(context);
    final characterProvider = Provider.of<CharacterProvider>(context);
    final backgroundProvider = Provider.of<BackgroundProvider>(context);
    final gachaProvider = Provider.of<GachaProvider>(context);
    final achieveProvider = Provider.of<AchieveProvider>(context);
    final haveItemProvider = Provider.of<HaveItemProvider>(context);
    final classProvider = Provider.of<ClassProvider>(context);
    final rankingProvider = Provider.of<RankingProvider>(context);

    print('ページ：' + userProvider.msg);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('教授育成中'),
        backgroundColor: Colors.green,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(child: SizedBox(height: 20.0)),
        Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            // mainAxisAlignment: MainAxisAlignment.center,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'ユーザーネーム',
                labelStyle: TextStyle(color: Colors.green),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
              // validator: (String? value) {
              //   if (userProvider.msg == 'Error') {
              //     print(userProvider.msg);
              //     return 'すでに使われているユーザーネームです';
              //   }
              // if (value != null) {
              //   String pattern =
              //       r'^[0-9a-z_./?-]+@([0-9a-z-]+\.)+[0-9a-z-]+$';
              //   RegExp regExp = RegExp(pattern);
              //   if (!regExp.hasMatch(value)) {
              //     return '正しいメールアドレスを入力してください';
              //   }
              // }
              // },
              inputFormatters: [
                // 最大20文字まで
                LengthLimitingTextInputFormatter(8),
                // 半角英数字のみ許可
                // FilteringTextInputFormatter.allow(
                //   RegExp(r'[a-zA-Z0-9]'),
                // ),
              ],
              style: TextStyle(
                color: Colors.green,
              ),
              onChanged: (String value) {
                setState(() {
                  _userName = value;
                });
              },
            ),
          ),
        ),
        Consumer<UserProvider>(builder: (context, userProvider, child) {
          return Center(child: () {
            if (userProvider.msg == 'Error') {
              return Text(
                'すでに使われているユーザーネームです',
                style: TextStyle(
                  color: Colors.red,
                ),
              );
            } else {
              return Text(
                '',
                style: TextStyle(
                  color: Colors.red,
                ),
              );
            }
          }());
        }),
        Expanded(child: SizedBox(height: 50.0)),
        Text(
          'アバターを選択してください',
          textAlign: TextAlign.left,
          style: TextStyle(
            // fontSize: 20,
            color: Colors.green,
          ),
        ),
        SizedBox(height: 10.0),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelected1 = true;
                        _isSelected2 = false;
                        _gender = 'm';
                      });
                      print('アバター1が選択されました');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2-20,
                      height: MediaQuery.of(context).size.width/2-20,
                      decoration: BoxDecoration(
                        color: _isSelected1 ? Colors.green : null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Cube(
                        onSceneCreated: (Scene scene) {
                          scene.world.add(Object(
                            fileName: 'assets/models/m0.obj',
                            scale: Vector3(15.0, 15.0, 15.0),
                            rotation: Vector3(270.0, 180.0, 0.0),
                            position: Vector3(-1.0, -3.5, 0.0),
                          ));
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'アバター1',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              // SizedBox(width: 16),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // クリック時の処理
                      setState(() {
                        _isSelected1 = false;
                        _isSelected2 = true;
                        _gender = 'w';
                      });
                      print('アバター2が選択されました');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2-20,
                      height: MediaQuery.of(context).size.width/2-20,
                      decoration: BoxDecoration(
                        color: _isSelected2 ? Colors.green : null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Cube(
                        onSceneCreated: (Scene scene) {
                          scene.world.add(Object(
                            fileName: 'assets/models/w0.obj',
                            scale: Vector3(15.0, 15.0, 15.0),
                            rotation: Vector3(270.0, 180.0, 0.0),
                            position: Vector3(-1.0, -3.5, 0.0),
                          ));
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'アバター2',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ]),
        SizedBox(height: 40.0),
        ElevatedButton(
          onPressed: _userName == '' || _gender == '' || !_first
              ? null
              : () async {
                  setState(() {
                    _first = false;
                  });
                  // await Future.delayed(
                  //   Duration(seconds: 1), //無効にする時間
                  // );
                  // _msg = await AuthService().addUser(_userName,_gender);
                  // _ranking = await FirebaseService().getRanking();
                  // await dataProvider.setUser(_userName, _gender);
                  await userProvider.initUser(_userName, _gender);
                  if (userProvider.login) {
                    await nickNameProvider.init();
                    await characterProvider.init(_gender);
                    await backgroundProvider.init();
                    await gachaProvider.init(_gender);
                    await achieveProvider.init();
                    await haveItemProvider.init(_gender);
                    await classProvider.init();
                    await rankingProvider.init();

                    await userProvider.notify();
                  } else {
                    setState(() {
                      _first = true;
                    });
                  }
                  // DataProvider().setUser();
                  // dataProvider.getUserId();
                  // print(_msg);
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey,
            disabledForegroundColor: Colors.white,
          ),
          child: const Text('作成'),
        ),
        Expanded(child: SizedBox(height: 20.0)),
      ]),
    );
  }
}
