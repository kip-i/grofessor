import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'firebase_service.dart';

class UserProvider extends ChangeNotifier {
  bool login = false;
  String msg = '';
  // bool get isLogin => login;
  String userId = '';
  String userName = '';

  Future<void> notify() async {
    notifyListeners();
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    List<String> tmp = await AuthService().signIn(userName);
    // msg = tmp[1];
    if (tmp[1] == "Success") {
      login = true;
      userId = tmp[0];
    } else {
      login = false;
    }
    // notifyListeners(); // Add this line
    print('正常更新:${login}');
    notifyListeners(); // Add this line
  }

  Future<void> initUser(String _userName, String _gender) async {
    List<String> tmp = await AuthService().createUser(_userName, _gender);
    msg = tmp[1];
    if (tmp[1] == "Success") {
      login = true;
      userId = tmp[0];
      userName = _userName; // notifyListeners();

      await FirebaseService().createUser(userId, userName, _gender);

      final prefs = await SharedPreferences.getInstance();

      prefs.setString('userName', userName);
    } else {
      login = false;
      // msg = tmp[1];
      // print(msg);
      notifyListeners();
    }
  }
}

class NickNameProvider extends ChangeNotifier {
  String nickNameId = ''; // n0
  String nickName = '';

  Future<void> init() async {
    nickNameId = 'n0';
    nickName = '研究生';

    final prefs = await SharedPreferences.getInstance();

    prefs.setString('nickNameId', nickNameId);
    prefs.setString('nickName', nickName);

    // notifyListeners();
  }

  Future<void> getNickName() async {
    final prefs = await SharedPreferences.getInstance();
    nickNameId = prefs.getString('nickNameId') ?? 'n0';
    nickName = prefs.getString('nickName') ?? '研究生';
    notifyListeners(); // Add this line
  }

  Future<void> setNickName(
      String _userId, String _nickNameId, String _nickName) async {
    nickNameId = _nickNameId;
    nickName = _nickName;
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nickNameId', nickNameId);
    prefs.setString('nickName', nickName);

    await FirebaseService().updateNickNameId(_userId, nickNameId);
    await FirebaseService().updateNickName(_userId, nickName);

    notifyListeners();
  }
}

class CharacterProvider extends ChangeNotifier {
  String gender = ''; // m or w
  String characterId = ''; // (m or w)0
  String characterPath = ''; // assets/models/(m or w)0.obj

  Future<void> init(String _gender) async {
    gender = _gender;
    characterId = '${gender}0';
    characterPath = 'assets/models/${gender}0.obj';

    final prefs = await SharedPreferences.getInstance();

    prefs.setString('gender', gender);
    prefs.setString('characterId', characterId);
    prefs.setString('characterPath', characterPath);

    // notifyListeners();
  }

  Future<void> getCharacter() async {
    final prefs = await SharedPreferences.getInstance();
    gender = prefs.getString('gender') ?? 'm';
    characterId = prefs.getString('characterId') ?? 'm0';
    characterPath = prefs.getString('characterPath') ?? 'assets/models/m0.obj';
    notifyListeners(); // Add this line
  }

  Future<void> setCharacter(String _userId, String _characterId) async {
    characterId = _characterId;
    characterPath = 'assets/models/${characterId}.obj';
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('characterId', characterId);
    prefs.setString('characterPath', characterPath);

    await FirebaseService().updateCharacter(_userId, characterId);

    notifyListeners();
  }
}

class BackgroundProvider extends ChangeNotifier {
  String backgroundId = ''; // b0
  String backgroundPath = ''; // assets/backgrounds/b0.png

  Future<void> init() async {
    backgroundId = 'b0';
    backgroundPath = 'assets/backgrounds/b0.png';

    final prefs = await SharedPreferences.getInstance();

    prefs.setString('backgroundId', backgroundId);
    prefs.setString('backgroundPath', backgroundPath);

    // notifyListeners();
  }

  Future<void> getBackground() async {
    final prefs = await SharedPreferences.getInstance();
    backgroundId = prefs.getString('backgroundId') ?? 'b0';
    backgroundPath =
        prefs.getString('backgroundPath') ?? 'assets/backgrounds/b0.png';
    notifyListeners(); // Add this line
  }

  Future<void> setBackground(String _userId, String _backgroundId) async {
    backgroundId = _backgroundId;
    backgroundPath = 'assets/backgrounds/${_backgroundId}.png';
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('backgroundId', backgroundId);
    prefs.setString('backgroundPath', backgroundPath);

    await FirebaseService().updateBackgroundId(_userId, _backgroundId);

    notifyListeners();
  }
}

class GachaProvider extends ChangeNotifier {
  int gachaTicket = 0;
  List<String> notHaveNickNameIdList = []; // n1,n2
  List<String> notHaveCharacterIdList = []; // (m or w)1,(m or w)2
  List<String> notHaveBackgroundIdList = []; // b1,b2
  List<String> allNickNameList = [];

  Future<void> init(String _gender) async {
    gachaTicket = 0;
    // notHaveNickNameIdList = ['n1', 'n2'];
    notHaveNickNameIdList = await FirebaseService().getAllNickNameId();
    notHaveNickNameIdList.remove('n0');
    // notHaveCharacterIdList = ['${_gender}1', '${_gender}2'];
    // notHaveCharacterIdList = ['${_gender}2'];
    notHaveCharacterIdList = await FirebaseService().getAllCharacterId(_gender);
    notHaveCharacterIdList.remove('${_gender}0');
    // notHaveBackgroundIdList = ['b1', 'b2'];
    // notHaveBackgroundIdList = ['b2'];
    notHaveBackgroundIdList = await FirebaseService().getAllBackgroundId();
    notHaveBackgroundIdList.remove('b0');

    allNickNameList = await FirebaseService().getAllNickName();

    // print(notHaveNickNameIdList);
    // print(notHaveCharacterIdList);
    // print(notHaveBackgroundIdList);
    // print(notHaveNickNameList);

    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('gachaTicket', gachaTicket);
    prefs.setStringList('notHaveNickNameList', notHaveNickNameIdList);
    prefs.setStringList('notHaveCharacterList', notHaveCharacterIdList);
    prefs.setStringList('notHaveBackgroundList', notHaveBackgroundIdList);
    prefs.setStringList('allNickNameList', allNickNameList);

    // notifyListeners();
  }

  Future<void> getGacha() async {
    final prefs = await SharedPreferences.getInstance();
    gachaTicket = prefs.getInt('gachaTicket') ?? 0;
    notHaveNickNameIdList = prefs.getStringList('notHaveNickNameIdList') ?? [];
    notHaveCharacterIdList =
        prefs.getStringList('notHaveCharacterIdList') ?? [];
    notHaveBackgroundIdList =
        prefs.getStringList('notHaveBackgroundIdList') ?? [];
    allNickNameList = prefs.getStringList('allNickNameList') ?? [];

    // print(notHaveNickNameList);

    notifyListeners(); // Add this line
  }

  Future<void> setGachaTicket(String _userId, int _number) async {
    gachaTicket = gachaTicket + _number;
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('gachaTicket', gachaTicket);

    await FirebaseService().updateGachaTicket(_userId, _number);

    notifyListeners();
  }

  Future<void> setNotHaveNickNameIdList(
      String _userId, String _nickNameId) async {
    notHaveNickNameIdList.remove(_nickNameId);
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveNickNameIdList', notHaveNickNameIdList);

    await FirebaseService().deleteNotHaveNickName(_userId, _nickNameId);

    notifyListeners();
  }

  Future<void> setNotHaveCharacterIdList(
      String _userId, String _characterId) async {
    notHaveCharacterIdList.remove(_characterId);
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveCharacterIdList', notHaveCharacterIdList);

    await FirebaseService().deleteNotHaveCharacter(_userId, _characterId);

    notifyListeners();
  }

  Future<void> setNotHaveBackgroundIdList(
      String _userId, String _backgroundId) async {
    notHaveBackgroundIdList.remove(_backgroundId);
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveBackgroundIdList', notHaveBackgroundIdList);

    await FirebaseService().deleteNotHaveBackground(_userId, _backgroundId);

    notifyListeners();
  }
}

class AchieveProvider extends ChangeNotifier {
  int paperNum = 0;
  int sumTime = 0;
  int thisTime = 0;
  int needTime = 0;
  int achieveNum = 0;
  double meanTime = 0;
  bool penalty = false;

  Future<void> init() async {
    paperNum = 0;
    sumTime = 0;
    thisTime = 0;
    needTime = await FirebaseService().getNeedTime(paperNum);
    achieveNum = 0;
    meanTime = 0.0;
    penalty = false;

    final prefs = await SharedPreferences.getInstance();

    prefs.setInt('paperNum', paperNum);
    prefs.setInt('sumTime', sumTime);
    prefs.setInt('thisTime', thisTime);
    prefs.setInt('needTime', needTime);
    prefs.setInt('achieveNum', achieveNum);
    prefs.setDouble('meanTime', meanTime);
    prefs.setBool('penalty', penalty);

    // notifyListeners();
  }

  Future<void> getAchieve() async {
    final prefs = await SharedPreferences.getInstance();
    paperNum = prefs.getInt('paperNum') ?? 0;
    sumTime = prefs.getInt('sumTime') ?? 0;
    thisTime = prefs.getInt('thisTime') ?? 0;
    needTime = prefs.getInt('needTime') ?? 0;
    achieveNum = prefs.getInt('achieveNum') ?? 0;
    meanTime = prefs.getDouble('meanTime') ?? 0;
    penalty = prefs.getBool('penalty') ?? false;
    notifyListeners(); // Add this line
  }

  Future<void> setAchieve(
      String _userId, int _paperNum, int _time, bool _penalty) async {
    sumTime = sumTime + _time;
    thisTime = thisTime + _time;
    if (thisTime >= needTime) {
      paperNum = paperNum + 1;
      needTime = await FirebaseService().getNeedTime(paperNum);
      thisTime = thisTime - needTime;
    }
    achieveNum = achieveNum + 1;
    meanTime = sumTime / achieveNum;
    penalty = _penalty;
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('paperNum', paperNum);
    prefs.setInt('sumTime', sumTime);
    prefs.setInt('thisTime', thisTime);
    prefs.setInt('needTime', needTime);
    prefs.setInt('achieveNum', achieveNum);
    prefs.setDouble('meanTime', meanTime);
    prefs.setBool('penalty', penalty);

    await FirebaseService().updateAchieve(_userId, _penalty, _time);

    notifyListeners();
  }
}

class HaveItemProvider extends ChangeNotifier {
  List<String> haveNickNameIdList = []; // n0
  List<String> haveNickNameList = []; // 研究生
  List<String> haveCharacterIdList = []; // (m or w)0
  List<String> haveCharacterPathList = []; // assets/models/(m or w)0.obj
  List<String> haveBackgroundIdList = []; // b0
  List<String> haveBackgroundPathList = []; // assets/backgrounds/b0.png
  int totalNickNameNum = 0;
  int totalCharacterNum = 0;
  int totalBackgroundNum = 0;

  Future<void> init(String _gender) async {
    haveNickNameIdList = ['n0'];
    haveNickNameList = ['研究生'];
    // haveCharacterIdList = ['${_gender}0'];
    haveCharacterIdList = ['${_gender}0', '${_gender}1'];
    // haveCharacterPathList = ['assets/models/${_gender}0.obj'];
    haveCharacterPathList = [
      'assets/models/${_gender}0.obj',
      'assets/models/${_gender}0.obj'
    ];
    // haveBackgroundIdList = ['b0'];
    haveBackgroundIdList = ['b0', 'b1'];
    // haveBackgroundPathList = ['assets/backgrounds/b0.png'];
    haveBackgroundPathList = [
      'assets/backgrounds/b0.png',
      'assets/backgrounds/b1.png'
    ];
    totalNickNameNum = await FirebaseService().getTotalNickNameNum();
    totalCharacterNum = await FirebaseService().getTotalCharacterNum();
    totalBackgroundNum = await FirebaseService().getTotalBackgroundNum();

    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList('haveNickNameIdList', haveNickNameIdList);
    prefs.setStringList('haveNickNameList', haveNickNameList);
    prefs.setStringList('haveCharacterIdList', haveCharacterIdList);
    prefs.setStringList('haveCharacterPathList', haveCharacterPathList);
    prefs.setStringList('haveBackgroundIdList', haveBackgroundIdList);
    prefs.setStringList('haveBackgroundPathList', haveBackgroundPathList);
    prefs.setInt('totalNickNameNum', totalNickNameNum);
    prefs.setInt('totalCharacterNum', totalCharacterNum);
    prefs.setInt('totalBackgroundNum', totalBackgroundNum);

    // notifyListeners();
  }

  Future<void> getHaveItemList() async {
    final prefs = await SharedPreferences.getInstance();
    haveNickNameIdList = prefs.getStringList('haveNickNameIdList') ?? [];
    haveNickNameList = prefs.getStringList('haveNickNameList') ?? [];
    haveCharacterIdList = prefs.getStringList('haveCharacterIdList') ?? [];
    haveCharacterPathList = prefs.getStringList('haveCharacterPathList') ?? [];
    haveBackgroundIdList = prefs.getStringList('haveBackgroundIdList') ?? [];
    haveBackgroundPathList =
        prefs.getStringList('haveBackgroundPathList') ?? [];
    totalNickNameNum = prefs.getInt('totalNickNameNum') ?? 0;
    totalCharacterNum = prefs.getInt('totalCharacterNum') ?? 0;
    totalBackgroundNum = prefs.getInt('totalBackgroundNum') ?? 0;

    notifyListeners(); // Add this line
  }

  Future<void> setHaveNickNameIdList(String _userId, String _nickNameId) async {
    haveNickNameIdList.add(_nickNameId);
    String _nickName = await FirebaseService().getNickName(_nickNameId);
    haveNickNameList.add(_nickName);
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveNickNameIdList', haveNickNameIdList);
    prefs.setStringList('haveNickNameList', haveNickNameList);

    await FirebaseService().addHaveNickName(_userId, _nickNameId);

    notifyListeners();
  }

  Future<void> setHaveCharacterIdList(
      String _userId, String _characterId) async {
    haveCharacterIdList.add(_characterId);
    haveCharacterPathList.add('assets/models/${_characterId}.obj');
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveCharacterIdList', haveCharacterIdList);
    prefs.setStringList('haveCharacterPathList', haveCharacterPathList);

    await FirebaseService().addHaveCharacter(_userId, _characterId);

    notifyListeners();
  }

  Future<void> setHaveBackgroundIdList(
      String _userId, String _backgroundId) async {
    haveBackgroundIdList.add(_backgroundId);
    haveBackgroundPathList.add('assets/backgrounds/${_backgroundId}.png');
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveBackgroundIdList', haveBackgroundIdList);
    prefs.setStringList('haveBackgroundPathList', haveBackgroundPathList);

    await FirebaseService().addHaveBackground(_userId, _backgroundId);

    notifyListeners();
  }
}

class ClassProvider extends ChangeNotifier {
  List<List<bool>> classFlagList = []; // 6*6
  List<List<int>> classTimeList = []; // 6*4

  Future<void> init() async {
    classFlagList = [
      [false, false, false, false, false, false],
      [false, false, false, false, false, false],
      [false, false, false, false, false, false],
      [false, false, false, false, false, false],
      [false, false, false, false, false, false],
      [false, false, false, false, false, false],
    ];
    classTimeList = [
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
    ];

    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList(
        'classFlagList',
        classFlagList
            .map((e) => e.map((e) => e ? '1' : '0').toList())
            .toList()
            .expand((e) => e)
            .toList());
    prefs.setStringList(
        'classTimeList',
        classTimeList
            .map((e) => e.map((e) => e.toString()).toList())
            .toList()
            .expand((e) => e)
            .toList());

    // notifyListeners();
  }

  Future<void> getClassList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = prefs.getStringList('classFlagList') ?? [];
    List<String> tmp2 = prefs.getStringList('classTimeList') ?? [];
    classFlagList = [];
    classTimeList = [];

    for (int i = 0; i < tmp.length; i += 6) {
      classFlagList.add(
          tmp.sublist(i, i + 6).map((e) => e == '1' ? true : false).toList());
    }
    for (int i = 0; i < tmp2.length; i += 4) {
      classTimeList
          .add(tmp2.sublist(i, i + 4).map((e) => int.parse(e)).toList());
    }
    notifyListeners(); // Add this line
  }

  Future<void> setClassFlagList(String _userId, int row, int column) async {
    classFlagList[row][column] = !classFlagList[row][column];
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = classFlagList
        .map((e) => e.map((e) => e ? '1' : '0').toList())
        .toList()
        .expand((e) => e)
        .toList();
    prefs.setStringList('classFlagList', tmp);

    await FirebaseService().updateClassExisteSchedule(_userId, classFlagList);

    notifyListeners();
  }

  Future<void> setClassStartTimeList(
      String _userId, List<int> _classTimeList, int row) async {
    classTimeList[row][0] = _classTimeList[0];
    classTimeList[row][1] = _classTimeList[1];
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = classTimeList
        .map((e) => e.map((e) => e.toString()).toList())
        .toList()
        .expand((e) => e)
        .toList();
    prefs.setStringList('classTimeList', tmp);

    await FirebaseService().updateClassTimeSchedule(_userId, classTimeList);

    notifyListeners();
  }

  Future<void> setClassFinishTimeList(
      String _userId, List<int> _classTimeList, int row) async {
    classTimeList[row][2] = _classTimeList[0];
    classTimeList[row][3] = _classTimeList[1];
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = classTimeList
        .map((e) => e.map((e) => e.toString()).toList())
        .toList()
        .expand((e) => e)
        .toList();
    prefs.setStringList('classTimeList', tmp);

    await FirebaseService().updateClassTimeSchedule(_userId, classTimeList);

    notifyListeners();
  }
}

class RankingProvider extends ChangeNotifier {
  List<List<dynamic>> paperNumRanking = []; // 10*4
  List<List<dynamic>> sumTimeRanking = []; // 10*4
  List<List<dynamic>> meanTimeRanking = []; // 10*4

  Future<void> init() async {
    // paperNumRanking = [];
    // sumTimeRanking = [];
    // meanTimeRanking = [];
    await setRanking();

    // notifyListeners();
  }

  Future<void> getRanking() async {
    final prefs = await SharedPreferences.getInstance();
    paperNumRanking = [];
    sumTimeRanking = [];
    meanTimeRanking = [];
    for (int i = 0; i < 10; i++) {
      paperNumRanking.add(prefs.getStringList('paperNumRanking${i + 1}') ?? []);
      sumTimeRanking.add(prefs.getStringList('sumTimeRanking${i + 1}') ?? []);
      meanTimeRanking.add(prefs.getStringList('meanTimeRanking${i + 1}') ?? []);
    }
    notifyListeners(); // Add this line
  }

  Future<void> setRanking() async {
    List<List<dynamic>> tmp = await FirebaseService().getRanking();

    print('ランキング：' + tmp.toString());
    paperNumRanking = [];
    sumTimeRanking = [];
    meanTimeRanking = [];
    for (int i = 0; i < 10; i++) {
      paperNumRanking.add([
        tmp[0][i][0],
        tmp[0][i][1],
        tmp[0][i][2],
      ]);
      sumTimeRanking.add([
        tmp[1][i][0],
        tmp[1][i][1],
        tmp[1][i][2],
      ]);
      meanTimeRanking.add([
        tmp[2][i][0],
        tmp[2][i][1],
        tmp[2][i][2],
      ]);
    }
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 10; i++) {
      prefs.setStringList('paperNumRanking${i + 1}', [
        tmp[0][i][0],
        tmp[0][i][1],
        tmp[0][i][2],
      ]);
      prefs.setStringList('sumTimeRanking${i + 1}', [
        tmp[1][i][0],
        tmp[1][i][1],
        tmp[1][i][2],
      ]);
      prefs.setStringList('meanTimeRanking${i + 1}', [
        tmp[2][i][0],
        tmp[2][i][1],
        tmp[2][i][2],
      ]);

      notifyListeners();
    }
  }
}
