import 'package:flutter/material.dart';

import 'name_button.dart';
import 'setting_button.dart';
import 'experience_bar.dart';
import 'model_3d.dart';
import 'measurements_start.dart';
import 'time_slider.dart';

class HomeDefault extends StatefulWidget {
  const HomeDefault({super.key});

  @override
  State<HomeDefault> createState() => _HomeDefaultState();
}

class _HomeDefaultState extends State<HomeDefault> {
  void _incrementCounter() {
    setState(() {
      //_counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 400,
            height: 700,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgrounds/b0.png'),
                fit: BoxFit.cover,
              )
            )
          ),
          Positioned.fill(
            // top: 100,
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
          Positioned(
            top: 600,
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: Container(
              child: MeasurementsStart()
            )
          ),
          
          
          Positioned(top: 460, left: 32, child: Container(child: TimeSlider())),
        ],
      )
    );
  }
}


class HomeDuringTime extends StatefulWidget {
  const HomeDuringTime({super.key});

  @override
  State<HomeDuringTime> createState() => _HomeDuringTime();
}

class _HomeDuringTime extends State<HomeDuringTime> {
  void _incrementCounter() {
    setState(() {
      //_counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 400,
            height: 700,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgrounds/b0.png'),
                fit: BoxFit.cover,
              )
            )
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
          Positioned(
            top: 600,
            //中央寄せ
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: Container(child: MeasurementsStart())),
          Positioned.fill(
            top: 100,
            child: Model3D(),
          ),
        ],
      )
    );
  }
}

