import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: FutureBuilder(
        future: getData(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          } else if (snapshot.hasError){
            return Text('Error: ${snapshot.error}');
          } else {
            final mobileData = snapshot.data;
            return MyApp(mobileData: mobileData ?? 0);
          }
        }
      )
    )
  );
}

// 数字を返す
Future <int> getData() async {
  return 0;
}

class MyApp extends StatelessWidget {
  final int mobileData;

  const MyApp({Key? key, required this.mobileData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mobileData == 0){
      return HomeDefault();
    } else {
      return HomeDuringTime();
    }
      
  }
}
