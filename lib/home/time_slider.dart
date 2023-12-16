import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TimeSlider extends StatefulWidget {
  TimeSlider({Key? key}) : super(key: key);


  @override
  TimeSliderState createState() => TimeSliderState();
}

class TimeSliderState extends State<TimeSlider> {
  double _value = 25; // 初期値

  @override
  void initState() {
    super.initState();
    _loadSliderValue();
  }

    _loadSliderValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _value = (prefs.getDouble('sliderValue') ?? 25);
    });
  }

  _saveSliderValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('sliderValue', _value);
  }

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
            offset: const Offset(0, 2), // シャドウの方向（下に2ポイントずれ）
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('集中する時間を選択してください。',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Slider(
            value: _value,
            onChanged: (newValue) {
              setState(() {
                _value = newValue.toInt().toDouble();
              });
              _saveSliderValue();
            },
            min: 5,
            max: 90,
            divisions: 17, // 分割数
            label: '${_value.round()}分', // スライダーの上に表示される値
            activeColor: const Color.fromARGB(255, 226, 228, 226), // 値の色
          ),
        ],
      ),
    );
  }
}

