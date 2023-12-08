import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grofessor/state.dart';
import 'package:provider/provider.dart';
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

  DataProvider dataProvider = DataProvider();
  await dataProvider.getUserId();

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
    ChangeNotifierProvider.value(
      value: dataProvider, // 既存のAuthProviderインスタンスを提供
      child: MyApp(),
    ),
  );
}

// 数字を返す
// Future <int> getData() async {
//   return 0;
// }

class MyApp extends StatelessWidget {
// class MyApp extends ConsumerWidget{
  // final int mobileData;
  // final String login;

  // const MyApp({Key? key, required this.mobileData}) : super(key: key);
  // const MyApp({Key? key, required this.login}) : super(key: key);
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<DataProvider>(
        builder: (context, dataProvider, child) {
          print('画面生成' + dataProvider.login.toString());
          // print('画面生成'+Provider.of<DataProvider>(context, listen: true).isLogin.toString());
          // return Provider.of<DataProvider>(context, listen: true).login
          return dataProvider.login
              ? Scaffold(
                  bottomNavigationBar: NavigationExample(),
                )
              : RegisterPage();
        },
      ),
    );
  }
}
