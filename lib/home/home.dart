import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_cube/flutter_cube.dart';

import '../firebase_options.dart';
import 'name_button.dart';
import 'setting_button.dart';
import 'experience_bar.dart';
import 'model_3d.dart';

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
          Positioned.fill(
            top: 100,
            child: model_3d(),
          ),
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
          Positioned.fill(
            top: 100,
            child: model_3d(),
          ),
        ],
      )
    );
  }
}

