import 'package:firebase_auth/firebase_auth.dart';


class AuthService {

  Future<String> addUser(String userName) async {
    try {
      String _email = userName+'@example.com';
      String _password = 'password';
      final User? user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _email,
                  password: _password
                )).user;
      if (user != null){
        print("ユーザ登録しました ${user.email} , ${user.uid}");
        return "Success";
      } else{
        print("ユーザ登録に失敗しました");
        return "Error";
      }
    } catch (e) {
      print("ユーザ登録に失敗しました ${e}");
      return "Error";
    }
  }

  Future<String> signIn(String userName) async {
    try {
      String _email = userName+'@example.com';
      String _password = 'password';
      final User? user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _email,
                  password: _password
                )).user;
      if (user != null){
        print("ログインしました　${user.email} , ${user.uid}");
        return "Success";
      } else{
        print("ログインに失敗しました");
        return "Error";
      }
    } catch (e) {
      print(e);
      return "Error";
    }
  }
}