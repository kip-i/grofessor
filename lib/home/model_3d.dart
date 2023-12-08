import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class Model3D extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Cube(
        onSceneCreated: (Scene scene) {
          scene.world.add(Object(
            //fileName: 'assets/models/v4.obj',
            fileName: 'assets/models/m1.obj',
            scale: Vector3(8.0, 8.0, 8.0),
            rotation: Vector3(270.0, 180.0, 0.0),
            position: Vector3(-0.4, -1.5, 0.0),
          ));
        },
      ),
    );
  }
}
