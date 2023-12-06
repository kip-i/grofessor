import 'package:flutter/material.dart';

import '../const/color.dart';

class BackgroundTab extends StatefulWidget {
  @override
  State<BackgroundTab> createState() => _BackgroundTabState();
}

class _BackgroundTabState extends State<BackgroundTab> {
  int selectedIndex = 0;

  // 仮の関数：画像名のリストを返す
  List<String> getImageNames() {
    return [
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b0.png'
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
      itemCount: getImageNames().length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: SizedBox(
            height: 1800,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: selectedIndex == index ? selectedColor : null,
              child: Container(
                padding: EdgeInsets.all(16), // カード内のコンテンツとの間隔を調整
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        getImageNames()[index],
                        fit: BoxFit.cover, // 画像をカードに合わせて拡大・縮小
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
