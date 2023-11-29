import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cube/flutter_cube.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _userName = '';
  bool _isSelected1 = false;
  bool _isSelected2 = false;

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
          SizedBox(height: 50.0),
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
                      });
                      print('アバター1が選択されました');
                    },
                    child:Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: _isSelected1 ? Colors.green : Colors.white, // 背景色を灰色に設定
                      ),
                      child: Cube(
                        onSceneCreated: (Scene scene) {
                          scene.world.add(Object(
                            fileName: 'assets/models/v4.obj',
                            scale: Vector3(5.0, 5.0, 5.0),
                            rotation: Vector3(270.0, 180.0, 0.0),
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
                      });
                      print('アバター2が選択されました');
                    },
                    child:Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: _isSelected2 ? Colors.green : Colors.white, // 背景色を灰色に設定
                      ),
                      child: Cube(
                        onSceneCreated: (Scene scene) {
                          scene.world.add(Object(
                            fileName: 'assets/models/v4.obj',
                            scale: Vector3(5.0, 5.0, 5.0),
                            rotation: Vector3(270.0, 180.0, 0.0),
                          ));
                        },
                      ),
                    ),
                  ),
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
            onPressed: _userName=='' || (!_isSelected1 && !_isSelected2) ? null : () async {
              try {
                String _email = _userName+'@example.com';
                String _password = 'password';
                final User? user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _email,
                            password: _password
                          )).user;
                if (user != null)
                  print("ユーザ登録しました ${user.email} , ${user.uid}");
              } catch (e) {
                print("ユーザ登録に失敗しました ${e}");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white
            ),
            child: const Text('作成'),
          ),
          SizedBox(height: 20.0),
        ] 
      ),
      //       SizedBox(height: 16.0),
      //       // Row(
      //       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         // children: [
      //           // Text('アバター1'),
              
      //           // SizedBox(
      //           //   width: 100,
      //           //   height: 100,
      //           //   child: Cube(
      //           //     onSceneCreated: (Scene scene) {
      //           //       scene.world.add(Object(
      //           //         fileName: 'assets/models/v4.obj',
      //           //       ));
      //           //     },
      //           //   ),
      //           // ),
      //           // SizedBox(
      //           //   width: 100,
      //           //   height: 100,
      //           //   child: Cube(
      //           //     onSceneCreated: (Scene scene) {
      //           //       scene.world.add(Object(
      //           //         fileName: 'assets/models/cube.obj',
      //           //       ));
      //           //     },
      //           //   ),
      //           // ),
      //           // Text('アバター2'),
      //         // ],
      //       // ),
      //       SizedBox(height: 16.0),
      //       ElevatedButton(
      //         onPressed: () async {
      //           try {
      //             String _email = _userName+'@example.com';
      //             String _password = 'password';
      //             final User? user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //                         email: _email,
      //                         password: _password
      //                       )).user;
      //             if (user != null)
      //               print("ユーザ登録しました ${user.email} , ${user.uid}");
      //           } catch (e) {
      //             print("ユーザ登録に失敗しました ${e}");
      //           }
      //         },
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.green,
      //           foregroundColor: Colors.white
      //         ),
      //         child: const Text('作成'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
