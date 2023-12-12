import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '_state.dart';
import 'state.dart';
import './home/name_button.dart';
import './home/experience_bar.dart';

class Player {
  String userName;
  String nickName;
  String score;
  int rank;

  Player(
    this.userName,
    this.nickName,
    this.score,
    this.rank);

  // factory Player.fromJson(Map<String, dynamic> json) {
  //   return Player(
  //       json['nickName'],
  //       json['numberOfPapers'],
  //       0);
  // }
}

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  List<Player> players = [];
  String rankingType = 'numberOfPapers';

  // @override
  // void initState() {
  //   super.initState();
  //   _updateJsonData();
  // }

  // Future<void> _updateJsonData() async {
  //   String loadData = await rootBundle.loadString('user_data/user.json');
  //   List<dynamic> jsonData = jsonDecode(loadData);
  //   players = jsonData.map((item) => Player.fromJson(item)).toList();
  //   changeRankingType(rankingType);
  //   setState(() {});
  // }

  void changeRankingType(String type) {
    setState(() {
      rankingType = type;
      // players.sort((a, b) => getValue(b).compareTo(getValue(a)));
      // for (int i = 0; i < players.length; i++) {
      //   players[i].rank = i + 1;
      // }
    });
  }

  // int getValue(Player player) {
  //   switch (rankingType) {
  //     case 'numberOfPapers':
  //       return player.numberOfPapers;
  //     case 'totalStudyTime':
  //       return player.totalStudyTime;
  //     case 'averageStudyTime':
  //       return player.averageStudyTime;
  //     default:
  //       return 0;
  //   }
  // }

  Widget _buildPlayerList(rankingProvider) {
    List<List<dynamic>> paperNumRanking = rankingProvider.paperNumRanking;
    List<List<dynamic>> sumTimeRanking = rankingProvider.sumTimeRanking;
    List<List<dynamic>> meanTimeRanking = rankingProvider.meanTimeRanking;
    
    
  if (rankingType == 'numberOfPapers') {
    players = List.generate(paperNumRanking.length, (i) {
      if(paperNumRanking[i][0] != ''){
        return Player(
          paperNumRanking[i][0], // userName
          paperNumRanking[i][1], // nickName
          paperNumRanking[i][2], // numberOfPapers
          i + 1 // rank
        );
      }
    });
  } else if (rankingType == 'totalStudyTime') {
    players = List.generate(sumTimeRanking.length, (i) {
      if(sumTimeRanking[i][0] != ''){
        return Player(
          sumTimeRanking[i][0], // userName
          sumTimeRanking[i][1], // nickName
          sumTimeRanking[i][2], // numberOfPapers
          i + 1 // rank
        );
      }
    });
  } else if (rankingType == 'averageStudyTime') {
    players = List.generate(meanTimeRanking.length, (i) {
      if(meanTimeRanking[i][0] != ''){
        
        return Player(
          meanTimeRanking[i][0], // userName
          meanTimeRanking[i][1], // nickName
          meanTimeRanking[i][2], // numberOfPapers
          i + 1 // rank
        );
      }
      return null;
    });
  }
    return Column(
      children: players.take(players.length).map((players) {
        String displayText;
        if (rankingType == 'numberOfPapers') {
          displayText =
              ' ${players.rank}位     ${players.userName}     ${players.score}枚';
        } else if (rankingType == 'totalStudyTime') {
          displayText =
              ' ${players.rank}位     ${players.userName}     ${players.score}分';
        } else if (rankingType == 'averageStudyTime') {
          displayText =
              ' ${players.rank}位     ${players.userName}     ${players.score}分';
        } else {
          displayText = ' ${players.rank}位     ${players.userName}';
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

  Widget _playerScore(achieveProvider,userProvider) {
    String displayText;
    switch (rankingType) {
      case 'numberOfPapers':
        displayText = ' ${achieveProvider.paperNum}枚';
        break;
      case 'totalStudyTime':
        displayText = ' ${achieveProvider.sumTime}分';
        break;
      case 'averageStudyTime':
        displayText = ' ${achieveProvider.meanTime}分';
        break;
      default:
        displayText = ' ${userProvider.userName}';
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
    final rankingProvider = Provider.of<RankingProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final achieveProvider = Provider.of<AchieveProvider>(context, listen: false);
    
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
                  _playerScore(achieveProvider,userProvider),
                  const SizedBox(height: 10),
                  _buildPlayerList(rankingProvider),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
