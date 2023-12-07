import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sample_screen_controller.dart';
import 'sample_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'futter.dart';
import 'home/home_selector.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final sampleScreenController = SampleScreenController(navigatorKey);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final mobileData = await getData();
  debugPrint('navigatorKey: $navigatorKey');

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
    //   MaterialApp(
    //       home: MyApp(
    // mobileData: 0,
    ProviderScope(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: MyApp(
          mobileData: 0,
          controller: sampleScreenController,
          navigatorKey: navigatorKey,
        ),
      ),
    ),
  );
}

// 数字を返す
Future<int> getData() async {
  return 0;
}

class MyApp extends StatelessWidget {
  final SampleScreenController controller;
  final GlobalKey<NavigatorState> navigatorKey;
  final int mobileData;

  MyApp(
      {Key? key,
      required this.mobileData,
      required this.controller,
      required this.navigatorKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        overrides: [
          sampleScreenProvider.overrideWith(
            (ref) => controller,
          ),
        ],
        child: Scaffold(
          bottomNavigationBar: NavigationExample(),
        )
        // if (mobileData == 0){
        //   return HomeDefault();
        // } else {
        //   return HomeDuringTime();
        // }
        );
  }
}
