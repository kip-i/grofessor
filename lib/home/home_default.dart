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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          final achieveProvider = Provider.of<AchieveProvider>(context);
          return AlertDialog(
            title: Text('結果',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                )
            ),
            content: Text("集中時間は"
                + achieveProvider.achieveNum.toString()
                + "でした！",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                )),
            actions: <Widget>[
              TextButton(
                onPressed: () {
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
}
