import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_cube/flutter_cube.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'grofessor',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 93, 176, 74)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isOnTable = false;

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
              )
            )
          ),
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
          Positioned.fill(
            top: 100,
            child: _build3DModel(),
          )
        ],
      )
    );
  }

  @override
  Widget _buildNameButton() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 164,108,00),
          width: 4.0,
        ), 
      ),
      child: ElevatedButton(
        onPressed: () {
          // ボタンが押されたときの処理を追加
        },
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255,00,75,63), // ボタンの背景色を白に設定
          padding: EdgeInsets.all(8.0), // ボタン内の余白を設定
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // ボタンの角を丸める
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              child:
                Text('4',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.white,
                  )
                ),
            ),
            SizedBox(width: 6.0, height: 32.0, child: Container()),
            SizedBox(
              width: 4.0,
              height: 64.0,
              child: Container(
                decoration: BoxDecoration(color: Colors.white), 
              )
            ),
            SizedBox(width: 12.0, height: 32.0, child: Container()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child:
                    Text(
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
                  )
                ), 
                SizedBox(width: 80.0, height: 4.0, child: Container()),
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child:
                    Text(
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
    return Container(child: Cube(
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
}

