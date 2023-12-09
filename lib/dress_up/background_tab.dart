import 'package:flutter/material.dart';

import 'package:grofessor/state.dart';
import 'package:provider/provider.dart';

import '../const/color.dart';

class BackgroundTab extends StatefulWidget {
  @override
  State<BackgroundTab> createState() => _BackgroundTabState();
}

class _BackgroundTabState extends State<BackgroundTab> {
  late int selectedIndex;
  late int background_num; // background_numが変わる場合、適宜調整してください


  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    dataProvider.getBackgroundId();
    selectedIndex = dataProvider.haveBackgroundIdList.indexOf(dataProvider.backgroundId);
    background_num = dataProvider.haveBackgroundIdList.length+ dataProvider.notHaveBackgroundIdList.length;
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
        if (index < dataProvider.haveBackgroundIdList.length) {
          // インデックスがリストの範囲内の場合
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              dataProvider.setBackgroundId(dataProvider.haveBackgroundIdList[index]);
              print(dataProvider.backgroundId);
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
                          'assets/backgrounds/'+dataProvider.haveBackgroundIdList[index] +'.png',
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
