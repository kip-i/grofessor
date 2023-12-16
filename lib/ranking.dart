import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '_state.dart';
import 'state.dart';
import './home/name_button.dart';
import './home/experience_bar.dart';
import './const/color.dart';

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

}

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  List<Player> players = [];
  String rankingType = 'numberOfPapers';

  void changeRankingType(String type) {
    setState(() {
      rankingType = type;
    });
  }

  Widget _buildPlayerList(rankingProvider) {
    List<List<dynamic>> paperNumRanking = rankingProvider.paperNumRanking;
    List<List<dynamic>> sumTimeRanking = rankingProvider.sumTimeRanking;
    List<List<dynamic>> meanTimeRanking = rankingProvider.meanTimeRanking;
      
    List<List<dynamic>> ranking = [];
    List<List<dynamic>> tmp = [];

    const Color gold = Color.fromARGB(255, 230, 180, 34);
    const Color silver = Color.fromARGB(255, 189, 195, 201);
    const Color bronze = Color.fromARGB(255, 184, 115, 51);

    if (rankingType == 'numberOfPapers') {
      tmp = paperNumRanking;
    } else if (rankingType == 'totalStudyTime') {
      tmp = sumTimeRanking;
    } else if (rankingType == 'averageStudyTime') {
      tmp = meanTimeRanking;
    }
    for(int i=0;i<tmp.length;i++){
      if(tmp[i][0] != ''){
        ranking.add(tmp[i]);
      }
    }
    players = List.generate(ranking.length, (i) {
        return Player(
          ranking[i][0], // userName
          ranking[i][1], // nickName
          ranking[i][2], // numberOfPapers
          i + 1 // rank
        );
      });


    return Column(
      children: players.take(players.length).map((players) {
        String displayText;
        if (rankingType == 'numberOfPapers') {
          displayText =
              ' ${players.rank}位     ${players.userName}     ${players.score}枚';
        } else if (rankingType == 'totalStudyTime') {
          displayText =
              ' ${players.rank}位     ${players.userName}     ${int.parse(players.score)~/3600}：${(int.parse(players.score)%3600)~/60}：${int.parse(players.score)%60}';
        } else if (rankingType == 'averageStudyTime') {
          displayText =
              ' ${players.rank}位     ${players.userName}     ${double.parse(players.score).toInt()~/3600}：${(double.parse(players.score).toInt()%3600)~/60}：${double.parse(players.score).toInt()%60}';
        } else {
          displayText = ' ${players.rank}位     ${players.userName}';
        }
        
        return ListTile(
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  players.nickName,
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: players.rank == 1 ? gold : 
                           players.rank == 2 ? silver : 
                           players.rank == 3 ? bronze :
                   Colors.black,
                  ),
                ),
                Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    color: players.rank == 1 ? gold : 
                           players.rank == 2 ? silver : 
                           players.rank == 3 ? bronze :
                   Colors.black,
                  ),
                ),
              ],
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
        displayText = '${achieveProvider.paperNum}枚';
        break;
      case 'totalStudyTime':
        displayText = '${(achieveProvider.sumTime)~/3600}：${((achieveProvider.sumTime)%3600)~/60}：${(achieveProvider.sumTime)%60}';
        break;
      case 'averageStudyTime':
        displayText = '${(achieveProvider.meanTime)~/3600}：${((achieveProvider.meanTime)%3600)~/60}：${((achieveProvider.meanTime)%60).floor()}';
        break;
      default:
        displayText = '${userProvider.userName}';
    }
    return Column(
      children: [
        ListTile(
          title: const Text(
            '現在のあなたの記録は',
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
              color: Colors.black,
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
                    ? selectedColor
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
                      ),
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
                    ? selectedColor
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
                    ),
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
                    ? selectedColor
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
                    ),
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
