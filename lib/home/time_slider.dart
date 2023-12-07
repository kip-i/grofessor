import 'package:flutter/material.dart';
import '../const/color.dart';

class TimeSlider extends StatefulWidget {
  @override
  _TimeSliderState createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  double _value = 0; // 初期値

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-64, // 幅を指定
      height: 100.0, // 高さを指定
      decoration: BoxDecoration(
        //color: Colors.grey, // 背景色を灰色に設定
        borderRadius: BorderRadius.circular(8.0), // 角を丸くする
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // シャドウの方向（下に2ポイントずれ）
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('集中する時間を選択してください。',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Slider(
            value: _value,
            onChanged: (newValue) {
              setState(() {
                _value = newValue.toInt().toDouble();
              });
            },
            min: 0,
            max: 90,
            divisions: 18, // 分割数
            label: '${_value.round()}分', // スライダーの上に表示される値
            activeColor: Color.fromARGB(255, 226, 228, 226), // 値の色
          ),
        ],
      ),
    );
  }
}

