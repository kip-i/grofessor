import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'firebase_service.dart';


class UserProvider extends ChangeNotifier{
  bool login = false;
  // bool get isLogin => login;
  String userId = '';
  String userName = '';

  void getUser() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    List<String> tmp = await AuthService().signIn(userName);
    if (tmp[1] == "Success"){
      login = true;
      userId = tmp[0];
    } else {
      login = false;
    }
    notifyListeners(); // Add this line
    print('正常更新:${login}');
    notifyListeners(); // Add this line
  }

  Future<void> initUser(String _userName, String _gender) async {

    NickNameProvider nickNameProvider = NickNameProvider();
    CharacterProvider characterProvider = CharacterProvider();
    BackgroundProvider backgroundProvider = BackgroundProvider();
    GachaProvider gachaProvider = GachaProvider();
    AchieveProvider achieveProvider = AchieveProvider();
    HaveItemProvider haveItemProvider = HaveItemProvider();
    ClassProvider classProvider = ClassProvider();
    RankingProvider rankingProvider = RankingProvider();
    
    List<String> tmp = await AuthService().createUser(_userName,_gender);
    if (tmp[1] == "Success"){
      login = true;
      userId = tmp[0];
    
      userName = _userName;

      nickNameProvider.nickNameId = 'n0';
      nickNameProvider.nickName = '研究生';

      characterProvider.gender = _gender;
      characterProvider.characterId = '($_gender)0';
      characterProvider.characterPath = 'assets/models/($_gender)0).obj';

      backgroundProvider.backgroundId = 'b0';
      backgroundProvider.backgroundPath = 'assets/backgrounds/b0.png';

      gachaProvider.gachaTicket = 0;
      gachaProvider.notHaveNickNameIdList = ['n1','n2'];
      gachaProvider.notHaveCharacterIdList = ['($_gender)1','($_gender)2'];
      gachaProvider.notHaveBackgroundIdList = ['b1','b2'];

      achieveProvider.paperNum = 0;
      achieveProvider.sumTime = 0;
      achieveProvider.thisTime = 0;
      achieveProvider.needTime = 0;
      achieveProvider.achieveNum = 0;
      achieveProvider.meanTime = 0;
      achieveProvider.penalty = false;

      haveItemProvider.haveNickNameIdList = ['n0'];
      haveItemProvider.haveNickNameList = ['研究生'];
      haveItemProvider.haveCharacterIdList = ['($_gender)0'];
      haveItemProvider.haveCharacterPathList = ['assets/models/($_gender)0.obj'];
      haveItemProvider.haveBackgroundIdList = ['b0'];
      haveItemProvider.haveBackgroundPathList = ['assets/backgrounds/b0.png'];

      classProvider.classFlagList = [[false,false,false,false,false,false],
                        [false,false,false,false,false,false],
                        [false,false,false,false,false,false],
                        [false,false,false,false,false,false],
                        [false,false,false,false,false,false],
                        [false,false,false,false,false,false],];
      classProvider.classTimeList = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],];

      rankingProvider.paperNumRanking = [];
      rankingProvider.sumTimeRanking = [];
      rankingProvider.meanTimeRanking = [];

      notifyListeners();

      await FirebaseService().createUser(userId, userName, _gender);

      final prefs = await SharedPreferences.getInstance();

      prefs.setString('userName', userName);
      prefs.setString('nickNameId', 'n0');
      prefs.setString('nickName', '研究生');

      prefs.setString('gender', _gender);
      prefs.setString('characterId', '($_gender)0');
      prefs.setString('characterPath', 'assets/models/($_gender)0.obj');
      prefs.setString('backgroundId', 'b0');
      prefs.setString('backgroundPath', 'assets/backgrounds/b0.png');

      prefs.setInt('gachaTicket', 0);
      prefs.setStringList('notHaveNickNameList', ['n1','n2']);
      prefs.setStringList('notHaveCharacterList', ['($_gender)1','($_gender)2']);
      prefs.setStringList('notHaveBackgroundList', ['b1','b2']);

      prefs.setInt('paperNum', 0);
      prefs.setInt('sumTime', 0);
      prefs.setInt('thisTime', 0);
      prefs.setInt('needTime', 0);
      prefs.setInt('achieveNum', 0);
      prefs.setInt('meanTime', 0);
      prefs.setInt('penalty', 0);

      prefs.setStringList('haveNickNameIdList', ['n0']);
      prefs.setStringList('haveNickNameList', ['研究生']);
      prefs.setStringList('haveCharacterIdList', ['($_gender)0']);
      prefs.setStringList('haveCharacterPathList', ['assets/models/($_gender)0.obj']);
      prefs.setStringList('haveBackgroundIdList', ['b0']);
      prefs.setStringList('haveBackgroundPathList', ['assets/backgrounds/b0.png']);

      prefs.setStringList('classFlag', ['0','0','0','0','0','0',
                                        '0','0','0','0','0','0',
                                        '0','0','0','0','0','0',
                                        '0','0','0','0','0','0',
                                        '0','0','0','0','0','0',
                                        '0','0','0','0','0','0']);
      prefs.setStringList('classTime', ['0','0','0','0',
                                        '0','0','0','0',
                                        '0','0','0','0',
                                        '0','0','0','0',
                                        '0','0','0','0',
                                        '0','0','0','0']);

      for (int i=0; i<10; i++){
        prefs.setStringList('paperNumRanking${i+1}', []);
        prefs.setStringList('sumTimeRanking${i+1}', []);
        prefs.setStringList('meanTimeRanking${i+1}', []);
      }
    } else {
      login = false;
      notifyListeners();
    }
  }
}


class NickNameProvider extends ChangeNotifier{
  String nickNameId = ''; // n0
  String nickName = '';

  void getNickName() async {
    final prefs = await SharedPreferences.getInstance();
    nickNameId = prefs.getString('nickNameId') ?? 'n0';
    nickName = prefs.getString('nickName') ?? '研究生';
    notifyListeners(); // Add this line
  }

  void setNickName(String _userId, String _nickNameId, String _nickName) async {
    nickNameId = _nickNameId;
    nickName = _nickName;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nickNameId', nickNameId);
    prefs.setString('nickName', nickName);

    await FirebaseService().updateNickNameId(_userId, nickNameId);
  }
}


class CharacterProvider extends ChangeNotifier{
  String gender = ''; // m or w
  String characterId = ''; // (m or w)0
  String characterPath = ''; // assets/models/(m or w)0.obj

  void getCharacter() async{
    final prefs = await SharedPreferences.getInstance();
    gender = prefs.getString('gender') ?? 'm';
    characterId = prefs.getString('characterId') ?? 'm0';
    characterPath = prefs.getString('characterPath') ?? 'assets/models/m0.obj';
    notifyListeners(); // Add this line
  }

  void setCharacterId(String _userId, String _characterId) async{
    characterId = _characterId;
    characterPath = 'assets/models/${characterId}.obj';
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('characterId',characterId);
    prefs.setString('characterPath',characterPath);

    await FirebaseService().updateCharacter(_userId, characterId);
  }
}


class BackgroundProvider extends ChangeNotifier{
  String backgroundId = ''; // b0
  String backgroundPath = ''; // assets/backgrounds/b0.png

  void getBackground() async {
    final prefs = await SharedPreferences.getInstance();
    backgroundId = prefs.getString('backgroundId') ?? 'b0';
    backgroundPath = prefs.getString('backgroundPath') ?? 'assets/backgrounds/b0.png';
    notifyListeners(); // Add this line
  }

  void setBackground(String _userId, String _backgroundId) async{
    backgroundId = _backgroundId;
    backgroundPath = 'assets/backgrounds/${_backgroundId}.png';
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('backgroundId',backgroundId);
    prefs.setString('backgroundPath',backgroundPath);

    await FirebaseService().updateBackgroundId(_userId, _backgroundId);
  }
}


class GachaProvider extends ChangeNotifier{
  int gachaTicket = 0;
  List<String> notHaveNickNameIdList = []; // n1,n2
  List<String> notHaveCharacterIdList = []; // (m or w)1,(m or w)2
  List<String> notHaveBackgroundIdList = []; // b1,b2

  void getGacha() async {
    final prefs = await SharedPreferences.getInstance();
    gachaTicket = prefs.getInt('gachaTicket') ?? 0;
    notHaveNickNameIdList = prefs.getStringList('notHaveNickNameIdList') ?? [];
    notHaveCharacterIdList = prefs.getStringList('notHaveCharacterIdList') ?? [];
    notHaveBackgroundIdList = prefs.getStringList('notHaveBackgroundIdList') ?? [];
    notifyListeners(); // Add this line
  }

  void setGachaTicket(String _userId, int _number) async{
    gachaTicket = gachaTicket+_number;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('gachaTicket',gachaTicket);

    await FirebaseService().updateGachaTicket(_userId, _number);
  }

  void setNotHaveNickNameIdList(String _userId, String _nickNameId) async{
    notHaveNickNameIdList.remove(_nickNameId);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveNickNameIdList',notHaveNickNameIdList);

    await FirebaseService().deleteNotHaveNickName(_userId, _nickNameId);
  }

  void setNotHaveCharacterIdList(String _userId, String _characterId) async{
    notHaveCharacterIdList.remove(_characterId);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveCharacterIdList',notHaveCharacterIdList);

    await FirebaseService().deleteNotHaveCharacter(_userId, _characterId);
  }

  void setNotHaveBackgroundIdList(String _userId, String _backgroundId) async{
    notHaveBackgroundIdList.remove(_backgroundId);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveBackgroundIdList',notHaveBackgroundIdList);

    await FirebaseService().deleteNotHaveBackground(_userId, _backgroundId);
  }
}


class AchieveProvider extends ChangeNotifier{
  int paperNum = 0;
  int sumTime = 0;
  int thisTime = 0;
  int needTime = 0;
  int achieveNum = 0;
  double meanTime = 0;
  bool penalty = false;

  void getAchieve() async {
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

  void setAchieve(String _userId, int _paperNum,int _time,bool _penalty) async{
    sumTime = sumTime+_time;
    thisTime = thisTime+_time;
    if (thisTime >= needTime){
      paperNum = paperNum+1;
      needTime = await FirebaseService().getNeedTime(paperNum);
      thisTime = thisTime-needTime;
    }
    achieveNum = achieveNum+1;
    meanTime = sumTime/achieveNum;
    penalty = _penalty;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('paperNum',paperNum);
    prefs.setInt('sumTime',sumTime);
    prefs.setInt('thisTime',thisTime);
    prefs.setInt('needTime',needTime);
    prefs.setInt('achieveNum',achieveNum);
    prefs.setDouble('meanTime',meanTime);
    prefs.setInt('penalty',penalty ? 1 : 0);

    await FirebaseService().updateAchieve(_userId, _penalty, _time);
  }
}


class HaveItemProvider extends ChangeNotifier{
  List<String> haveNickNameIdList = []; // n0
  List<String> haveNickNameList = []; // 研究生
  List<String> haveCharacterIdList = []; // (m or w)0
  List<String> haveCharacterPathList = []; // assets/models/(m or w)0.obj
  List<String> haveBackgroundIdList = []; // b0
  List<String> haveBackgroundPathList = []; // assets/backgrounds/b0.png

  void getHaveItemList() async {
    final prefs = await SharedPreferences.getInstance();
    haveNickNameIdList = prefs.getStringList('haveNickNameIdList') ?? [];
    haveNickNameList = prefs.getStringList('haveNickNameList') ?? [];
    haveCharacterIdList = prefs.getStringList('haveCharacterIdList') ?? [];
    haveCharacterPathList = prefs.getStringList('haveCharacterPathList') ?? [];
    haveBackgroundIdList = prefs.getStringList('haveBackgroundIdList') ?? [];
    haveBackgroundPathList = prefs.getStringList('haveBackgroundPathList') ?? [];
    notifyListeners(); // Add this line
  }

  void setHaveNickNameIdList(String _userId, String _nickNameId) async{
    haveNickNameIdList.add(_nickNameId);
    String _nickName = await FirebaseService().getNickName(_nickNameId);
    haveNickNameList.add(_nickName);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveNickNameIdList',haveNickNameIdList);
    prefs.setStringList('haveNickNameList',haveNickNameList);

    await FirebaseService().addHaveNickName(_userId, _nickNameId);
  }

  void setHaveCharacterIdList(String _userId, String _characterId) async{
    haveCharacterIdList.add(_characterId);
    haveCharacterPathList.add('assets/models/${_characterId}.obj');
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveCharacterIdList',haveCharacterIdList);
    prefs.setStringList('haveCharacterPathList',haveCharacterPathList);

    await FirebaseService().addHaveCharacter(_userId, _characterId);
  }

  void setHaveBackgroundIdList(String _userId, String _backgroundId) async{
    haveBackgroundIdList.add(_backgroundId);
    haveBackgroundPathList.add('assets/backgrounds/${_backgroundId}.png');
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveBackgroundIdList',haveBackgroundIdList);
    prefs.setStringList('haveBackgroundPathList',haveBackgroundPathList);

    await FirebaseService().addHaveBackground(_userId, _backgroundId);
  }
}


class ClassProvider extends ChangeNotifier{
  List<List<bool>> classFlagList = []; // 6*6
  List<List<int>> classTimeList = []; // 6*4

  void getClassList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = prefs.getStringList('classFlagList') ?? [];
    List<String> tmp2 = prefs.getStringList('classTimeList') ?? [];
    classFlagList = [];
    classTimeList = [];
    
    for (int i=0; i<tmp.length; i+=6){
      classFlagList.add(tmp.sublist(i,i+6).map((e) => e=='1' ? true : false).toList());
    }
    for (int i=0; i<tmp.length; i+=4){
      classTimeList.add(tmp2.sublist(i,i+4).map((e) => int.parse(e)).toList());
    }
    notifyListeners(); // Add this line
  }

  void setClassFlagList(int row, int column) async{
    classFlagList[row][column] = !classFlagList[row][column];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = classFlagList.map((e) => e.map((e) => e ? '1' : '0').toList()).toList().expand((e) => e).toList();
    prefs.setStringList('classFlagList',tmp);
  }

  void setClassTimeList(List<int> _classTimeList, int row) async{
    classTimeList[row] = _classTimeList;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = classTimeList.map((e) => e.map((e) => e.toString()).toList()).toList().expand((e) => e).toList();
    prefs.setStringList('classTimeList',tmp);
  }
}


class RankingProvider extends ChangeNotifier{
  List<List<String>> paperNumRanking = []; // 10*4
  List<List<String>> sumTimeRanking = []; // 10*4
  List<List<String>> meanTimeRanking = []; // 10*4

  void getRanking() async {
    final prefs = await SharedPreferences.getInstance();
    paperNumRanking = [];
    sumTimeRanking = [];
    meanTimeRanking = [];
    for (int i=0; i<10; i++){
      paperNumRanking.add(prefs.getStringList('paperNumRanking${i+1}') ?? []);
      sumTimeRanking.add(prefs.getStringList('sumTimeRanking${i+1}') ?? []);
      meanTimeRanking.add(prefs.getStringList('meanTimeRanking${i+1}') ?? []);
    }
    notifyListeners(); // Add this line
  }

  void setRanking() async{
    List<List<dynamic>> tmp = await FirebaseService().getRanking();
    for(int i=0;i<10;i++){
      paperNumRanking[i] = [tmp[0][i]['userName'],tmp[0][i]['characterId'],tmp[0][i]['backgroundId'],tmp[0][i]['paperNum']];
      sumTimeRanking[i] = [tmp[1][i]['userName'],tmp[1][i]['characterId'],tmp[1][i]['backgroundId'],tmp[1][i]['sumTime']];
      meanTimeRanking[i] = [tmp[2][i]['userName'],tmp[2][i]['characterId'],tmp[2][i]['backgroundId'],tmp[2][i]['meanTime']];
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    for(int i=0;i<10;i++){
      prefs.setStringList('paperNumRanking${i+1}',[tmp[0][i]['userName'],tmp[0][i]['characterId'],tmp[0][i]['backgroundId'],tmp[0][i]['paperNum']]);
      prefs.setStringList('sumTimeRanking${i+1}',[tmp[1][i]['userName'],tmp[1][i]['characterId'],tmp[1][i]['backgroundId'],tmp[1][i]['sumTime']]);
      prefs.setStringList('meanTimeRanking${i+1}',[tmp[2][i]['userName'],tmp[2][i]['characterId'],tmp[2][i]['backgroundId'],tmp[2][i]['meanTime']]);
    }
  }
}