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
      'assets/models/m2.obj',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 列数
        crossAxisSpacing: 8.0, // 列間のスペース
        mainAxisSpacing: 100.0, // 行間のスペース
        childAspectRatio: 1 / 2, // アスペクト比
      ),
      itemCount: model_num,
      itemBuilder: (context, index) {
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
              color: selectedIndex == index ?  selectedColor : null,
              child: Container(
                padding: EdgeInsets.all(16), // カード内のコンテンツとの間隔を調整
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Cube(
                          onSceneCreated: (Scene scene) {
                            scene.world.add(Object(
                              fileName: getModelNames()[index],
                              scale: Vector3(13.0, 13.0, 13.0),
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
      },
    );
  }

}
