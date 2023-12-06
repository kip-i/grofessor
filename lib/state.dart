import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';


class DataProvider extends ChangeNotifier {
  
  String _userId = '';
  String _userName = '';

  String _nickNameId = '';
  String _nickName = '';

  String _gender = '';
  String _characterId = '';
  String _character = '';
  String _characterPath = '';

  String _backgroundId = '';
  String _backgroundPath = '';

  int _gachaTicket = 0;
  List<String> _notHaveNickNameList = [];
  List<String> _notHaveCharacterList = [];
  List<String> _notHaveBackgroundList = [];

  int _paperNum = 0;
  int _sumTime = 0;
  int _thisTime = 0;
  int _needTime = 0;
  int _achieveNum = 0;
  int _meanTime = 0;
  int _penalty = 0;

  List<String> _haveNickNameList = [];
  List<String> _haveCharacterList = [];
  List<String> _haveBackgroundList = [];

  List<List<int>> _classFlagList = [];
  List<List<int>> _classTimeList = [];

  List<List<String>> _paperNumRanking = [];
  List<List<String>> _sumTimeRanking = [];
  List<List<String>> _meanTimeRanking = [];

  void getUserId() async {
    getUseName();
    _userId = await AuthService().signIn(_userName);
    notifyListeners(); // Add this line
  }

  void getUseName() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('userName') ?? '';
    notifyListeners(); // Add this line
  }

  void getNickNameId() async {
    final prefs = await SharedPreferences.getInstance();
    _nickNameId = prefs.getString('nickNameId') ?? '';
    notifyListeners(); // Add this line
  }

  void getNickName() async {
    final prefs = await SharedPreferences.getInstance();
    _nickName = prefs.getString('nickName') ?? '';
    notifyListeners(); // Add this line
  }

  void getGender() async {
    final prefs = await SharedPreferences.getInstance();
    _gender = prefs.getString('gender') ?? '';
    notifyListeners(); // Add this line
  }
}