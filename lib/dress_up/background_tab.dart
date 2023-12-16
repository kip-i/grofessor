import 'package:flutter/material.dart';

import 'package:grofessor/state.dart';
import 'package:provider/provider.dart';

import '../_state.dart';
import '../const/color.dart';

class BackgroundTab extends StatefulWidget {
  @override
  State<BackgroundTab> createState() => _BackgroundTabState();
}

class _BackgroundTabState extends State<BackgroundTab> {
  late int selectedIndex;
  final int background_num = 30; // background_numが変わる場合、適宜調整してください

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final backgroundProvider = Provider.of<BackgroundProvider>(context);
    final haveItemProvider = Provider.of<HaveItemProvider>(context);
    selectedIndex = haveItemProvider.haveBackgroundIdList
        .indexOf(backgroundProvider.backgroundId);
    return GridView.builder(
      shrinkWrap: true, // スクロール可能にする
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 列数
        crossAxisSpacing: 8.0, // 列間のスペース
        mainAxisSpacing: 8.0, // 行間のスペース
        childAspectRatio: 1 / 1.2, // アスペクト比
      ),
      itemCount: background_num,
      itemBuilder: (context, index) {
        if (index < haveItemProvider.haveBackgroundIdList.length) {
          // インデックスがリストの範囲内の場合
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              backgroundProvider.setBackground(userProvider.userId,
                  haveItemProvider.haveBackgroundIdList[index]);
              print(backgroundProvider.backgroundId);
            },
            child: SizedBox(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: selectedIndex == index ? selectedColor : null,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          'assets/backgrounds/' +
                              haveItemProvider.haveBackgroundIdList[index] +
                              '.png',
                          fit: BoxFit.contain, // 画像をカードに合わせて拡大・縮小
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          // インデックスがリストの範囲外の場合は何も表示しない
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
              image: AssetImage('assets/hatena/background_hatena.png'),
              fit: BoxFit.cover,
            ))),
          );
        }
      },
    );
  }
}
