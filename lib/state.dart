import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';
import 'firebase_service.dart';

// final counterProvider = ChangeNotifierProvider((ref) => DataProvider());

class DataProvider extends ChangeNotifier {
  
  bool login = false;
  // bool get isLogin => login;
  String userId = '';
  String userName = '';

  String nickNameId = '';
  String nickName = '';

  String gender = '';
  String characterId = '';
  String character = '';
  String characterPath = '';

  String backgroundId = '';
  String backgroundPath = '';

  int gachaTicket = 0;
  List<String> notHaveNickNameIdList = [];
  List<String> notHaveCharacterIdList = [];
  List<String> notHaveBackgroundIdList = [];

  int paperNum = 0;
  int sumTime = 0;
  int thisTime = 0;
  int needTime = 0;
  int achieveNum = 0;
  double meanTime = 0;
  bool penalty = false;

  List<String> haveNickNameIdList = [];
  List<String> haveNickNameList = [];
  List<String> haveCharacterIdList = [];
  List<String> haveCharacterPathList = [];
  List<String> haveBackgroundIdList = [];
  List<String> haveBackgroundPathList = [];

  List<List<bool>> classFlagList = [[false,false,false,false,false,false],[false,false,false,false,false,false],
                                    [false,false,false,false,false,false],[false,false,false,false,false,false],
                                    [false,false,false,false,false,false],[false,false,false,false,false,false],];
  List<List<int>> classTimeList = [[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],];

  List<List<String>> paperNumRanking = [];
  List<List<String>> sumTimeRanking = [];
  List<List<String>> meanTimeRanking = [];

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName') ?? '';
    nickNameId = prefs.getString('nickNameId') ?? '';
    nickName = prefs.getString('nickName') ?? '';

  }

  Future<void> getUserId() async {
    // getUseName();
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

  void getCharacter() async {
    final prefs = await SharedPreferences.getInstance();
    character = prefs.getString('character') ?? '';
    notifyListeners(); // Add this line
  }

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
    notHaveCharacterIdList = prefs.getStringList('notHaveCharacterIdList') ?? [];
    notifyListeners(); // Add this line
  }

  void getNotHaveBackgroundIdList() async {
    final prefs = await SharedPreferences.getInstance();
    notHaveBackgroundIdList = prefs.getStringList('notHaveBackgroundIdList') ?? [];
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
    haveBackgroundPathList = prefs.getStringList('haveBackgroundPathList') ?? [];
    notifyListeners(); // Add this line
  }

  void getClassFlagList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = prefs.getStringList('classFlagList') ?? [];
    classFlagList = [];
    for (int i=0; i<tmp.length; i+=6){
      classFlagList.add(tmp.sublist(i,i+6).map((e) => e=='1' ? true : false).toList());
    }
    if(classFlagList==[]){
      classFlagList = [[false,false,false,false,false,false],[false,false,false,false,false,false],
                                    [false,false,false,false,false,false],[false,false,false,false,false,false],
                                    [false,false,false,false,false,false],[false,false,false,false,false,false],];
    List<String> tmp = classFlagList.map((e) => e.map((e) => e ? '1' : '0').toList()).toList().expand((e) => e).toList();
      prefs.setStringList('classFlagList',tmp);
    }

    notifyListeners(); // Add this line
  }

  void getClassTimeList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = prefs.getStringList('classTimeList') ?? [];
    for (int i=0; i<tmp.length; i+=4){
      classTimeList.add(tmp.sublist(i,i+4).map((e) => int.parse(e)).toList());
    }
    notifyListeners(); // Add this line
  }

  void getPaperNumRanking() async {
    final prefs = await SharedPreferences.getInstance();
    sumTimeRanking = [[]];
    sumTimeRanking.add(prefs.getStringList('paperNumRanking1st') ?? []);
    sumTimeRanking.add(prefs.getStringList('paperNumRanking2nd') ?? []);
    sumTimeRanking.add(prefs.getStringList('paperNumRanking3rd') ?? []);
    sumTimeRanking.add(prefs.getStringList('paperNumRanking4th') ?? []);
    sumTimeRanking.add(prefs.getStringList('paperNumRanking5th') ?? []);
    sumTimeRanking.add(prefs.getStringList('paperNumRanking6th') ?? []);
    sumTimeRanking.add(prefs.getStringList('paperNumRanking7th') ?? []);
    sumTimeRanking.add(prefs.getStringList('paperNumRanking8th') ?? []);
    sumTimeRanking.add(prefs.getStringList('paperNumRanking9th') ?? []);
    sumTimeRanking.add(prefs.getStringList('paperNumRanking10th') ?? []);
    notifyListeners(); // Add this line
  }

  void getSumTimeRanking() async {
    final prefs = await SharedPreferences.getInstance();
    sumTimeRanking = [[]];
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking1st') ?? []);
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking2nd') ?? []);
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking3rd') ?? []);
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking4th') ?? []);
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking5th') ?? []);
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking6th') ?? []);
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking7th') ?? []);
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking8th') ?? []);
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking9th') ?? []);
    sumTimeRanking.add(prefs.getStringList('sumTimeRanking10th') ?? []);
    notifyListeners(); // Add this line
  }

  void getMeanTimeRanking() async {
    final prefs = await SharedPreferences.getInstance();
    meanTimeRanking = [[]];
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking1st') ?? []);
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking2nd') ?? []);
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking3rd') ?? []);
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking4th') ?? []);
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking5th') ?? []);
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking6th') ?? []);
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking7th') ?? []);
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking8th') ?? []);
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking9th') ?? []);
    meanTimeRanking.add(prefs.getStringList('meanTimeRanking10th') ?? []);
    notifyListeners(); // Add this line
  }



  Future<void> setUser(String _userName, String _gender) async {
    
    List<String> tmp = await AuthService().createUser(_userName,_gender);
    if (tmp[1] == "Success"){
      login = true;
      userId = tmp[0];
    } else {
      login = false;
    }
    userName = _userName;
    gender = _gender;
    character = '($gender)0';
    notifyListeners();

    await FirebaseService().createUser(userId, userName, gender);

    final prefs = await SharedPreferences.getInstance();

    prefs.setString('userName', userName);
    prefs.setString('nickNameId', '');
    prefs.setString('nickName', '');

    prefs.setString('gender', gender);
    prefs.setString('characterId', '0');
    prefs.setString('character', character);
    prefs.setString('characterPath', '0');
    prefs.setString('backgroundId', '0');
    prefs.setString('backgroundPath', '0');

    prefs.setInt('gachaTicket', 0);
    prefs.setStringList('notHaveNickNameList', ['0','1','2']);
    prefs.setStringList('notHaveCharacterList', ['($gender)1','($gender)2']);
    prefs.setStringList('notHaveBackgroundList', ['0','1','2']);

    prefs.setInt('paperNum', 0);
    prefs.setInt('sumTime', 0);
    prefs.setInt('thisTime', 0);
    prefs.setInt('needTime', 0);
    prefs.setInt('achieveNum', 0);
    prefs.setInt('meanTime', 0);
    prefs.setInt('penalty', 0);

    prefs.setStringList('haveNickNameList', []);
    prefs.setStringList('haveCharacterList', []);
    prefs.setStringList('haveBackgroundList', []);

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

    prefs.setStringList('paperNumRanking1st', []);
    prefs.setStringList('paperNumRanking2nd', []);
    prefs.setStringList('paperNumRanking3rd', []);
    prefs.setStringList('paperNumRanking4th', []);
    prefs.setStringList('paperNumRanking5th', []);
    prefs.setStringList('paperNumRanking6th', []);
    prefs.setStringList('paperNumRanking7th', []);
    prefs.setStringList('paperNumRanking8th', []);
    prefs.setStringList('paperNumRanking9th', []);
    prefs.setStringList('paperNumRanking10th', []);

    prefs.setStringList('sumTimeRanking1st', []);
    prefs.setStringList('sumTimeRanking2nd', []);
    prefs.setStringList('sumTimeRanking3rd', []);
    prefs.setStringList('sumTimeRanking4th', []);
    prefs.setStringList('sumTimeRanking5th', []);
    prefs.setStringList('sumTimeRanking6th', []);
    prefs.setStringList('sumTimeRanking7th', []);
    prefs.setStringList('sumTimeRanking8th', []);
    prefs.setStringList('sumTimeRanking9th', []);
    prefs.setStringList('sumTimeRanking10th', []);

    prefs.setStringList('meanTimeRanking1st', []);
    prefs.setStringList('meanTimeRanking2nd', []);
    prefs.setStringList('meanTimeRanking3rd', []);
    prefs.setStringList('meanTimeRanking4th', []);
    prefs.setStringList('meanTimeRanking5th', []);
    prefs.setStringList('meanTimeRanking6th', []);
    prefs.setStringList('meanTimeRanking7th', []);
    prefs.setStringList('meanTimeRanking8th', []);
    prefs.setStringList('meanTimeRanking9th', []);
    prefs.setStringList('meanTimeRanking10th', []);


    // notifyListeners();
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
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nickNameId', nickNameId);
    // notifyListeners(); // Add this line
    await FirebaseService().updateNickNameId(userId, nickNameId);
  }

  void setNickName(String _nickName) async {
    nickName = _nickName;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nickName', nickName);
    // notifyListeners(); // Add this line
  }

  // void setGender(String _gender) async{
  //   gender = _gender;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('gender',gender);
  // }

  void setCharacterId(String _characterId) async{
    characterId = _characterId;
    character = gender+characterId;
    characterPath = 'assets/models/${gender+characterId}.obj';
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('characterId',characterId);
    prefs.setString('character',character);
    prefs.setString('characterPath',characterPath);

    await FirebaseService().updateCharacter(userId, characterId);
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

  void setBackgroundId(String _backgroundId) async{
    backgroundId = _backgroundId;
    backgroundPath = 'assets/backgrounds/${backgroundId}.png';
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('backgroundId',backgroundId);
    prefs.setString('backgroundPath',backgroundPath);

    await FirebaseService().updateBackgroundId(userId, backgroundId);
  }

  // void setBackgroundPath(String _backgroundPath) async{
  //   backgroundPath = _backgroundPath;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('backgroundPath',_backgroundPath);
  // }

  void setGachaTicket(int _number) async{
    gachaTicket = gachaTicket+_number;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('gachaTicket',gachaTicket);

    await FirebaseService().updateGachaTicket(userId, _number);
  }

  void setNotHaveNickNameIdList(String _nickNameId) async{
    notHaveNickNameIdList.remove(_nickNameId);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveNickNameIdList',notHaveNickNameIdList);

    await FirebaseService().deleteNotHaveNickName(userId, _nickNameId);
  }

  void setNotHaveCharacterIdList(String _character) async{
    notHaveCharacterIdList.remove(_character);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveCharacterIdList',notHaveCharacterIdList);

    await FirebaseService().deleteNotHaveCharacter(userId, _character);
  }

  void setNotHaveBackgroundIdList(String _backgroundId) async{
    notHaveBackgroundIdList.remove(_backgroundId);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notHaveBackgroundIdList',notHaveBackgroundIdList);

    await FirebaseService().deleteNotHaveBackground(userId, _backgroundId);
  }

  void setAchieve(int _paperNum,int _time,bool _penalty) async{
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

    await FirebaseService().updateAchieve(userId, _penalty, _time);

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

  void setHaveNickNameIdList(String _nickNameId) async{
    haveNickNameIdList.add(_nickNameId);
    String _nickName = await FirebaseService().getNickName(_nickNameId);
    haveNickNameList.add(_nickName);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveNickNameIdList',haveNickNameIdList);
    prefs.setStringList('haveNickNameList',haveNickNameList);

    await FirebaseService().addHaveNickName(userId, _nickNameId);
  }

  // void setHaveNickNamePathList(List<String> _haveNickNamePathList) async{
  //   haveNickNamePathList = _haveNickNamePathList;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('haveNickNamePathList',_haveNickNamePathList);
  // }

  void setHaveCharacterIdList(String _characterId) async{
    haveCharacterIdList.add(_characterId);
    haveCharacterPathList.add('assets/models/${_characterId}.obj');
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveCharacterIdList',haveCharacterIdList);
    prefs.setStringList('haveCharacterPathList',haveCharacterPathList);

    await FirebaseService().addHaveCharacter(userId, _characterId);
  }

  // void setHaveCharacterPathList(List<String> _haveCharacterPathList) async{
  //   haveCharacterPathList = _haveCharacterPathList;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('haveCharacterPathList',_haveCharacterPathList);
  // }

  void setHaveBackgroundIdList(String _backgroundId) async{
    haveBackgroundIdList.add(_backgroundId);
    haveBackgroundPathList.add('assets/backgrounds/${_backgroundId}.png');
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('haveBackgroundIdList',haveBackgroundIdList);
    prefs.setStringList('haveBackgroundPathList',haveBackgroundPathList);

    await FirebaseService().addHaveBackground(userId, _backgroundId);
  }

  // void setHaveBackgroundPathList(List<String> _haveBackgroundPathList) async{
  //   haveBackgroundPathList = _haveBackgroundPathList;
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('haveBackgroundPathList',_haveBackgroundPathList);
  // }

  void setClassFlagList(int row, int column) async{
    classFlagList[row][column] = !classFlagList[row][column];
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = classFlagList.map((e) => e.map((e) => e ? '1' : '0').toList()).toList().expand((e) => e).toList();
    prefs.setStringList('classFlagList',tmp);
  }

  void setClassTimeList(List<int> _classTimeList, int row) async{
    classTimeList[row] = _classTimeList;
    final prefs = await SharedPreferences.getInstance();
    List<String> tmp = classTimeList.map((e) => e.map((e) => e.toString()).toList()).toList().expand((e) => e).toList();
    prefs.setStringList('classTimeList',tmp);
  }

  void setRanking() async{
    List<List<dynamic>> tmp = await FirebaseService().getRanking();
    for(int i=0;i<10;i++){
      paperNumRanking[i] = [tmp[0][i]['userName'],tmp[0][i]['character'],tmp[0][i]['backgroundId'],tmp[0][i]['paperNum']];
      sumTimeRanking[i] = [tmp[1][i]['userName'],tmp[1][i]['character'],tmp[1][i]['backgroundId'],tmp[1][i]['sumTime']];
      meanTimeRanking[i] = [tmp[2][i]['userName'],tmp[2][i]['character'],tmp[2][i]['backgroundId'],tmp[2][i]['meanTime']];
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('paperNumRanking1st', [tmp[0][0]['userName'],tmp[0][0]['character'],tmp[0][0]['backgroundId'],tmp[0][0]['paperNum']]);
    prefs.setStringList('paperNumRanking2nd', [tmp[0][1]['userName'],tmp[0][1]['character'],tmp[0][1]['backgroundId'],tmp[0][1]['paperNum']]);
    prefs.setStringList('paperNumRanking3rd', [tmp[0][2]['userName'],tmp[0][2]['character'],tmp[0][2]['backgroundId'],tmp[0][2]['paperNum']]);
    prefs.setStringList('paperNumRanking4th', [tmp[0][3]['userName'],tmp[0][3]['character'],tmp[0][3]['backgroundId'],tmp[0][3]['paperNum']]);
    prefs.setStringList('paperNumRanking5th', [tmp[0][4]['userName'],tmp[0][4]['character'],tmp[0][4]['backgroundId'],tmp[0][4]['paperNum']]);
    prefs.setStringList('paperNumRanking6th', [tmp[0][5]['userName'],tmp[0][5]['character'],tmp[0][5]['backgroundId'],tmp[0][5]['paperNum']]);
    prefs.setStringList('paperNumRanking7th', [tmp[0][6]['userName'],tmp[0][6]['character'],tmp[0][6]['backgroundId'],tmp[0][6]['paperNum']]);
    prefs.setStringList('paperNumRanking8th', [tmp[0][7]['userName'],tmp[0][7]['character'],tmp[0][7]['backgroundId'],tmp[0][7]['paperNum']]);
    prefs.setStringList('paperNumRanking9th', [tmp[0][8]['userName'],tmp[0][8]['character'],tmp[0][8]['backgroundId'],tmp[0][8]['paperNum']]);
    prefs.setStringList('paperNumRanking10th', [tmp[0][9]['userName'],tmp[0][9]['character'],tmp[0][9]['backgroundId'],tmp[0][9]['paperNum']]);

    prefs.setStringList('sumTimeRanking1st', [tmp[1][0]['userName'],tmp[1][0]['character'],tmp[1][0]['backgroundId'],tmp[1][0]['sumTime']]);
    prefs.setStringList('sumTimeRanking2nd', [tmp[1][1]['userName'],tmp[1][1]['character'],tmp[1][1]['backgroundId'],tmp[1][1]['sumTime']]);
    prefs.setStringList('sumTimeRanking3rd', [tmp[1][2]['userName'],tmp[1][2]['character'],tmp[1][2]['backgroundId'],tmp[1][2]['sumTime']]);
    prefs.setStringList('sumTimeRanking4th', [tmp[1][3]['userName'],tmp[1][3]['character'],tmp[1][3]['backgroundId'],tmp[1][3]['sumTime']]);
    prefs.setStringList('sumTimeRanking5th', [tmp[1][4]['userName'],tmp[1][4]['character'],tmp[1][4]['backgroundId'],tmp[1][4]['sumTime']]);
    prefs.setStringList('sumTimeRanking6th', [tmp[1][5]['userName'],tmp[1][5]['character'],tmp[1][5]['backgroundId'],tmp[1][5]['sumTime']]);
    prefs.setStringList('sumTimeRanking7th', [tmp[1][6]['userName'],tmp[1][6]['character'],tmp[1][6]['backgroundId'],tmp[1][6]['sumTime']]);
    prefs.setStringList('sumTimeRanking8th', [tmp[1][7]['userName'],tmp[1][7]['character'],tmp[1][7]['backgroundId'],tmp[1][7]['sumTime']]);
    prefs.setStringList('sumTimeRanking9th', [tmp[1][8]['userName'],tmp[1][8]['character'],tmp[1][8]['backgroundId'],tmp[1][8]['sumTime']]);
    prefs.setStringList('sumTimeRanking10th', [tmp[1][9]['userName'],tmp[1][9]['character'],tmp[1][9]['backgroundId'],tmp[1][9]['sumTime']]);

    prefs.setStringList('meanTimeRanking1st', [tmp[2][0]['userName'],tmp[2][0]['character'],tmp[2][0]['backgroundId'],tmp[2][0]['meanTime']]);
    prefs.setStringList('meanTimeRanking2nd', [tmp[2][1]['userName'],tmp[2][1]['character'],tmp[2][1]['backgroundId'],tmp[2][1]['meanTime']]);
    prefs.setStringList('meanTimeRanking3rd', [tmp[2][2]['userName'],tmp[2][2]['character'],tmp[2][2]['backgroundId'],tmp[2][2]['meanTime']]);
    prefs.setStringList('meanTimeRanking4th', [tmp[2][3]['userName'],tmp[2][3]['character'],tmp[2][3]['backgroundId'],tmp[2][3]['meanTime']]);
    prefs.setStringList('meanTimeRanking5th', [tmp[2][4]['userName'],tmp[2][4]['character'],tmp[2][4]['backgroundId'],tmp[2][4]['meanTime']]);
    prefs.setStringList('meanTimeRanking6th', [tmp[2][5]['userName'],tmp[2][5]['character'],tmp[2][5]['backgroundId'],tmp[2][5]['meanTime']]);
    prefs.setStringList('meanTimeRanking7th', [tmp[2][6]['userName'],tmp[2][6]['character'],tmp[2][6]['backgroundId'],tmp[2][6]['meanTime']]);
    prefs.setStringList('meanTimeRanking8th', [tmp[2][7]['userName'],tmp[2][7]['character'],tmp[2][7]['backgroundId'],tmp[2][7]['meanTime']]);
    prefs.setStringList('meanTimeRanking9th', [tmp[2][8]['userName'],tmp[2][8]['character'],tmp[2][8]['backgroundId'],tmp[2][8]['meanTime']]);
    prefs.setStringList('meanTimeRanking10th', [tmp[2][9]['userName'],tmp[2][9]['character'],tmp[2][9]['backgroundId'],tmp[2][9]['meanTime']]);

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