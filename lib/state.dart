import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'firebase_service.dart';

// final counterProvider = ChangeNotifierProvider((ref) => DataProvider());

class classProvider extends ChangeNotifier {
  bool login = false;
  // bool get isLogin => login;
  String userId = '';
  String userName = '';

  String nickNameId = ''; // n0
  String nickName = '';

  String gender = ''; // m or w
  String characterId = 'm2'; // (m or w)0
  String characterPath = ''; // assets/models/(m or w)0.obj

  String backgroundId = 'b1'; // b0
  String backgroundPath = ''; // assets/backgrounds/b0.png

  int gachaTicket = 0;
  List<String> notHaveNickNameIdList = []; // n1,n2
  List<String> notHaveCharacterIdList = []; // (m or w)1,(m or w)2
  List<String> notHaveBackgroundIdList = []; // b1,b2

  int paperNum = 0;
  int sumTime = 0;
  int thisTime = 0;
  int needTime = 0;
  int achieveNum = 0;
  double meanTime = 0;
  bool penalty = false;

  List<String> haveNickNameIdList = []; // n0
  List<String> haveNickNameList = []; // 研究生
  List<String> haveCharacterIdList = ['m0', 'm2']; // (m or w)0
  List<String> haveCharacterPathList = []; // assets/models/(m or w)0.obj
  List<String> haveBackgroundIdList = ['b0', 'b1', 'b2']; // b0
  List<String> haveBackgroundPathList = []; // assets/backgrounds/b0.png

  List<List<bool>> classFlagList = []; // 6*6
  List<List<int>> classTimeList = []; // 6*4

  List<List<dynamic>> paperNumRanking = []; // 10*4
  List<List<dynamic>> sumTimeRanking = []; // 10*4
  List<List<dynamic>> meanTimeRanking = []; // 10*4

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';

    nickNameId = prefs.getString('nickNameId') ?? '';
    nickName = prefs.getString('nickName') ?? '';

    gender = prefs.getString('gender') ?? '';
    characterId = prefs.getString('characterId') ?? '';
    characterPath = prefs.getString('characterPath') ?? '';

    backgroundId = prefs.getString('backgroundId') ?? '';
    backgroundPath = prefs.getString('backgroundPath') ?? '';

    gachaTicket = prefs.getInt('gachaTicket') ?? 0;
    notHaveNickNameIdList = prefs.getStringList('notHaveNickNameIdList') ?? [];
    notHaveCharacterIdList =
        prefs.getStringList('notHaveCharacterIdList') ?? [];
    notHaveBackgroundIdList =
        prefs.getStringList('notHaveBackgroundIdList') ?? [];

    paperNum = prefs.getInt('paperNum') ?? 0;
    sumTime = prefs.getInt('sumTime') ?? 0;
    thisTime = prefs.getInt('thisTime') ?? 0;
    needTime = prefs.getInt('needTime') ?? 0;
    achieveNum = prefs.getInt('achieveNum') ?? 0;
    meanTime = prefs.getDouble('meanTime') ?? 0;
    penalty = prefs.getBool('penalty') ?? false;

    haveNickNameIdList = prefs.getStringList('haveNickNameIdList') ?? [];
    haveNickNameList = prefs.getStringList('haveNickNameList') ?? [];
    haveCharacterIdList = prefs.getStringList('haveCharacterIdList') ?? [];
    haveCharacterPathList = prefs.getStringList('haveCharacterPathList') ?? [];
    haveBackgroundIdList = prefs.getStringList('haveBackgroundIdList') ?? [];
    haveBackgroundPathList =
        prefs.getStringList('haveBackgroundPathList') ?? [];

    classFlagList = [];
    List<String> tmp = prefs.getStringList('classFlagList') ?? [];
    for (int i = 0; i < tmp.length; i += 6) {
      classFlagList.add(
          tmp.sublist(i, i + 6).map((e) => e == '1' ? true : false).toList());
    }

    classTimeList = [];
    tmp = prefs.getStringList('classTimeList') ?? [];
    for (int i = 0; i < tmp.length; i += 4) {
      classTimeList
          .add(tmp.sublist(i, i + 4).map((e) => int.parse(e)).toList());
    }

    paperNumRanking = [];
    for (int i = 0; i < 10; i++) {
      paperNumRanking.add(prefs.getStringList('paperNumRanking${i + 1}') ?? []);
    }
    sumTimeRanking = [];
    for (int i = 0; i < 10; i++) {
      sumTimeRanking.add(prefs.getStringList('sumTimeRanking${i + 1}') ?? []);
    }
    meanTimeRanking = [];
    for (int i = 0; i < 10; i++) {
      meanTimeRanking.add(prefs.getStringList('meanTimeRanking${i + 1}') ?? []);
    }

    notifyListeners();
  }

  Future<void> getUserId() async {
    // getUseName();
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    List<String> tmp = await AuthService().signIn(userName);
    if (tmp[1] == "Success") {
      login = true;
      userId = tmp[0];
    } else {
      login = false;
    }
    notifyListeners(); // Add this line
    print('正常更新:${login}');
  }

  void getUseName() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    notifyListeners(); // Add this line
  }

  void getNickNameId() async {
    final prefs = await SharedPreferences.getInstance();
    nickNameId = prefs.getString('nickNameId') ?? '';
    notifyListeners(); // Add this line
  }

  void getNickName() async {
    final prefs = await SharedPreferences.getInstance();
    nickName = prefs.getString('nickName') ?? '';
    notifyListeners(); // Add this line
  }

  void getGender() async {
    final prefs = await SharedPreferences.getInstance();
    gender = prefs.getString('gender') ?? '';
    notifyListeners(); // Add this line
  }

  void getCharacterId() async {
    final prefs = await SharedPreferences.getInstance();
    characterId = prefs.getString('characterId') ?? '';
    notifyListeners(); // Add this line
  }

  // void getCharacter() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   character = prefs.getString('character') ?? '';
  //   notifyListeners(); // Add this line
  // }

  void getCharacterPath() async {
    final prefs = await SharedPreferences.getInstance();
    characterPath = prefs.getString('characterPath') ?? '';
    notifyListeners(); // Add this line
  }

  void getBackgroundId() async {
    final prefs = await SharedPreferences.getInstance();
    backgroundId = prefs.getString('backgroundId') ?? '';
    notifyListeners(); // Add this line
  }

  void getBackgroundPath() async {
    final prefs = await SharedPreferences.getInstance();
    backgroundPath = prefs.getString('backgroundPath') ?? '';
    notifyListeners(); // Add this line
  }

  void getGachaTicket() async {
    final prefs = await SharedPreferences.getInstance();
    gachaTicket = prefs.getInt('gachaTicket') ?? 0;
    notifyListeners(); // Add this line
  }

  void getNotHaveNickNameIdList() async {
    final prefs = await SharedPreferences.getInstance();
    notHaveNickNameIdList = prefs.getStringList('notHaveNickNameIdList') ?? [];
    notifyListeners(); // Add this line
  }

  void getNotHaveCharacterIdList() async {
    final prefs = await SharedPreferences.getInstance();
    notHaveCharacterIdList =
        prefs.getStringList('notHaveCharacterIdList') ?? [];
    notifyListeners(); // Add this line
  }

  void getNotHaveBackgroundIdList() async {
    final prefs = await SharedPreferences.getInstance();
    notHaveBackgroundIdList =
        prefs.getStringList('notHaveBackgroundIdList') ?? [];
    notifyListeners(); // Add this line
  }

  void getPaperNum() async {
    final prefs = await SharedPreferences.getInstance();
    paperNum = prefs.getInt('paperNum') ?? 0;
    notifyListeners(); // Add this line
  }

  void getSumTime() async {
    final prefs = await SharedPreferences.getInstance();
    sumTime = prefs.getInt('sumTime') ?? 0;
    notifyListeners(); // Add this line
  }

  void getThisTime() async {
    final prefs = await SharedPreferences.getInstance();
    thisTime = prefs.getInt('thisTime') ?? 0;
    notifyListeners(); // Add this line
  }

  void getNeedTime() async {
    final prefs = await SharedPreferences.getInstance();
    needTime = prefs.getInt('needTime') ?? 0;
    notifyListeners(); // Add this line
  }

  void getAchieveNum() async {
    final prefs = await SharedPreferences.getInstance();
    achieveNum = prefs.getInt('achieveNum') ?? 0;
    notifyListeners(); // Add this line
  }

  void getMeanTime() async {
    final prefs = await SharedPreferences.getInstance();
    meanTime = prefs.getDouble('meanTime') ?? 0;
    notifyListeners(); // Add this line
  }

  void getPenalty() async {
    final prefs = await SharedPreferences.getInstance();
    penalty = prefs.getBool('penalty') ?? false;
    notifyListeners(); // Add this line
  }

  void getHaveNickNameIdList() async {
    final prefs = await SharedPreferences.getInstance();
    haveNickNameIdList = prefs.getStringList('haveNickNameIdList') ?? [];
    notifyListeners(); // Add this line
  }

  void getHaveNickNameList() async {
    final prefs = await SharedPreferences.getInstance();
    haveNickNameList = prefs.getStringList('haveNickNameList') ?? [];
    notifyListeners(); // Add this line
  }

  void getHaveCharacterIdList() async {
    final prefs = await SharedPreferences.getInstance();
    haveCharacterIdList = prefs.getStringList('haveCharacterIdList') ?? [];
    notifyListeners(); // Add this line
  }

  void getHaveCharacterPathList() async {
    final prefs = await SharedPreferences.getInstance();
    haveCharacterPathList = prefs.getStringList('haveCharacterPathList') ?? [];
    notifyListeners(); // Add this line
  }

  void getHaveBackgroundIdList() async {
    final prefs = await SharedPreferences.getInstance();
    haveBackgroundIdList = prefs.getStringList('haveBackgroundIdList') ?? [];
    notifyListeners(); // Add this line
  }

  void getHaveBackgroundPathList() async {
    final prefs = await SharedPreferences.getInstance();
    haveBackgroundPathList =
        prefs.getStringList('haveBackgroundPathList') ?? [];
    notifyListeners(); // Add this line
  }

  void getClassList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = prefs.getStringList('classFlagList') ?? [];
    List<String> tmp2 = prefs.getStringList('classTimeList') ?? [];
    classFlagList = [];
    classTimeList = [];

    for (int i = 0; i < tmp.length; i += 6) {
      classFlagList.add(
          tmp.sublist(i, i + 6).map((e) => e == '1' ? true : false).toList());
    }
    for (int i = 0; i < tmp.length; i += 4) {
      classTimeList
          .add(tmp2.sublist(i, i + 4).map((e) => int.parse(e)).toList());
    }
    notifyListeners(); // Add this line
  }

  // void getClassFlagList() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> tmp = prefs.getStringList('classFlagList') ?? [];
  //   classFlagList = [];
  //   for (int i=0; i<tmp.length; i+=6){
  //     classFlagList.add(tmp.sublist(i,i+6).map((e) => e=='1' ? true : false).toList());
  //   }
  //   notifyListeners(); // Add this line
  // }

  // void getClassTimeList() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> tmp = prefs.getStringList('classTimeList') ?? [];
  //   classTimeList = [];
  //   for (int i=0; i<tmp.length; i+=4){
  //     classTimeList.add(tmp.sublist(i,i+4).map((e) => int.parse(e)).toList());
  //   }
  //   notifyListeners(); // Add this line
  // }

  void getRanking() async {
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

  // void getPaperNumRanking() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   paperNumRanking = [];
  //   for (int i=0; i<10; i++){
  //     paperNumRanking.add(prefs.getStringList('paperNumRanking${i+1}') ?? []);
  //   }
  //   notifyListeners(); // Add this line
  // }

  // void getSumTimeRanking() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   sumTimeRanking = [];
  //   for (int i=0; i<10; i++){
  //     sumTimeRanking.add(prefs.getStringList('sumTimeRanking${i+1}') ?? []);
  //   }
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking1st') ?? []);
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking2nd') ?? []);
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking3rd') ?? []);
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking4th') ?? []);
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking5th') ?? []);
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking6th') ?? []);
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking7th') ?? []);
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking8th') ?? []);
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking9th') ?? []);
  //   // sumTimeRanking.add(prefs.getStringList('sumTimeRanking10th') ?? []);
  //   notifyListeners(); // Add this line
  // }

  // void getMeanTimeRanking() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   meanTimeRanking = [];
  //   for (int i=0; i<10; i++){
  //     meanTimeRanking.add(prefs.getStringList('meanTimeRanking${i+1}') ?? []);
  //   }
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking1st') ?? []);
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking2nd') ?? []);
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking3rd') ?? []);
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking4th') ?? []);
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking5th') ?? []);
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking6th') ?? []);
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking7th') ?? []);
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking8th') ?? []);
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking9th') ?? []);
  //   // meanTimeRanking.add(prefs.getStringList('meanTimeRanking10th') ?? []);
  //   notifyListeners(); // Add this line
  // }

  Future<void> setUser(String _userName, String _gender) async {
    List<String> tmp = await AuthService().createUser(_userName, _gender);
    if (tmp[1] == "Success") {
      login = true;
      userId = tmp[0];

      userName = _userName;

      nickNameId = 'n0';
      nickName = '研究生';

      gender = _gender;
      characterId = '${gender}0';
      characterPath = 'assets/models/${characterId}.obj';

      backgroundId = 'b0';
      backgroundPath = 'assets/backgrounds/b0.png';

      gachaTicket = 0;
      notHaveNickNameIdList = ['n1', 'n2'];
      notHaveCharacterIdList = ['${gender}1', '${gender}2'];
      notHaveBackgroundIdList = ['b1', 'b2'];

      paperNum = 0;
      sumTime = 0;
      thisTime = 0;
      needTime = 0;
      achieveNum = 0;
      meanTime = 0;
      penalty = false;

      haveNickNameIdList = ['n0'];
      haveNickNameList = ['研究生'];
      haveCharacterIdList = ['${characterId}'];
      haveCharacterPathList = ['assets/models/${characterId}.obj'];
      haveBackgroundIdList = ['b0'];
      haveBackgroundPathList = ['assets/backgrounds/b0.png'];

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

      paperNumRanking = [];
      sumTimeRanking = [];
      meanTimeRanking = [];

      // notifyListeners();

      await FirebaseService().createUser(userId, userName, gender);

      final prefs = await SharedPreferences.getInstance();

      prefs.setString('userName', userName);
      prefs.setString('nickNameId', nickNameId);
      prefs.setString('nickName', nickName);

      prefs.setString('gender', gender);
      prefs.setString('characterId', characterId);
      prefs.setString('characterPath', characterPath);
      prefs.setString('backgroundId', backgroundId);
      prefs.setString('backgroundPath', backgroundPath);

      prefs.setInt('gachaTicket', gachaTicket);
      prefs.setStringList('notHaveNickNameList', notHaveNickNameIdList);
      prefs.setStringList('notHaveCharacterList', notHaveCharacterIdList);
      prefs.setStringList('notHaveBackgroundList', notHaveBackgroundIdList);

      prefs.setInt('paperNum', paperNum);
      prefs.setInt('sumTime', sumTime);
      prefs.setInt('thisTime', thisTime);
      prefs.setInt('needTime', needTime);
      prefs.setInt('achieveNum', achieveNum);
      prefs.setInt('meanTime', 0);
      prefs.setInt('penalty', 0);

      prefs.setStringList('haveNickNameIdList', haveNickNameIdList);
      prefs.setStringList('haveNickNameList', haveNickNameList);
      prefs.setStringList('haveCharacterIdList', haveCharacterIdList);
      prefs.setStringList('haveCharacterPathList', haveCharacterPathList);
      prefs.setStringList('haveBackgroundIdList', haveBackgroundIdList);
      prefs.setStringList('haveBackgroundPathList', haveBackgroundPathList);

      prefs.setStringList('classFlagList', [
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0'
      ]);
      prefs.setStringList('classTimeList', [
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0',
        '0'
      ]);

      for (int i = 0; i < 10; i++) {
        prefs.setStringList('paperNumRanking${i + 1}', []);
        prefs.setStringList('sumTimeRanking${i + 1}', []);
        prefs.setStringList('meanTimeRanking${i + 1}', []);
      }
      // prefs.setStringList('paperNumRanking1st', []);
      // prefs.setStringList('paperNumRanking2nd', []);
      // prefs.setStringList('paperNumRanking3rd', []);
      // prefs.setStringList('paperNumRanking4th', []);
      // prefs.setStringList('paperNumRanking5th', []);
      // prefs.setStringList('paperNumRanking6th', []);
      // prefs.setStringList('paperNumRanking7th', []);
      // prefs.setStringList('paperNumRanking8th', []);
      // prefs.setStringList('paperNumRanking9th', []);
      // prefs.setStringList('paperNumRanking10th', []);

      // prefs.setStringList('sumTimeRanking1st', []);
      // prefs.setStringList('sumTimeRanking2nd', []);
      // prefs.setStringList('sumTimeRanking3rd', []);
      // prefs.setStringList('sumTimeRanking4th', []);
      // prefs.setStringList('sumTimeRanking5th', []);
      // prefs.setStringList('sumTimeRanking6th', []);
      // prefs.setStringList('sumTimeRanking7th', []);
      // prefs.setStringList('sumTimeRanking8th', []);
      // prefs.setStringList('sumTimeRanking9th', []);
      // prefs.setStringList('sumTimeRanking10th', []);

      // prefs.setStringList('meanTimeRanking1st', []);
      // prefs.setStringList('meanTimeRanking2nd', []);
      // prefs.setStringList('meanTimeRanking3rd', []);
      // prefs.setStringList('meanTimeRanking4th', []);
      // prefs.setStringList('meanTimeRanking5th', []);
      // prefs.setStringList('meanTimeRanking6th', []);
      // prefs.setStringList('meanTimeRanking7th', []);
      // prefs.setStringList('meanTimeRanking8th', []);
      // prefs.setStringList('meanTimeRanking9th', []);
      // prefs.setStringList('meanTimeRanking10th', []);
    } else {
      login = false;
      // notifyListeners();
    }
    notifyListeners();
  }

  // void setUserName(String _userName) async {
  //   userName = _userName;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('userName', userName);
  //   // notifyListeners(); // Add this line
  //   await FirebaseService().updateUserName(userId, userName);
  // }

  void setNickNameId(String _nickNameId) async {
    nickNameId = _nickNameId;
    // notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nickNameId', nickNameId);
    // notifyListeners(); // Add this line
    await FirebaseService().updateNickNameId(userId, nickNameId);

    notifyListeners();
  }

  void setNickName(String _nickName) async {
    nickName = _nickName;
    // notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nickName', nickName);
    // notifyListeners(); // Add this line
    await FirebaseService().updateNickName(userId, nickName);

    notifyListeners();
  }

  // void setGender(String _gender) async{
  //   gender = _gender;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('gender',gender);
  // }

  void setCharacterId(String _characterId) async {
    characterId = _characterId;
    // character = gender+characterId;
    // characterPath = 'assets/models/${gender+characterId}.obj';
    characterPath = 'assets/models/${characterId}.obj';
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('characterId', characterId);
    // prefs.setString('character',character);
    prefs.setString('characterPath', characterPath);

    await FirebaseService().updateCharacter(userId, characterId);

    notifyListeners();
  }

  // void setCharacter(String _character) async{
  //   character = _character;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('character',_character);
  // }

  // void setCharacterPath(String _characterPath) async{
  //   characterPath = _characterPath;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('characterPath',_characterPath);
  // }

  void setBackgroundId(String _backgroundId) async {
    backgroundId = _backgroundId;
    backgroundPath = 'assets/backgrounds/${backgroundId}.png';
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('backgroundId', backgroundId);
    prefs.setString('backgroundPath', backgroundPath);

    await FirebaseService().updateBackgroundId(userId, backgroundId);

    notifyListeners();
  }

  // void setBackgroundPath(String _backgroundPath) async{
  //   backgroundPath = _backgroundPath;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('backgroundPath',_backgroundPath);
  // }

  void setGachaTicket(int _number) async {
    gachaTicket = gachaTicket + _number;
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('gachaTicket', gachaTicket);

    await FirebaseService().updateGachaTicket(userId, _number);

    notifyListeners();
  }

  void setNotHaveNickNameIdList(String _nickNameId) async {
    notHaveNickNameIdList.remove(_nickNameId);
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveNickNameIdList', notHaveNickNameIdList);

    await FirebaseService().deleteNotHaveNickName(userId, _nickNameId);

    notifyListeners();
  }

  void setNotHaveCharacterIdList(String _characterId) async {
    notHaveCharacterIdList.remove(_characterId);
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveCharacterIdList', notHaveCharacterIdList);

    await FirebaseService().deleteNotHaveCharacter(userId, _characterId);

    notifyListeners();
  }

  void setNotHaveBackgroundIdList(String _backgroundId) async {
    notHaveBackgroundIdList.remove(_backgroundId);
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveBackgroundIdList', notHaveBackgroundIdList);

    await FirebaseService().deleteNotHaveBackground(userId, _backgroundId);

    notifyListeners();
  }

  void setAchieve(int _paperNum, int _time, bool _penalty) async {
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
    prefs.setInt('penalty', penalty ? 1 : 0);

    await FirebaseService().updateAchieve(userId, _penalty, _time);

    notifyListeners();
  }

  // void setPaperNum(int _paperNum) async{
  //   paperNum = _paperNum;
  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('paperNum',_paperNum);
  // }

  // void setSumTime(int _sumTime) async{
  //   sumTime = _sumTime;
  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('sumTime',_sumTime);
  // }

  // void setThisTime(int _thisTime) async{
  //   thisTime = _thisTime;
  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('thisTime',_thisTime);
  // }

  // void setNeedTime(int _needTime) async{
  //   needTime = _needTime;
  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('needTime',_needTime);
  // }

  // void setAchieveNum(int _achieveNum) async{
  //   achieveNum = _achieveNum;
  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('achieveNum',_achieveNum);
  // }

  // void setMeanTime(int _meanTime) async{
  //   meanTime = _meanTime;
  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('meanTime',_meanTime);
  // }

  // void setPenalty(int _penalty) async{
  //   penalty = _penalty;
  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('penalty',_penalty);
  // }

  void setHaveNickNameIdList(String _nickNameId) async {
    haveNickNameIdList.add(_nickNameId);
    String _nickName = await FirebaseService().getNickName(_nickNameId);
    haveNickNameList.add(_nickName);
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveNickNameIdList', haveNickNameIdList);
    prefs.setStringList('haveNickNameList', haveNickNameList);

    await FirebaseService().addHaveNickName(userId, _nickNameId);

    notifyListeners();
  }

  // void setHaveNickNamePathList(List<String> _haveNickNamePathList) async{
  //   haveNickNamePathList = _haveNickNamePathList;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('haveNickNamePathList',_haveNickNamePathList);
  // }

  void setHaveCharacterIdList(String _characterId) async {
    haveCharacterIdList.add(_characterId);
    haveCharacterPathList.add('assets/models/${_characterId}.obj');
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveCharacterIdList', haveCharacterIdList);
    prefs.setStringList('haveCharacterPathList', haveCharacterPathList);

    await FirebaseService().addHaveCharacter(userId, _characterId);

    notifyListeners();
  }

  // void setHaveCharacterPathList(List<String> _haveCharacterPathList) async{
  //   haveCharacterPathList = _haveCharacterPathList;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('haveCharacterPathList',_haveCharacterPathList);
  // }

  void setHaveBackgroundIdList(String _backgroundId) async {
    haveBackgroundIdList.add(_backgroundId);
    haveBackgroundPathList.add('assets/backgrounds/${_backgroundId}.png');
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveBackgroundIdList', haveBackgroundIdList);
    prefs.setStringList('haveBackgroundPathList', haveBackgroundPathList);

    await FirebaseService().addHaveBackground(userId, _backgroundId);

    notifyListeners();
  }

  // void setHaveBackgroundPathList(List<String> _haveBackgroundPathList) async{
  //   haveBackgroundPathList = _haveBackgroundPathList;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('haveBackgroundPathList',_haveBackgroundPathList);
  // }

  void setClassFlagList(int row, int column) async {
    classFlagList[row][column] = !classFlagList[row][column];
    // notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = classFlagList
        .map((e) => e.map((e) => e ? '1' : '0').toList())
        .toList()
        .expand((e) => e)
        .toList();
    prefs.setStringList('classFlagList', tmp);

    await FirebaseService().updateClassExisteSchedule(userId, classFlagList);

    notifyListeners();
  }

  // void setClassTimeList(List<int> _classTimeList, int row) async{
  //   classTimeList[row] = _classTimeList;
  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> tmp = classTimeList.map((e) => e.map((e) => e.toString()).toList()).toList().expand((e) => e).toList();
  //   prefs.setStringList('classTimeList',tmp);
  // }
  void setClassStartTimeList(List<int> _classTimeList, int row) async {
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

    await FirebaseService().updateClassTimeSchedule(userId, classTimeList);

    notifyListeners();
  }

  void setClassFinishTimeList(List<int> _classTimeList, int row) async {
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

    await FirebaseService().updateClassTimeSchedule(userId, classTimeList);

    notifyListeners();
  }

  void setRanking() async {
    List<List<dynamic>> tmp = await FirebaseService().getRanking();
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
    // prefs.setStringList('paperNumRanking1st', [tmp[0][0]['userName'],tmp[0][0]['characterId'],tmp[0][0]['backgroundId'],tmp[0][0]['paperNum']]);
    // prefs.setStringList('paperNumRanking2nd', [tmp[0][1]['userName'],tmp[0][1]['characterId'],tmp[0][1]['backgroundId'],tmp[0][1]['paperNum']]);
    // prefs.setStringList('paperNumRanking3rd', [tmp[0][2]['userName'],tmp[0][2]['characterId'],tmp[0][2]['backgroundId'],tmp[0][2]['paperNum']]);
    // prefs.setStringList('paperNumRanking4th', [tmp[0][3]['userName'],tmp[0][3]['characterId'],tmp[0][3]['backgroundId'],tmp[0][3]['paperNum']]);
    // prefs.setStringList('paperNumRanking5th', [tmp[0][4]['userName'],tmp[0][4]['characterId'],tmp[0][4]['backgroundId'],tmp[0][4]['paperNum']]);
    // prefs.setStringList('paperNumRanking6th', [tmp[0][5]['userName'],tmp[0][5]['characterId'],tmp[0][5]['backgroundId'],tmp[0][5]['paperNum']]);
    // prefs.setStringList('paperNumRanking7th', [tmp[0][6]['userName'],tmp[0][6]['characterId'],tmp[0][6]['backgroundId'],tmp[0][6]['paperNum']]);
    // prefs.setStringList('paperNumRanking8th', [tmp[0][7]['userName'],tmp[0][7]['characterId'],tmp[0][7]['backgroundId'],tmp[0][7]['paperNum']]);
    // prefs.setStringList('paperNumRanking9th', [tmp[0][8]['userName'],tmp[0][8]['characterId'],tmp[0][8]['backgroundId'],tmp[0][8]['paperNum']]);
    // prefs.setStringList('paperNumRanking10th', [tmp[0][9]['userName'],tmp[0][9]['characterId'],tmp[0][9]['backgroundId'],tmp[0][9]['paperNum']]);

    // prefs.setStringList('sumTimeRanking1st', [tmp[1][0]['userName'],tmp[1][0]['character'],tmp[1][0]['backgroundId'],tmp[1][0]['sumTime']]);
    // prefs.setStringList('sumTimeRanking2nd', [tmp[1][1]['userName'],tmp[1][1]['character'],tmp[1][1]['backgroundId'],tmp[1][1]['sumTime']]);
    // prefs.setStringList('sumTimeRanking3rd', [tmp[1][2]['userName'],tmp[1][2]['character'],tmp[1][2]['backgroundId'],tmp[1][2]['sumTime']]);
    // prefs.setStringList('sumTimeRanking4th', [tmp[1][3]['userName'],tmp[1][3]['character'],tmp[1][3]['backgroundId'],tmp[1][3]['sumTime']]);
    // prefs.setStringList('sumTimeRanking5th', [tmp[1][4]['userName'],tmp[1][4]['character'],tmp[1][4]['backgroundId'],tmp[1][4]['sumTime']]);
    // prefs.setStringList('sumTimeRanking6th', [tmp[1][5]['userName'],tmp[1][5]['character'],tmp[1][5]['backgroundId'],tmp[1][5]['sumTime']]);
    // prefs.setStringList('sumTimeRanking7th', [tmp[1][6]['userName'],tmp[1][6]['character'],tmp[1][6]['backgroundId'],tmp[1][6]['sumTime']]);
    // prefs.setStringList('sumTimeRanking8th', [tmp[1][7]['userName'],tmp[1][7]['character'],tmp[1][7]['backgroundId'],tmp[1][7]['sumTime']]);
    // prefs.setStringList('sumTimeRanking9th', [tmp[1][8]['userName'],tmp[1][8]['character'],tmp[1][8]['backgroundId'],tmp[1][8]['sumTime']]);
    // prefs.setStringList('sumTimeRanking10th', [tmp[1][9]['userName'],tmp[1][9]['character'],tmp[1][9]['backgroundId'],tmp[1][9]['sumTime']]);

    // prefs.setStringList('meanTimeRanking1st', [tmp[2][0]['userName'],tmp[2][0]['character'],tmp[2][0]['backgroundId'],tmp[2][0]['meanTime']]);
    // prefs.setStringList('meanTimeRanking2nd', [tmp[2][1]['userName'],tmp[2][1]['character'],tmp[2][1]['backgroundId'],tmp[2][1]['meanTime']]);
    // prefs.setStringList('meanTimeRanking3rd', [tmp[2][2]['userName'],tmp[2][2]['character'],tmp[2][2]['backgroundId'],tmp[2][2]['meanTime']]);
    // prefs.setStringList('meanTimeRanking4th', [tmp[2][3]['userName'],tmp[2][3]['character'],tmp[2][3]['backgroundId'],tmp[2][3]['meanTime']]);
    // prefs.setStringList('meanTimeRanking5th', [tmp[2][4]['userName'],tmp[2][4]['character'],tmp[2][4]['backgroundId'],tmp[2][4]['meanTime']]);
    // prefs.setStringList('meanTimeRanking6th', [tmp[2][5]['userName'],tmp[2][5]['character'],tmp[2][5]['backgroundId'],tmp[2][5]['meanTime']]);
    // prefs.setStringList('meanTimeRanking7th', [tmp[2][6]['userName'],tmp[2][6]['character'],tmp[2][6]['backgroundId'],tmp[2][6]['meanTime']]);
    // prefs.setStringList('meanTimeRanking8th', [tmp[2][7]['userName'],tmp[2][7]['character'],tmp[2][7]['backgroundId'],tmp[2][7]['meanTime']]);
    // prefs.setStringList('meanTimeRanking9th', [tmp[2][8]['userName'],tmp[2][8]['character'],tmp[2][8]['backgroundId'],tmp[2][8]['meanTime']]);
    // prefs.setStringList('meanTimeRanking10th', [tmp[2][9]['userName'],tmp[2][9]['character'],tmp[2][9]['backgroundId'],tmp[2][9]['meanTime']]);
  }

  // void setPaperNumRanking(List<List<String>> _paperNumRanking) async{
  //   paperNumRanking = _paperNumRanking;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('paperNumRanking',_paperNumRanking.toString());
  // }

  // void setSumTimeRanking(List<List<String>> _sumTimeRanking) async{
  //   sumTimeRanking = _sumTimeRanking;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('sumTimeRanking',_sumTimeRanking.toString());
  // }

  // void setMeanTimeRanking(List<List<String>> _meanTimeRanking) async{
  //   meanTimeRanking = _meanTimeRanking;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('meanTimeRanking',_meanTimeRanking.toString());
  // }
}
