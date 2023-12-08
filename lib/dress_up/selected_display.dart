import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:grofessor/state.dart';
import 'package:provider/provider.dart';


class SelectedDisplay extends StatefulWidget {
  const SelectedDisplay({Key? key}) : super(key: key);

  @override
  State<SelectedDisplay> createState() => _SelectedDisplayState();
}

class _SelectedDisplayState extends State<SelectedDisplay> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    dataProvider.getCharacterId();
    return Stack(
      children: [
        Positioned(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 10 / 14 - 70,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/backgrounds/'+ dataProvider.backgroundId.toString()+'.png'),
              fit: BoxFit.cover,
            )),
        ),),
        Positioned(
          child: Container(
            child: Cube(
              onSceneCreated: (Scene scene) {
                scene.world.add(Object(
                  fileName: 'assets/models/'+dataProvider.characterId.toString()+'.obj',
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
