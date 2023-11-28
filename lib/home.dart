import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_cube/flutter_cube.dart';

class HomeDefault extends StatefulWidget {
  const HomeDefault({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomeDefault> createState() => _HomeDefaultState();
}

class _HomeDefaultState extends State<HomeDefault> {
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //_counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            width: 400,
            height: 700,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/backgrounds/b0.png'),
              fit: BoxFit.cover,
            ))),
        Positioned(
          top: 32.0,
          left: 16.0,
          child: _buildNameButton(),
        ),
        Positioned(
          top: 32.0,
          right: 16.0,
          child: _buildSettingButton(),
        ),
        Positioned(
          top: 160.0,
          left: 16.0,
          child: _buildExperienceBar(),
        ),
        Positioned.fill(
          top: 100,
          child: _build3DModel(),
        ),
      ],
    ));
  }

  @override
  Widget _buildNameButton() {
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

  @override
  Widget _buildSettingButton() {
    return Container(
      margin: EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey, // 背景色を灰色に設定
        borderRadius: BorderRadius.circular(8.0), // 角を丸くする
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // シャドウの方向（下に2ポイントずれ）
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.settings, color: Colors.white), // アイコンの色を白に設定
        onPressed: () {
          // ボタンが押されたときの処理を追加
        },
      ),
    );
  }

  @override
  Widget _build3DModel() {
    return Container(
      child: Cube(
        onSceneCreated: (Scene scene) {
          scene.world.add(Object(
            fileName: 'assets/models/cube.obj',
            // scale: Vector3(10.0, 10.0, 10.0),
            // rotation: Vector3(270.0, 180.0, 0.0),
          ));
        },
      ),
    );
  }

  @override
  Widget _buildExperienceBar() {
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
          value: 0.5,
          backgroundColor: Colors.grey[300], // プログレスバーの背景色
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // プログレスバーの色
        ),
      ),
    );
  }
}

class HomeDuringTime extends StatefulWidget {
  const HomeDuringTime({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomeDuringTime> createState() => _HomeDuringTime();
}

class _HomeDuringTime extends State<HomeDuringTime> {
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //_counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            width: 400,
            height: 700,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/backgrounds/b0.png'),
              fit: BoxFit.cover,
            ))),
        Positioned(
          top: 32.0,
          left: 16.0,
          child: _buildNameButton(),
        ),
        Positioned(
          top: 32.0,
          right: 16.0,
          child: _buildSettingButton(),
        ),
        Positioned(
          top: 160.0,
          left: 16.0,
          child: _buildExperienceBar(),
        ),
        Positioned.fill(
          top: 100,
          child: _build3DModel(),
        ),
      ],
    ));
  }

  @override
  Widget _buildNameButton() {
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

  @override
  Widget _buildSettingButton() {
    return Container(
      margin: EdgeInsets.only(right: 16.0, top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey, // 背景色を灰色に設定
        borderRadius: BorderRadius.circular(8.0), // 角を丸くする
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // シャドウの方向（下に2ポイントずれ）
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(Icons.settings, color: Colors.white), // アイコンの色を白に設定
        onPressed: () {
          // ボタンが押されたときの処理を追加
        },
      ),
    );
  }

  @override
  Widget _build3DModel() {
    return Container(
      child: Cube(
        onSceneCreated: (Scene scene) {
          scene.world.add(Object(
            fileName: 'assets/models/cube.obj',
            // scale: Vector3(10.0, 10.0, 10.0),
            // rotation: Vector3(270.0, 180.0, 0.0),
          ));
        },
      ),
    );
  }

  @override
  Widget _buildExperienceBar() {
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
          value: 0.5,
          backgroundColor: Colors.grey[300], // プログレスバーの背景色
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // プログレスバーの色
        ),
      ),
    );
  }
}
