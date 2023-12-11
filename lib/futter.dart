import 'package:flutter/material.dart';
import 'home/home_selector.dart';
import 'home/home_default.dart';
import 'home/home_during_time.dart';
import 'dress_up/dress_up.dart';
import 'schedule.dart';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        canvasColor: const Color.fromARGB(255, 163, 74, 74),
      ),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = <Widget>[
    // ここを自身のウィジェットに変更したらいい
    Schedule(),//時間割
    DressUp(),
    HomeSelector(),
    HomeDefault(),
    HomeDefault(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    print('ページ：futter.dart');
    return Scaffold(
      body: IndexedStack(
        index: _currentPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 226, 228, 226), // フッター部分の背景色を変更
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              5,
              (index) => _buildIconButton(
                index,
                index == _currentPageIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(int index, bool isSelected) {
    IconData icon;
    String label;

    switch (index) {
      case 0:
        icon = Icons.calendar_today;
        label = '時間割';
        break;
      case 1:
        icon = Icons.accessibility_new;
        label = '着せ替え';
        break;
      case 2:
        icon = Icons.home;
        label = 'ホーム';
        break;
      case 3:
        icon = Icons.card_giftcard;
        label = 'ガチャ';
        break;
      case 4:
        icon = Icons.leaderboard;
        label = 'ランキング';
        break;
      default:
        throw Exception('Invalid index');
    }

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentPageIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Color.fromARGB(255, 191, 193, 192)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: isSelected ? 32.0 : 24.0,
                color: isSelected
                    ? const Color(0xFF00753F)
                    : Color.fromARGB(255, 80, 81, 80),
              ),
              SizedBox(height: 4.0),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF00753F)
                      : Color.fromARGB(255, 80, 81, 80),
                  fontSize: 12.5,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
