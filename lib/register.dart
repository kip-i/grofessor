import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'firebase_service.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _userName = '';
  String _gender = '';
  bool _isSelected1 = false;
  bool _isSelected2 = false;
  String _msg = '';
  List<String> _ranking = [];

  Future<void> _setUser() async {
    final SharedPreferences prefs = await _prefs;

    prefs.setString('userName', _userName);
    prefs.setString('gender', _gender);
    prefs.setString('characterId', '0');
    prefs.setString('backgroundId', '0');
    prefs.setString('nickNameId', '0');

    prefs.setInt('gachaTicket', 0);
    prefs.setStringList('notHaveNickNameList', ['0','1','2']);
    prefs.setStringList('notHaveCharacterList', ['($_gender)1','($_gender)2']);
    prefs.setStringList('notHaveBackgroundList', ['0','1','2']);

    prefs.setInt('paperNum', 0);
    prefs.setInt('sumTime', 0);
    prefs.setInt('thisTime', 0);
    prefs.setInt('needTime', 0);
    prefs.setInt('achieveNum', 0);
    prefs.setInt('meanTime', 0);
    prefs.setInt('penalty', 0);

    prefs.setStringList('haveNickNameList', []);
    prefs.setStringList('haveCharacterList', []);
    prefs.setStringList('haveBackgroundList', []);

    prefs.setStringList('classFlag', ['0','0','0','0','0','0',
                                      '0','0','0','0','0','0',
                                      '0','0','0','0','0','0',
                                      '0','0','0','0','0','0',
                                      '0','0','0','0','0','0',
                                      '0','0','0','0','0','0']);
    prefs.setStringList('classTime', ['0','0','0','0',
                                      '0','0','0','0',
                                      '0','0','0','0',
                                      '0','0','0','0',
                                      '0','0','0','0',
                                      '0','0','0','0']);

    // prefs.setStringList('ranking', _ranking);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Grofessor'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Expanded(child:SizedBox(height: 20.0)),
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              // mainAxisAlignment: MainAxisAlignment.center,
              child:TextFormField(
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
                // inputFormatters: [
                //   // 最大20文字まで
                //   LengthLimitingTextInputFormatter(20),
                //   // 半角英数字のみ許可
                //   FilteringTextInputFormatter.allow(
                //     RegExp(r'[a-zA-Z0-9]'),
                //   ),
                // ],
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
          Expanded(child:SizedBox(height: 50.0)),
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
            children:[
              Column(
                children:[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSelected1 = true;
                        _isSelected2 = false;
                        _gender = 'm';
                      });
                      print('アバター1が選択されました');
                    },
                    child:Container(
                      width: 150,
                      height: 150,
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
                children:[
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
                    child:Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: _isSelected2 ? Colors.green : null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Cube(
                        onSceneCreated: (Scene scene) {
                          scene.world.add(Object(
                            fileName: 'assets/models/w1.obj',
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
            ]
          ),
          SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: _userName=='' || _gender=='' ? null : () async {
              _msg = await AuthService().addUser(_userName,_gender);
              // _ranking = await FirebaseService().getRanking();
              _setUser();
              // print(_msg);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white
            ),
            child: const Text('作成'),
          ),
          Expanded(child:SizedBox(height: 20.0)),
        ] 
      ),
    );
  }
}