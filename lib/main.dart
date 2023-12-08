import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'sample_screen_controller.dart';
import 'sample_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grofessor/state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'auth_service.dart';
import 'firebase_options.dart';
import 'futter.dart';
import 'sample_state.dart';

final sampleScreenControllerProvider =
    riverpod.StateNotifierProvider<SampleScreenController, SampleScreenState>(
        (ref) => SampleScreenController(MyApp().navigatorKey));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DataProvider dataProvider = DataProvider();
  await dataProvider.getUserId();

  runApp(
    ChangeNotifierProvider.value(
      value: dataProvider,
      child: riverpod.ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final int mobileData = 0;

  @override
  Widget build(BuildContext context) {
    return riverpod.ProviderScope(
      overrides: [
        sampleScreenProvider.overrideWith(
          (ref) => SampleScreenController(navigatorKey),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: Consumer<DataProvider>(
          builder: (context, dataProvider, child) {
            print('画面生成 ${dataProvider.login.toString()}');
            // print('画面生成'+Provider.of<DataProvider>(context, listen: true).isLogin.toString());
            // return Provider.of<DataProvider>(context, listen: true).login
            return dataProvider.login
                ? const Scaffold(
                    bottomNavigationBar: NavigationExample(),
                  )
                : RegisterPage();
          },
        ),
      ),
    );
  }
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
