import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sample_screen_controller.dart';
import 'sample_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'futter.dart';
import 'sample_state.dart';

final sampleScreenControllerProvider =
    StateNotifierProvider<SampleScreenController, SampleScreenState>(
        (ref) => SampleScreenController(MyApp().navigatorKey));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final mobileData = await getData();

  // runApp(
  //   MaterialApp(
  //     home: FutureBuilder(
  //       future: getData(),
  //       builder: (context, snapshot){
  //         if (snapshot.connectionState == ConnectionState.waiting){
  //           return CircularProgressIndicator();
  //         } else if (snapshot.hasError){
  //           return Text('Error: ${snapshot.error}');
  //         } else {
  //           final mobileData = snapshot.data;
  //           return MyApp(mobileData: mobileData ?? 0);
  //         }
  //       }
  //     )
  //   )
  // );

  runApp(ProviderScope(child: MyApp()));
}

// 数字を返す
Future<int> getData() async {
  return 0;
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final int mobileData = 0;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        sampleScreenProvider.overrideWith(
          (ref) => SampleScreenController(navigatorKey),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: Scaffold(
          bottomNavigationBar: NavigationExample(),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     navigatorKey: navigatorKey,
  //     home: Scaffold(
  //       bottomNavigationBar: NavigationExample(),
  //     ),
  //   );
  // }

  // if (mobileData == 0){
  //   return HomeDefault();
  // } else {
  //   return HomeDuringTime();
  // }
}
