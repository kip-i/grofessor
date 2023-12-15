import 'package:flutter/material.dart';

import '../_state.dart';
import 'name_button.dart';
import 'setting_button.dart';
import 'experience_bar.dart';
import 'model_3d.dart';
import 'measurements_start.dart';
import 'time_slider.dart';
import 'instruction_bar.dart';
import '../futter.dart';
import 'package:provider/provider.dart';
import '../const/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:grofessor/sample_screen_controller.dart';
import 'package:grofessor/sample_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'time_slider.dart';

class HomeDefault extends StatefulWidget {
  final bool result;

  const HomeDefault({Key? key, required this.result}) : super(key: key);

  @override
  State<HomeDefault> createState() => _HomeDefaultState(result: result);
}

class _HomeDefaultState extends State<HomeDefault> {
  final bool result;

  _HomeDefaultState({required this.result});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // resultがtrueならダイアログを表示
    if (result) {
      _showStartDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundProvider = Provider.of<BackgroundProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/backgrounds/' +
                      backgroundProvider.backgroundId +
                      '.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Model3D(),
          ),
          Positioned(
            top: 32.0,
            left: 16.0,
            child: NameButton(),
          ),
          Positioned(
            top: 160.0,
            left: 16.0,
            child: ExperienceBar(),
          ),
          Positioned(
            bottom: 130.0,
            left: 32,
            child: Container(child: TimeSlider()),
          ),
          Positioned(
            bottom: 32.0,
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: Container(child: MeasurementsStart()),
          ),
        ],
      ),
    );
  }

  Future<void> _showStartDialog() async {
    final SharedPreferences pref = await SharedPreferences.getInstance(); // SharedPreferencesのインスタンスを取得
    pref.setBool('isSetNavigationToResult', false);
    final achieveProvider = Provider.of<AchieveProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final _userId = userProvider.userId;
    final _paperNum = achieveProvider.paperNum;
    final int ? _time = pref.getInt('time');
    final int time = _time!;
    final double _value = pref.getDouble('sliderValue') ?? 25;
    print('userId: $_userId , paperNum: $_paperNum , time: $_time');
    achieveProvider.setAchieve(_userId, _paperNum, time, false);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          String timeString = formatMilliseconds(_time ?? 0);
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          return AlertDialog(
            title: const Text('結果',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                )
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('今回の測定時間は$timeStringでした！',
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    )
                ),
                Text('目標の測定時間は${_value.toString()}分でした！',
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ))
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "閉じる",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ],
            contentPadding: EdgeInsets.all(25.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: const BorderSide(width: 10.0, color: blackbordFrameColor),
            ),
            backgroundColor: blackbordColor,
          );
        },
      );
    });
  }
  String formatMilliseconds(int milliseconds) {
    // int seconds = (milliseconds / 1000).floor();
    int seconds = milliseconds;
    int hours = (seconds / 3600).floor();
    int minutes = ((seconds % 3600) / 60).floor();
    seconds = (seconds % 60).floor();

    String hoursStr = (hours % 24).toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}
