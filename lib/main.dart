import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'futter.dart';

import 'home/home_selector.dart';
import 'register.dart';
import 'auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // final mobileData = await getData();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();  
  final SharedPreferences prefs = await _prefs;
  // prefs.clear();
  // prefs.setString('userName', 'test10');
  String _userName = prefs.getString('userName') ?? '';
  String _msg = await AuthService().signIn(_userName);

  runApp(
    // MaterialApp(
    //   home: FutureBuilder(
    //     future: getData(),
    //     builder: (context, snapshot){
    //       if (snapshot.connectionState == ConnectionState.waiting){
    //         return CircularProgressIndicator();
    //       } else if (snapshot.hasError){
    //         return Text('Error: ${snapshot.error}');
    //       } else {
    //         final mobileData = snapshot.data;
    //         return MyApp(mobileData: mobileData ?? 0);
    //       }
    //     }
    //   )
    // )
    MaterialApp(
      // home:MyApp(mobileData: 0,)
      home: MyApp(login: _msg,)
    )
  );
}

// 数字を返す
// Future <int> getData() async {
//   return 0;
// }

class MyApp extends StatelessWidget {
  // final int mobileData;
  final String login;

  // const MyApp({Key? key, required this.mobileData}) : super(key: key);
  const MyApp({Key? key, required this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(login);
    
    if (login == 'Success'){
      return Scaffold(
        bottomNavigationBar: NavigationExample(),
      );
      // if (mobileData == 0){
      //   return HomeDefault();
      // } else {
      //   return HomeDuringTime();
      // }
    } else {
      print('login: ${login}');
      return RegisterPage();
    } 
  }
}
