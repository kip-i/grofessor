import 'package:flutter/material.dart';
import '../const/color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../sample_provider.dart';
import '../sample_screen.dart';

class MeasurementsStart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(sampleScreenProvider.notifier); // コントローラーを取得

    return Container(
      width: 160.0, // 幅を指定
      height: 70.0, // 高さを指定
      child: ElevatedButton(
          onPressed: () {
            controller.startTimer();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SampleScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: blackbordColor, // ボタンの背景色
            foregroundColor: blackbordWhiteColor, // テキストの色
            padding: EdgeInsets.all(6.0), // ボタンの内側の余白
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer,
                size: 43.0,
                color: blackbordWhiteColor,
              ),
              Container(
                margin: EdgeInsets.all(4.0),
                child: Text(
                  '執筆開始',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

//使えそうなIcon
//Play Arrow, timer
