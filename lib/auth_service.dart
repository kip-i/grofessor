import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_service.dart';

class AuthService {

  Future<List<String>> createUser(String userName, String gender) async {
    try {
      String _email = userName+'@example.com';
      String _password = 'password';
      final User? user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _email,
                  password: _password
                )).user;
      if (user != null){
        // print("ユーザ登録しました ${user.email} , ${userId} , ${userName} , ${gender}");
        // return await FirebaseService().createUser(user.uid, userName, gender)
        // .then((value) {
        //   // print("ユーザ情報を登録しました2");
        //   return [user.uid,"Success"];
        // }).onError((error, stackTrace) {
        //   // print("ユーザ情報の登録に失敗しました1 ${error}");
        //   return ["","Error"];
        // });
        print("ログインしました ${user.email} , ${user.uid}");
        return [user.uid, "Success"];
      } else {
        // print("ユーザ登録に失敗しました2");
        return ["","Error"];
      }
    } catch (e) {
      // print("ユーザ登録に失敗しました3 ${e}");
      return ["","Error"];
    }
  }

  Future<List<String>> signIn(String userName) async {
    try {
      String _email = userName+'@example.com';
      String _password = 'password';
      final User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _email,
                  password: _password
                )).user;
      if (user != null){
        print("ログインしました ${user.email} , ${user.uid}");
        return [user.uid, "Success"];
      } else{
        print("ログインに失敗しました");
        return ["","Error"];
      }
    } catch (e) {
      print(e);
      return ["","Error"];
    }
  }
}