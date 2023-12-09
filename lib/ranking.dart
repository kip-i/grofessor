import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'state.dart';

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
    String loadData = await rootBundle.loadString('user_data/user.json');
    List<dynamic> jsonData = jsonDecode(loadData);
    players = jsonData.map((item) => Player.fromJson(item)).toList();
    changeRankingType(rankingType);
    setState(() {});
  }

  void changeRankingType(String type) {
    setState(() {
      rankingType = type;
      switch (rankingType) {
        case 'numberOfPapers':
          players.sort((a, b) => b.numberOfPapers.compareTo(a.numberOfPapers));
          break;
        case 'totalStudyTime':
          players.sort((a, b) => b.totalStudyTime.compareTo(a.totalStudyTime));
          break;
        case 'averageStudyTime':
          players
              .sort((a, b) => b.averageStudyTime.compareTo(a.averageStudyTime));
          break;
      }
      for (int i = 0; i < players.length; i++) {
        players[i].rank = i + 1;
      }
    });
  }

  Widget _buildPlayerList() {
    return Column(
      children: players.map((players) {
        String displayText;
        displayText =
            ' ${players.rank}位     ${players.character}     ${players.nickName}';
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
    // String displayText = ' ${dataProvider.userName}枚';
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

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
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
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => changeRankingType('numberOfPapers'),
                          child: const Text('論文数'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => changeRankingType('totalStudyTime'),
                          child: const Text('合計時間'),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              changeRankingType('averageStudyTime'),
                          child: const Text('平均時間'),
                        ),
                      ),
                    ],
                  ),
                ),
                _playerScore(dataProvider),
                const SizedBox(height: 20),
                _buildPlayerList(),
              ],
            ),
          )),
    );
  }
}
