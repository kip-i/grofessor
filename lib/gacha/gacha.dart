import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../state.dart';
import 'showdialog_background.dart';
import 'showdialog_nickname.dart';
import 'showdialog_skin.dart';


class Bubble extends StatelessWidget {
  final Widget child;

  const Bubble({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 40,
          child: ClipPath(
            clipper: ArrowClipper(),
            child: Container(
              width: 30,
              height: 20,
              color: Colors.yellow,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width / 2, size.height - 20);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class GachaPage extends StatefulWidget {
  @override
  GachaPageState createState() => GachaPageState();
}

class GachaPageState extends State<GachaPage> {
  ScrollController _scrollController1 = ScrollController();

  //int x = 10; // 現在の提出論文数が分かる
  //int y = 20; // 現在の引けるガチャの数が分かる
  
  String randomString =
      'Tap the button to generate random string'; // ランダムな文字列を表示するための変数

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    int x = dataProvider.paperNum;
    int y = dataProvider.gachaTicket;
    void generateRandomString() {
      print('なにもないよ');
      List<String> elements = dataProvider.notHaveNickNameIdList +
          dataProvider.notHaveCharacterIdList +
          dataProvider.notHaveBackgroundIdList;
      if (elements.isEmpty || y <= 0) {
        setState(() {
          randomString = 'もう出ないよ'; // 全ての要素が表示されたらガチャが引けなくなる
        });
        return;
      }

      Random random = Random();
      int randomIndex = random.nextInt(elements.length);
      String selectedElement = elements[randomIndex];

      setState(() {
        randomString = selectedElement;
        y = y - 1; // ガチャを引いたら'y'の値を1減らす
      });
      print(selectedElement);
      print(elements);
      if (selectedElement.startsWith('b')) {
        dataProvider.setNotHaveBackgroundIdList(selectedElement);
        showDialog_background(context);
      } else if (selectedElement.startsWith('n')) {
        dataProvider.setNotHaveNickNameIdList(selectedElement);
        showDialog_nickname(context);
      }else{
        dataProvider.setNotHaveCharacterIdList(selectedElement);
        showDialog_Skin(context);
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                       'assets/images/kirakira.jpg',
                      width: 380,
                      height: 380,
                      fit: BoxFit.cover,
                    ),
                   // SizedBox(height: 50),//プレゼントの高さを変える
                   Positioned(
                    top: 120, // Adjust this value to change the vertical position
                    child: Image.asset(
                      'assets/images/present.jpg',
                      width: 195,
                      height: 195,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
                ElevatedButton(
                  onPressed: generateRandomString,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                    side: BorderSide(color: Colors.transparent, width: 5),
                  ),
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 238, 238, 238),
                      border: Border(
                        top: BorderSide(color: Colors.red),
                        left: BorderSide(color: Colors.red, width: 15),
                        right: BorderSide(color: Colors.green, width: 15),
                        bottom: BorderSide(color: Colors.green),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'ガチャを引く',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '現在の提出論文数  :  $x',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '引けるガチャの数  :  $y ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController1,
                  child: Row(
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '    提 出 論 文 数   ➡   ',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 233, 233),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      for (var i = 0; i < 300; i++)
                        Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  color: (i + 1) % 3 == 0
                                      ? Colors.yellow
                                      : i.isEven
                                          ? Color.fromARGB(255, 116, 203, 44)
                                          : Color.fromARGB(255, 116, 203, 44),
                                  width: 110,
                                  height: 110,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          (i + 1).toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (i + 1 <= dataProvider.paperNum)
                              Positioned(
                                top: 38,
                                right: 40,
                                child: Transform.scale(
                                  scale: 1.5,
                                  child: Icon(Icons.check, color: Colors.black, size: 24 * 1.2),
                                ),
                              ),
                            if ((i + 1) % 3 == 0)
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Transform.scale(
                                  scale: 1.2,
                                  child: Icon(Icons.star, color: Color.fromARGB(255, 200, 210, 18)),
                                ),
                              ),
                            if ((i + 1) % 3 == 0)
                              Positioned(
                                top: 75,
                                right: -3,
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    'ごほうびゲット',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

mixin dataProvider {
}