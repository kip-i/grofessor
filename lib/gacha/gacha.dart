import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../_state.dart';
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
  //int y = 20; // 現在の引けるごほうびの数が分かる
  
  String randomString =
      'Tap the button to generate random string'; // ランダムな文字列を表示するための変数
  // int y = 100;    //debug

  @override
  Widget build(BuildContext context) {
    final gachaProvider = Provider.of<GachaProvider>(context,listen: false);
    final achieveProvider = Provider.of<AchieveProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final haveItemProvider = Provider.of<HaveItemProvider>(context, listen: false);
    int x = achieveProvider.paperNum;
    // int x = 10;
    int y = gachaProvider.gachaTicket;
    // int y = 10;

    // gachaProvider.setGachaTicket(userProvider.userId, 1);
    void generateRandomString() {
      print('リスト生成'+gachaProvider.gachaTicket.toString());
      List<String> elements = 
          // gachaProvider.notHaveNickNameIdList;
          gachaProvider.notHaveNickNameIdList +
          gachaProvider.notHaveCharacterIdList +
          gachaProvider.notHaveBackgroundIdList;
          // gachaProvider.notHaveBackgroundIdList;
          // gachaProvider.notHaveCharacterIdList;
          // gachaProvider.notHaveNickNameIdList;
      print('y'+y.toString());
      print(gachaProvider.notHaveBackgroundIdList);
      print(gachaProvider.notHaveNickNameIdList);
      print(gachaProvider.notHaveCharacterIdList);

      if (elements.isEmpty || y <= 0) {
        setState(() {
          randomString = 'もう出ないよ'; // 全ての要素が表示されたらごほうびが引けなくなる
        });
        return;
      }      

      Random random = Random();
      int randomIndex = random.nextInt(elements.length);
      String selectedElement = elements[randomIndex];
      print('引く前'+ gachaProvider.gachaTicket.toString());
      setState(() {
        randomString = selectedElement;
        // y = y - 1; // ごほうびを引いたら'y'の値を1減らす
        gachaProvider.setGachaTicket(userProvider.userId, -1);
      });
      print('引く後' + gachaProvider.gachaTicket.toString());
      print('ごほうび排出：'+selectedElement.toString());
      print(elements);
      if (selectedElement.startsWith('b')) {
        gachaProvider.setNotHaveBackgroundIdList(userProvider.userId, selectedElement);
        haveItemProvider.setHaveBackgroundIdList(userProvider.userId, selectedElement);
        showDialogBackground(context, selectedElement);
      } else if (selectedElement.startsWith('n')) {
        gachaProvider.setNotHaveNickNameIdList(
            userProvider.userId, selectedElement);
        haveItemProvider.setHaveNickNameIdList(userProvider.userId, selectedElement);
        showDialogNickname(context, selectedElement);
      }else{
        gachaProvider.setNotHaveCharacterIdList(
            userProvider.userId, selectedElement);
        haveItemProvider.setHaveCharacterIdList(userProvider.userId, selectedElement);
        showDialogSkin(context, selectedElement);
      }
    }

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: 
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/kirakira.png'),
                  fit: BoxFit.cover,
                ),
              ),
            )
        ),
        Positioned(
          top: MediaQuery.of(context).size.width/2.3, // Adjust this value to change the vertical position
          left: 100,
          child: Image.asset(
            'assets/images/present.png',
            width: MediaQuery.of(context).size.width-200,
            height: MediaQuery.of(context).size.width-200,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height/2, // Adjust this value to change the vertical position
          left: MediaQuery.of(context).size.width/2-110,
          child: ElevatedButton(
            onPressed: generateRandomString,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              side: const BorderSide(color: Colors.transparent, width: 5),
            ),
            child: Container(
              width: 200,
              height: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 238, 238, 238),
                border: Border(
                  top: BorderSide(color: Colors.red),
                  left: BorderSide(color: Colors.red, width: 15),
                  right: BorderSide(color: Colors.green, width: 15),
                  bottom: BorderSide(color: Colors.green),
                ),
              ),
              child: const Center(
                child: Text(
                  'ごほうびを引く',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top:MediaQuery.of(context).size.height/2 + 80,
          left: 30,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '論文の数  :  $x',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2 + 80,
          right: 30 ,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '引ける数  :  $y ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 2 + 150,
          left: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // controller: _scrollController1,
            child: Row(
              children: [
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      '    提 出 論 文 数   ➡   ',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 233, 233),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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
                                    ? const Color.fromARGB(255, 116, 203, 44)
                                    : const Color.fromARGB(255, 116, 203, 44),
                            width: 110,
                            height: 110,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (i + 1).toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (i + 1 <= x)
                        Positioned(
                          top: 38,
                          right: 40,
                          child: Transform.scale(
                            scale: 1.5,
                            child: const Icon(Icons.check, color: Colors.black, size: 24 * 1.2),
                          ),
                        ),
                      if ((i + 1) % 3 == 0)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Transform.scale(
                            scale: 1.2,
                            child: const Icon(Icons.star, color: Color.fromARGB(255, 200, 210, 18)),
                          ),
                        ),
                      if ((i + 1) % 3 == 0)
                        Positioned(
                          top: 75,
                          right: -3,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              'ごほうびゲット',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
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
        )
        ),

      ],
    );
  }
}
