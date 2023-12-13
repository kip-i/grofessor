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
  String randomString = 'Tap the button to generate random string';

  @override
  Widget build(BuildContext context) {
    final gachaProvider = Provider.of<GachaProvider>(context,listen: false);
    final achieveProvider = Provider.of<AchieveProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final haveItemProvider = Provider.of<HaveItemProvider>(context, listen: false);
    int paperNum = achieveProvider.paperNum;
    int gachaTicket = gachaProvider.gachaTicket;

    void generateRandomString() {
      List<String> elements = gachaProvider.notHaveNickNameIdList +
          gachaProvider.notHaveCharacterIdList +
          gachaProvider.notHaveBackgroundIdList;

      if (elements.isEmpty || gachaTicket <= 0) {
        setState(() {
          randomString = 'もう出ないよ';
        });
        return;
      }      

      Random random = Random();
      int randomIndex = random.nextInt(elements.length);
      String selectedElement = elements[randomIndex];
      setState(() {
        randomString = selectedElement;
        gachaProvider.setGachaTicket(userProvider.userId, -1);
      });

      if (selectedElement.startsWith('b')) {
        gachaProvider.setNotHaveBackgroundIdList(userProvider.userId, selectedElement);
        haveItemProvider.setHaveBackgroundIdList(userProvider.userId, selectedElement);
        showDialogBackground(context, selectedElement);
      } else if (selectedElement.startsWith('n')) {
        gachaProvider.setNotHaveNickNameIdList(userProvider.userId, selectedElement);
        haveItemProvider.setHaveNickNameIdList(userProvider.userId, selectedElement);
        showDialogNickname(context, selectedElement);
      }else{
        gachaProvider.setNotHaveCharacterIdList(userProvider.userId, selectedElement);
        haveItemProvider.setHaveCharacterIdList(userProvider.userId, selectedElement);
        showDialogSkin(context, selectedElement);
      }
    }

    return Stack(
      children: [
        _buildBackground(context),
        _buildPresentImage(context),
        _buildGachaButton(context, generateRandomString),
        _buildPaperNumDisplay(context, paperNum),
        _buildGachaTicketDisplay(context, gachaTicket),
        _buildScrollingPaperNum(context, paperNum),
      ],
    );
  }

  Positioned _buildBackground(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/kirakira.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Positioned _buildPresentImage(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.width/2.3,
      left: 100,
      child: Image.asset(
        'assets/images/present.png',
        width: MediaQuery.of(context).size.width-200,
        height: MediaQuery.of(context).size.width-200,
        fit: BoxFit.cover,
      ),
    );
  }

  Positioned _buildGachaButton(BuildContext context, VoidCallback generateRandomString) {
    return Positioned(
      top: MediaQuery.of(context).size.height/2,
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
    );
  }

  Positioned _buildPaperNumDisplay(BuildContext context, int paperNum) {
    return Positioned(
      top: MediaQuery.of(context).size.height/2 + 80,
      left: 30,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '論文の数  :  $paperNum',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildGachaTicketDisplay(BuildContext context, int gachaTicket) {
    return Positioned(
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
            '引ける数  :  $gachaTicket ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildScrollingPaperNum(BuildContext context, int paperNum) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 + 150,
      left: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildPaperNumContainer(),
            const SizedBox(width: 15),
            _buildScrollingPaperList(paperNum),
          ],
        ),
      ),
    );
  }

  Container _buildPaperNumContainer() {
    return Container(
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
    );
  }

  SingleChildScrollView _buildScrollingPaperList(int paperNum) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Row(
        children: [
          for (var i = 0; i < 300; i++)
            _buildPaperStack(i, paperNum),
        ],
      ),
    );
  }

  Stack _buildPaperStack(int i, int paperNum) {
    return Stack(
      children: [
        _buildPaperColumn(i),
        if (i + 1 <= paperNum)
          _buildCheckIcon(),
        if ((i + 1) % 3 == 0)
          _buildStarIcon(),
        if ((i + 1) % 3 == 0)
          _buildRewardContainer(),
      ],
    );
  }

  Column _buildPaperColumn(int i) {
    return Column(
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
    );
  }

  Positioned _buildCheckIcon() {
    return Positioned(
      top: 38,
      right: 40,
      child: Transform.scale(
        scale: 1.5,
        child: const Icon(Icons.check, color: Colors.black, size: 24 * 1.2),
      ),
    );
  }

  Positioned _buildStarIcon() {
    return Positioned(
      top: 5,
      right: 5,
      child: Transform.scale(
        scale: 1.2,
        child: const Icon(Icons.star, color: Color.fromARGB(255, 200, 210, 18)),
      ),
    );
  }

  Positioned _buildRewardContainer() {
    return Positioned(
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
    );
  }
}