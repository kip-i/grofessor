import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_cube/flutter_cube.dart';
import 'package:provider/provider.dart';
import 'state.dart';
import './home/name_button.dart';
import './home/experience_bar.dart';

class Player {
  String userName;
  String nickName;
  String characterPath;
  String backgroundPath;
  int numberOfPapers;
  int totalStudyTime;
  int averageStudyTime;
  int rank;

  Player(
      this.userName,
      this.nickName,
      this.characterPath,
      this.backgroundPath,
      this.numberOfPapers,
      this.totalStudyTime,
      this.averageStudyTime,
      this.rank);

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        json['userName'],
        json['nickName'],
        json['characterPath'],
        json['backgroundPath'],
        json['numberOfPapers'],
        json['totalStudyTime'],
        json['averageStudyTime'],
        0);
  }
}

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  List<Player> players = [];
  String rankingType = 'numberOfPapers';

  @override
  void initState() {
    super.initState();
    _updateJsonData();
  }

  Future<void> _updateJsonData() async {
    String loadData = await rootBundle.loadString('user_data/user.json');
    List<dynamic> jsonData = jsonDecode(loadData);
    players = jsonData.map((item) => Player.fromJson(item)).toList();
    changeRankingType(rankingType);
    setState(() {});
  }

  void changeRankingType(String type) {
    setState(() {
      rankingType = type;
      players.sort((a, b) => getValue(b).compareTo(getValue(a)));
      for (int i = 0; i < players.length; i++) {
        players[i].rank = i + 1;
      }
    });
  }

  int getValue(Player player) {
    switch (rankingType) {
      case 'numberOfPapers':
        return player.numberOfPapers;
      case 'totalStudyTime':
        return player.totalStudyTime;
      case 'averageStudyTime':
        return player.averageStudyTime;
      default:
        return 0;
    }
  }

  Widget _buildPlayerList() {
    return Column(
      children: players.take(20).map((players) {
        String displayText;
        if (rankingType == 'numberOfPapers') {
          displayText =
              ' ${players.rank}位     ${players.nickName}     ${players.numberOfPapers}枚';
        } else if (rankingType == 'totalStudyTime') {
          displayText =
              ' ${players.rank}位     ${players.nickName}     ${players.totalStudyTime}分';
        } else if (rankingType == 'averageStudyTime') {
          displayText =
              ' ${players.rank}位     ${players.nickName}     ${players.averageStudyTime}分';
        } else {
          displayText = ' ${players.rank}位     ${players.nickName}';
        }
        return ListTile(
          title: Text(
            displayText,
            style: const TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.italic,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _playerScore(dataProvider) {
    String displayText;
    switch (rankingType) {
      case 'numberOfPapers':
        displayText = ' ${dataProvider.paperNum}枚';
        break;
      case 'totalStudyTime':
        displayText = ' ${dataProvider.sumTime}分';
        break;
      case 'averageStudyTime':
        displayText = ' ${dataProvider.meanTime}分';
        break;
      default:
        displayText = ' ${dataProvider.userName}';
    }
    return Column(
      children: [
        ListTile(
          title: const Text(
            'あなたの結果は',
            style: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            displayText,
            style: const TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ].toList(),
    );
  }

  Widget _kindOfRanking() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                rankingType = 'numberOfPapers';
                changeRankingType(rankingType);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: rankingType == 'numberOfPapers'
                    ? Colors.blue
                    : Colors.white,
                side: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Text(
                '論文数',
                style: TextStyle(
                    color: rankingType == 'numberOfPapers'
                        ? Colors.white
                        : Colors.black,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                rankingType = 'totalStudyTime';
                changeRankingType(rankingType);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: rankingType == 'totalStudyTime'
                    ? Colors.blue
                    : Colors.white,
                side: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Text(
                '合計時間',
                style: TextStyle(
                    color: rankingType == 'totalStudyTime'
                        ? Colors.white
                        : Colors.black,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                rankingType = 'averageStudyTime';
                changeRankingType(rankingType);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: rankingType == 'averageStudyTime'
                    ? Colors.blue
                    : Colors.white,
                side: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Text(
                '平均時間',
                style: TextStyle(
                    color: rankingType == 'averageStudyTime'
                        ? Colors.white
                        : Colors.black,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return MaterialApp(
      home: Scaffold(
          body: Stack(
        children: [
          Positioned(
            top: 30, // 上からの位置を指定します
            left: 16, // 左からの位置を指定します
            child: SizedBox(
              width: 200, // ここに希望の幅を設定します
              child: Column(
                children: [NameButton(), ExperienceBar()],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 180),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _kindOfRanking(),
                  _playerScore(dataProvider),
                  const SizedBox(height: 10),
                  _buildPlayerList(),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
