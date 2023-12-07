import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import '../const/color.dart';

class ModelTab extends StatefulWidget {
  @override
  State<ModelTab> createState() => _ModelTabState();
}

class _ModelTabState extends State<ModelTab> {
  int selectedIndex = 0;
  final int model_num = 3;
  // 仮の関数：画像名のリストを返す
  List<String> getModelNames() {
    return [
      'assets/models/m0.obj',
      'assets/models/m1.obj',
      
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 100.0,
        childAspectRatio: 1 / 1.4,
      ),
      itemCount: model_num,
      itemBuilder: (context, index) {
        if (index < getModelNames().length) {
          // 画像が存在する場合
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: SizedBox(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: selectedIndex == index ? selectedColor : null,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Cube(
                            onSceneCreated: (Scene scene) {
                              scene.world.add(Object(
                                fileName: getModelNames()[index],
                                scale: Vector3(15.0, 15.0, 15.0),
                                rotation: Vector3(270.0, 180.0, 0.0),
                                position: Vector3(-0.9, -4.0, 0.0),
                              ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          // 画像が存在しない場合
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/hatena/model_hatena.png'),
                  fit: BoxFit.cover,
                )
              )
            ),
          );
        }
      },
    );
  }
}
