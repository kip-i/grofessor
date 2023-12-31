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

class HomeDuringTime extends StatefulWidget {
  final bool result;
  const HomeDuringTime({Key? key, required this.result}) : super(key: key);

  @override
  State<HomeDuringTime> createState() =>
      _HomeDuringTime(result: result);
}

class _HomeDuringTime extends State<HomeDuringTime> {
  final bool result;
  bool flag = false;

  _HomeDuringTime({required this.result});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // resultがtrueならダイアログを表示
    print('didChangeDependencies!!!!!!!!!!!!!!!!!!!!!!!!!FLAG2: $flag');
    if (!flag && result) {
      print('didChangeDependencies!!!!!!!!!!!!!!!!!!!!!!!!!2: $result');
      flag = true;
      _showStartDialog();
    }
  }

  @override
  void dispose() {
    super.dispose();
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
              image: AssetImage('assets/backgrounds/' +
                  backgroundProvider.backgroundId +
                  '.png'),
              fit: BoxFit.cover,
            ))),
        Positioned.fill(
          child: Model3D(),
        ),
        Positioned(
          top: 32.0,
          left: 16.0,
          child: NameButton(),
        ),
        // Positioned(
        //   top: 32.0,
        //   right: 16.0,
        //   child: SettingButton(),
        // ),
        Positioned(
          top: 160.0,
          left: 16.0,
          child: ExperienceBar(),
        ),
        Positioned(bottom: 130.0, child: InstructionBar()),
        Positioned(
            bottom: 32.0,
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: Container(child: MeasurementsStart())),
      ],
    ));
  }

  Future<void> _showStartDialog() async {
    print('showStartDialog!!!!!!!!!!!!!!!!!!!!!!!!!: $result');
    if(result == false){
      return;
    }
    
    final SharedPreferences pref =
        await SharedPreferences.getInstance(); // SharedPreferencesのインスタンスを取得
    pref.setBool('isSetNavigationToResult', false);
    final achieveProvider =
        Provider.of<AchieveProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final gachaProvider = Provider.of<GachaProvider>(context, listen: false);
    final _userId = userProvider.userId;
    final _paperNum = achieveProvider.paperNum;
    final int? _time = pref.getInt('time');
    pref.setInt('time', 0);
    final int time = _time!;
    print('userId: $_userId , paperNum: $_paperNum , time: $_time');
    await achieveProvider.setAchieve(_userId, _paperNum, time, false);
    if(achieveProvider.paperNum > _paperNum && achieveProvider.paperNum % 3 == 0){
      await gachaProvider.setGachaTicket(_userId, 1);
    }
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          String timeString = formatMilliseconds(_time ?? 0);
          // final controller = context.read<SampleScreenController>();
          debugPrint('contr');
          final userProvider =Provider.of<UserProvider>(context, listen: false);
          return AlertDialog(
            title: Text('結果',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                )),
            content:
                // Text("集中時間は" + achieveProvider.achieveNum.toString() + "でした！",
                Text("集中時間は" + timeString + "でした！",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    )),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await achieveProvider.setAchieve(_userId, await _time, 1,false);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "閉じる",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ],
            contentPadding: EdgeInsets.all(25.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(width: 10.0, color: blackbordFrameColor),
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
