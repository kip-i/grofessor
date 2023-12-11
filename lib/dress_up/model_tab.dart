import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:grofessor/_state.dart';
import '../const/color.dart';
import 'package:grofessor/state.dart';
import 'package:provider/provider.dart';

class ModelTab extends StatefulWidget {
  @override
  State<ModelTab> createState() => _ModelTabState();
}

class _ModelTabState extends State<ModelTab> {
  late int selectedIndex;
  final int model_num = 3;

  @override
  Widget build(BuildContext context) {
    // final dataProvider = Provider.of<DataProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final characterProvider = Provider.of<CharacterProvider>(context);
    final haveItemProvider = Provider.of<HaveItemProvider>(context);
    // dataProvider.getCharacterId();
    // selectedIndex =
    //     dataProvider.haveCharacterIdList.indexOf(dataProvider.characterId);
    selectedIndex = haveItemProvider.haveCharacterIdList
        .indexOf(characterProvider.characterId); // ここでエラーが出る
    return GridView.builder(
      shrinkWrap: true, // スクロール可能にする
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 100.0,
        childAspectRatio: 1 / 1.4,
      ),
      itemCount: model_num,
      itemBuilder: (context, index) {
        // if (index < dataProvider.haveCharacterIdList.length) {
        if (index < haveItemProvider.haveCharacterIdList.length) {
          // 画像が存在する場合
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              // dataProvider
              //     .setCharacterId(dataProvider.haveCharacterIdList[index]);
              // print(dataProvider.characterId);
              characterProvider.setCharacter(userProvider.userId,
                  haveItemProvider.haveCharacterIdList[index]);
              print(characterProvider.characterId);
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
                                fileName: 'assets/models/' +
                                    // dataProvider.haveCharacterIdList[index] +
                                    haveItemProvider
                                        .haveCharacterIdList[index] +
                                    '.obj',
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
            ))),
          );
        }
      },
    );
  }
}
