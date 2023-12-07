import 'package:flutter/material.dart';

import '../const/color.dart';

class BackgroundTab extends StatefulWidget {
  @override
  State<BackgroundTab> createState() => _BackgroundTabState();
}

class _BackgroundTabState extends State<BackgroundTab> {
  int selectedIndex = 0;
  final int background_num = 30; // background_numが変わる場合、適宜調整してください

  // 仮の関数：画像名のリストを返す
  List<String> getImageNames() {
    return [
      'assets/backgrounds/fuji.png',
      'assets/backgrounds/fuji.png',
      'assets/backgrounds/fuji.png',
      'assets/backgrounds/fuji.png',
      'assets/backgrounds/fuji.png',
      'assets/backgrounds/fuji.png',
      'assets/backgrounds/fuji.png',
      'assets/backgrounds/fuji.png',
      'assets/backgrounds/fuji.png',
      'assets/backgrounds/fuji.png'
    ];
  }

  @override
  Widget build(BuildContext context) {
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
        if (index < getImageNames().length) {
          // インデックスがリストの範囲内の場合
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          getImageNames()[index],
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
                )
              )
            ),
          );
        }
      },
    );
  }
}
