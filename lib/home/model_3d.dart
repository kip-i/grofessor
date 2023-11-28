import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class model_3d extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Cube(
        onSceneCreated: (Scene scene) {
          scene.world.add(Object(
            fileName: 'assets/models/cube.obj',
            // scale: Vector3(10.0, 10.0, 10.0),
            // rotation: Vector3(270.0, 180.0, 0.0),
          ));
        },
      ),
    );
  }
}
