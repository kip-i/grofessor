import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_cube/flutter_cube.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _userName = '';
  final String _password = 'password';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Grofessor'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                decoration: const InputDecoration(labelText: 'ユーザーネーム'),
                onChanged: (String value) {
                  setState(() {
                    _userName = value;
                  });
                },
              ),
            SizedBox(height: 16.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Cube(
            //       onSceneCreated: (Scene scene) {
            //         scene.world.add(Object(fileName: "lib/assets/sampleObject.obj"));
            //       },
            //     ),
            //     Cube(
            //       onSceneCreated: (Scene scene) {
            //         scene.world.add(Object(fileName: "lib/assets/sampleObject.obj"));
            //       },
            //     ),
            //   ],
            // ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  String _email = _userName+'@example.com';
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
          ],
        ),
      ),
    );
  }
}
