import 'package:flutter/material.dart';
import 'dart:math';

class Player {
  String name;
  int book;
  int rank;

  Player(this.name, this.book, this.rank);
}

class ranking extends StatefulWidget {
  const ranking({Key? key}) : super(key: key);

  @override
  _rankingState createState() => _rankingState();
}

class _rankingState extends State<ranking> {
  @override
  Widget build(BuildContext context) {
    // プレイヤーデータの作成
    List<Player> players = List.generate(
      //リストを作成している
      15,
      (index) => Player(
        'ユーザー $index',
        Random().nextInt(75) + 1,
        0,
      ),
    );
    //Player('Player 1', 100,0),
    //Player('Player 2', 75,0),
    //Player('Player 3', 120,0),
    // 他のプレイヤーデータも追加できます

    // 得点でソート
    players.sort((a, b) => b.book.compareTo(a.book));

    // 順位を設定
    for (int i = 0; i < players.length; i++) {
      players[i].rank = i + 1;
    }

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
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '論文数順位',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // 順位とプレイヤー情報を表示
              Column(
                children: players.map((player) {
                  return ListTile(
                    title: Text(
                      ' ${player.rank}位     ${player.book}冊     ${player.name}',
                      style: TextStyle(
                        //  color: Colors.green,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    //  subtitle:Text('${player.name}   ${player.book}冊'),
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
