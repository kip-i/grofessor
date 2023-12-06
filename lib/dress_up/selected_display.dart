import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';


class SelectedDisplay extends StatefulWidget {
  const SelectedDisplay({Key? key}) : super(key: key);

  @override
  State<SelectedDisplay> createState() => _SelectedDisplayState();
}

class _SelectedDisplayState extends State<SelectedDisplay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/backgrounds/fuji.png'),
              fit: BoxFit.cover,
            )),
        ),),
        Positioned(
          child: Container(
            child: Cube(
              onSceneCreated: (Scene scene) {
                scene.world.add(Object(
                  fileName: 'assets/models/v4.obj',
                  scale: Vector3(13.0, 13.0, 13.0),
                  rotation: Vector3(270.0, 180.0, 0.0),
                  position: Vector3(-0.9, -4.0, 0.0),
                ));
              },
            ),
          )
        )
      ]
    );
  }
}
