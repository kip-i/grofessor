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

class HomeDefault extends StatefulWidget {
  const HomeDefault({super.key});

  @override
  State<HomeDefault> createState() => _HomeDefaultState();
}

class _HomeDefaultState extends State<HomeDefault> {
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
              //image: AssetImage('assets/backgrounds/b5.png'),
              image: AssetImage('assets/backgrounds/' +
                  backgroundProvider.backgroundId +'.png'),
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
        Positioned(
            bottom: 130.0, left: 32, child: Container(child: TimeSlider())),
        Positioned(
            bottom: 32.0,
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: Container(child: MeasurementsStart())),
      ],
    ));
  }
}
