import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class Player {
  String userName;
  String nickName;
  String character;
  String backGround;
  int numberOfPapers;
  int totalStudyTime;
  int averageStudyTime;
  int rank;

  Player(
      this.userName,
      this.nickName,
      this.character,
      this.backGround,
      this.numberOfPapers,
      this.totalStudyTime,
      this.averageStudyTime,
      this.rank);

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        json['userName'],
        json['nickName'],
        json['character'],
        json['background'],
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
    await loadJsonAsset();
    setState(() {});
  }

  Future<void> loadJsonAsset() async {
    String loadData = await rootBundle.loadString('user_data/user.json');
    List<dynamic> jsonData = jsonDecode(loadData);
    players = jsonData.map((item) => Player.fromJson(item)).toList();
    players.sort((a, b) => b.numberOfPapers.compareTo(a.numberOfPapers));
    for (int i = 0; i < players.length; i++) {
      players[i].rank = i + 1;
    }
  }

  void sortPlayers() {
    switch (rankingType) {
      case 'numberOfPapers':
        players.sort((a, b) => b.numberOfPapers.compareTo(a.numberOfPapers));
        debugPrint('numberOfPapers');
        break;
      case 'totalStudyTime':
        players.sort((a, b) => b.totalStudyTime.compareTo(a.totalStudyTime));
        debugPrint('totalStudyTime');
        break;
      case 'averageStudyTime':
        players
            .sort((a, b) => b.averageStudyTime.compareTo(a.averageStudyTime));
        debugPrint('averageStudyTime');
        break;
    }
    for (int i = 0; i < players.length; i++) {
      players[i].rank = i + 1;
    }
  }

  void changeRankingType(String type) {
    setState(() {
      rankingType = type;
    });
    sortPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            '順位表',
            style: TextStyle(
              color: Colors.green,
              fontSize: 24,
              fontStyle: FontStyle.italic,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => changeRankingType('numberOfPapers'),
                    child: Text('論文数順位'),
                  ),
                  ElevatedButton(
                    onPressed: () => changeRankingType('totalStudyTime'),
                    child: Text('総学習時間順位'),
                  ),
                  ElevatedButton(
                    onPressed: () => changeRankingType('averageStudyTime'),
                    child: Text('平均学習時間順位'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: players.map((player) {
                  String displayText;
                  switch (rankingType) {
                    case 'numberOfPapers':
                      displayText =
                          ' ${player.rank}位     ${player.numberOfPapers}冊     ${player.nickName}';
                      break;
                    case 'totalStudyTime':
                      displayText =
                          ' ${player.rank}位     ${player.totalStudyTime}時間     ${player.nickName}';
                      break;
                    case 'averageStudyTime':
                      displayText =
                          ' ${player.rank}位     ${player.averageStudyTime}時間/回     ${player.nickName}';
                      break;
                    default:
                      displayText = ' ${player.rank}位     ${player.nickName}';
                  }
                  return ListTile(
                    title: Text(
                      displayText,
                      style: TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
