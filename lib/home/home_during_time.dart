import 'package:flutter/material.dart';

import 'name_button.dart';
import 'setting_button.dart';
import 'experience_bar.dart';
import 'model_3d.dart';
import 'measurements_start.dart';
import 'time_slider.dart';
import 'instruction_bar.dart';
import '../futter.dart';


class HomeDuringTime extends StatefulWidget {
  const HomeDuringTime({super.key});

  @override
  State<HomeDuringTime> createState() => _HomeDuringTime();
}

class _HomeDuringTime extends State<HomeDuringTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/backgrounds/b0.png'),
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
        Positioned(
          top: 32.0,
          right: 16.0,
          child: SettingButton(),
        ),
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
}