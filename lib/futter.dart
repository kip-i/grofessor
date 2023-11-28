import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 235, 223, 223), // フッターの中の背景色
        padding: EdgeInsets.symmetric(vertical: 8.0), // 上下の余白を追加
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0, // フッターの影を削除
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // 5等分
            children: <Widget>[
              _buildIconButton(Icons.calendar_today, '時間割', Colors.green, context, fontSize: 13.5),
              _buildIconButton(Icons.accessibility, '着せ替え', Colors.green, context, fontSize: 13.5),
              _buildIconButton(Icons.home, 'ホーム', Colors.green, context, fontSize: 13.5),
              _buildIconButton(Icons.card_giftcard, 'ガチャ', Colors.green, context, fontSize: 13.5),
              _buildIconButton(Icons.star, 'ランキング', Colors.green, context, fontSize: 13.5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, Color iconColor, BuildContext context, {double fontSize = 14.0}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey)), // 上部に境界線を追加
        ),
        child: InkWell(
          onTap: () {
            // アイコンがタップされた時の処理
          },
          splashColor: Colors.green.withOpacity(0.3), // タップ時のエフェクトの色と透明度
          borderRadius: BorderRadius.circular(1.0), // タップ時のエフェクトの形状
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center, // 中央寄せ
            children: <Widget>[
              Icon(icon, size: 1.6 * 24.0, color: Colors.green), // アイコンのサイズを1.5倍に大きくする
              SizedBox(height: 4.0),
              Text(
                label,
                style: TextStyle(color: Colors.green, fontSize: fontSize),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis, // 要素がはみ出る場合は省略記号で表示
                maxLines: 1, // 1行に制限
              ), // 中央寄せ
            ],
          ),
        ),
      ),
    );
  }
}
