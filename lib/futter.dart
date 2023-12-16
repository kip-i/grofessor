import 'package:flutter/material.dart';
import '_state.dart';
import 'home/home_selector.dart';
import 'home/home_default.dart';
import 'home/home_during_time.dart';
import 'dress_up/dress_up.dart';
import 'home/home_state.dart';
import 'ranking.dart';
import 'package:provider/provider.dart';
import 'state.dart';
import 'gacha/gacha.dart';
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
  int _currentPageIndex = 2;

  final List<Widget> _pages = <Widget>[
    // ここを自身のウィジェットに変更したらいい
    Schedule(),//時間割
    DressUp(),
    HomeSelector(),
    GachaPage(),
    Ranking(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final rankingProvider = Provider.of<RankingProvider>(context);

    final homeProvider = Provider.of<HomeProvider>(context);
    final classProvider = Provider.of<ClassProvider>(context);

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
                rankingProvider,
                homeProvider,
                classProvider,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(int index, bool isSelected, RankingProvider rankingProvider, HomeProvider homeProvider, ClassProvider classProvider) {
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
        label = 'ごほうび';
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
        onTap: () async {
          if (index == 4) {
            // Todo: 日時取得
            await rankingProvider.setRanking();
            debugPrint('ランキング!!!');
          }
          if (index == 2) {
            // Todo: 日時取得
            await update(homeProvider, classProvider);
            print('ホーム!!!');
          }
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


  Future<void> update(homeProvider, classProvider) async {
    List<List<int>> classTime = classProvider.classTimeList;
    List<List<bool>> classFlagList = classProvider.classFlagList;

    DateTime now = DateTime.now().toUtc().add(const Duration(hours: 9));
    DateTime before = now.add(const Duration(minutes: 3));
    // 曜日を取得
    int dayOfWeek = now.weekday;
    
    int nowHour = now.hour;
    int nowMinute = now.minute;
    int tmpHour = before.hour;
    int tmpMinute = before.minute;
    print('$tmpHour:$tmpMinute');
    print('$nowHour:$nowMinute');

    // 現在の時刻がどの時間割に該当するかを判断
    int currentPeriod = -1;
    for (int i = 0; i < classTime.length; i++) {
      if (tmpHour > classTime[i][0] || (tmpHour == classTime[i][0] && tmpMinute >= classTime[i][1])) {
        if (nowHour < classTime[i][2] || (nowHour == classTime[i][2] && nowMinute < classTime[i][3])) {
          if (classFlagList[dayOfWeek - 1][i] == true) {
            currentPeriod = i + 1; // 時間割は1から始まると仮定
            break;
          }
        }
      }
    }

    // 授業中かどうかを判断
    if (currentPeriod != -1) {
      print('現在は $currentPeriod 限目の授業中です。');
      homeProvider.setDuring(true);
    } else {
      print('現在は授業時間外です。');
      homeProvider.setDuring(false);
    }
  }

}
