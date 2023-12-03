import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sample_screen_controller.dart';
import 'sample_provider.dart';
import 'test_home.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        title: 'Sample App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
