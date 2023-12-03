import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import 'sample_screen_controller.dart';
import 'sample_state.dart';

final sampleScreenProvider =
    StateNotifierProvider<SampleScreenController, SampleScreenState>(
  (ref) => SampleScreenController(GlobalKey<NavigatorState>()),
);
