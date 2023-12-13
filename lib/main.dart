import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:grofessor/_state.dart';
import 'package:grofessor/home/home_state.dart';
import 'package:grofessor/test_home.dart';
import 'firebase_service.dart';
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

  // DataProvider dataProvider = DataProvider();
  // await dataProvider.getUserId();

  UserProvider userProvider = UserProvider();
  await userProvider.getUser();

  print('ページ：main.dart');

  NickNameProvider nickNameProvider = NickNameProvider();
  await nickNameProvider.getNickName();
  CharacterProvider characterProvider = CharacterProvider();
  await characterProvider.getCharacter();
  BackgroundProvider backgroundProvider = BackgroundProvider();
  await backgroundProvider.getBackground();
  GachaProvider gachaProvider = GachaProvider();
  await gachaProvider.getGacha();
  AchieveProvider achieveProvider = AchieveProvider();
  await achieveProvider.getAchieve();
  HaveItemProvider haveItemProvider = HaveItemProvider();
  await haveItemProvider.getHaveItemList();
  ClassProvider classProvider = ClassProvider();
  await classProvider.getClassList();
  RankingProvider rankingProvider = RankingProvider();
  await rankingProvider.getRanking();
  // await nickNameProvider.getNickName();
  HomeProvider homeProvider = HomeProvider();

  // print(await FirebaseService().getAllNickNameId());

  // runApp(
  //   ChangeNotifierProvider.value(
  //     value: dataProvider,
  //     child: riverpod.ProviderScope(child: MyApp()),
  //   ),
  // );
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider<DataProvider>.value(
        //   value: dataProvider,
        // ),
        ChangeNotifierProvider<UserProvider>.value(
          value: userProvider,
        ),
        ChangeNotifierProvider<NickNameProvider>.value(
          value: nickNameProvider,
        ),
        ChangeNotifierProvider<CharacterProvider>.value(
          value: characterProvider,
        ),
        ChangeNotifierProvider<BackgroundProvider>.value(
          value: backgroundProvider,
        ),
        ChangeNotifierProvider<GachaProvider>.value(
          value: gachaProvider,
        ),
        ChangeNotifierProvider<AchieveProvider>.value(
          value: achieveProvider,
        ),
        ChangeNotifierProvider<HaveItemProvider>.value(
          value: haveItemProvider,
        ),
        ChangeNotifierProvider<ClassProvider>.value(
          value: classProvider,
        ),
        ChangeNotifierProvider<RankingProvider>.value(
          value: rankingProvider,
        ),
        ChangeNotifierProvider<HomeProvider>.value(
          value: homeProvider,
        ),
      ],
      child: riverpod.ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final int mobileData = 0;

  @override
  Widget build(BuildContext context) {
    // final nickNameProvider = Provider.of<NickNameProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    print('ユーザID：' + userProvider.userId);
    return riverpod.ProviderScope(
      overrides: [
        sampleScreenProvider.overrideWith(
          (ref) => SampleScreenController(navigatorKey),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            // print('画面生成 ${dataProvider.login.toString()}');
            print('画面生成 ${userProvider.login}');

            // print('ニックネーム ${nickNameProvider.nickName}');
            // print('画面生成'+Provider.of<DataProvider>(context, listen: true).isLogin.toString());
            // return Provider.of<DataProvider>(context, listen: true).login
            // return dataProvider.login
            return userProvider.login
                ? const Scaffold(
                    bottomNavigationBar: NavigationExample(),
                  )
                : RegisterPage();

            // return Consumer<NickNameProvider>(
            //   builder: (context, nickNameProvider, child) {
            //     print('ニックネーム ${nickNameProvider.nickName}');
            //     return userProvider.login
            //         ? const Scaffold(
            //             bottomNavigationBar: NavigationExample(),
            //           )
            //         : RegisterPage();
            //   },
            // );
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
