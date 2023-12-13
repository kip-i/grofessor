import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  bool during = false;

  Future<void> setDuring(bool flag) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // during = flag;
    if (during == flag){
      print('during: ' + during.toString());
    }else{
      during = flag;
      prefs.setBool('during', during);
      print('during: ' + during.toString());
      notifyListeners();
    }
  }
}