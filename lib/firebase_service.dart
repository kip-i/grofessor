import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';


class FirebaseService {
  final CollectionReference _rootCollection = FirebaseFirestore.instance.collection('dev');


//=== 追加 ==========================================================================================================//

  // アカウント作成, db初期化
  Future<void> createUser(String userId, String userName, String gender) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await getNeedTime(0).then((value) async {
      await userCollection.doc('user').set({
        'userName': userName,
        'nickNameId': '',
        'backgroundId': '',
        'character': '${gender}0',   // gender = 'm' or 'w'
      }).then((value) async{
        await userCollection.doc('gacha').set({
          'gachaTicket': 0,
        }).then((value) async{
          await userCollection.doc('achieve').set({
            'paperNum': 0,
            'sumTime': 0,
            'thisTime': 0,
            'needTime': value,   // paperNumをIDとしてneedTimesから取得
            'achieveNum': 0,
            'meanTime': 0,
            'penalty': false,
          }).then((value) async {
            await userCollection.doc('nickName').set({
              'haveList': [],
            }).then((value) async {
              await userCollection.doc('character').set({
                'haveList': [],
              }).then((value) async {
                await userCollection.doc('background').set({
                  'haveList': [],
                }).then((value) async {
                  final CollectionReference classCollection = userCollection.doc('schedule').collection('class');
                  await classCollection.doc('class').set({
                    'monday': [false,false,false,false,false,false],
                    'tuesday': [false,false,false,false,false,false],
                    'wednesday': [false,false,false,false,false,false],
                    'thursday': [false,false,false,false,false,false],
                    'friday': [false,false,false,false,false,false],
                    'saturday': [false,false,false,false,false,false],
                  }).then((value) async {
                    await classCollection.doc('time').set({
                      '1st': [0,0,0,0],
                      '2nd': [0,0,0,0],
                      '3rd': [0,0,0,0],
                      '4th': [0,0,0,0],
                      '5th': [0,0,0,0],
                      '6th': [0,0,0,0],
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
  }

  // 獲得済みの二つ名IDリストに追加
  Future<void> addHaveNickName(String userId, String nickNameId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('nickName').get()
    .then((value) async {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      List<String> haveList = data?['haveList'];
      haveList.add(nickNameId);
      await userCollection.doc('nickName').update({
        'haveList': haveList,
      });
    });
  }

  // 獲得済みの3DモデルIDリストに追加
  Future<void> addHaveCharacter(String userId, String characterId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('character').get()
    .then((value) async {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      List<String> haveList = data?['haveList'];
      haveList.add(characterId);
      await userCollection.doc('character').update({
        'haveList': haveList,
      });
    });
  }

  // 獲得済みの背景画像IDリストに追加
  Future<void> addHaveBackground(String userId, String backgroundId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('background').get()
    .then((value) async {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      List<String> haveList = data?['haveList'];
      haveList.add(backgroundId);
      await userCollection.doc('background').update({
        'haveList': haveList,
      });
    });
  }

//=== 取得 ==========================================================================================================//

  // ランキングを取得
  // Future<List<Map<String, dynamic>>> getRanking() async {
  //   final CollectionReference userCollection = _rootCollection.doc('ranking').collection('ranking');
  //   List<Map<String, dynamic>> ranking = [];
  //   await userCollection.orderBy('sumTime', descending: false).limit(10).get()
  //   .then((value) {
  //     value.docs.forEach((element) {
  //       Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
  //       ranking.add(data);
  //     });
  //   });
  //   return ranking;
  // }

  // 二つ名本体を取得
  Future<String> getNickName(String nickNameId) async {
    await _rootCollection.doc('nickNames').collection('nickNames').doc(nickNameId).get()
    .then((value) {
      Map<String, dynamic>? data = value.data();
      return data?['nickName'];
    });
    return 'error';
  }

  // 3DモデルのURLを取得
  Future<String> getCharacter(String character) async {
    String gender = character[0];
    String characterId = character[1];
    await _rootCollection.doc('characters').collection(gender).doc(characterId).get()
    .then((value) {
      Map<String, dynamic>? data = value.data();
      return data?['characterPath'];
    });
    return 'error';
  }

  // 背景画像のURLを取得
  Future<String> getBackground(String backgroundId) async {
    await _rootCollection.doc('backgrounds').collection('backgrounds').doc(backgroundId).get()
    .then((value) {
      Map<String, dynamic>? data = value.data();
      return data?['backgroundPath'];
    });
    return 'error';
  }

  // レベルごとの論文完成までの必要時間を取得
  Future<int> getNeedTime(int paperNum) async {
    String paper = paperNum.toString();
    await _rootCollection.doc('needTimes').collection('needTimes').doc(paper).get()
    .then((value) {
      Map<String, dynamic>? data = value.data();
      return data?['needTime'];
    });
    return -1;
  }

  // 獲得済みの二つ名IDリストを取得
  Future<List<String>> getHaveNickNameList(String userId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('nickName').get()
    .then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data?['haveList'];
    });
    return ['error'];
  }

  // 獲得済みの3DモデルIDリストを取得
  Future<List<String>> getHaveCharacterList(String userId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('character').get()
    .then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data?['haveList'];
    });
    return ['error'];
  }

  // 獲得済みの背景画像IDリストを取得
  Future<List<String>> getHaveBackgroundList(String userId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('background').get()
    .then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data?['haveList'];
    });
    return ['error'];
  }

  // 講義有無スケジュールを2次元配列で取得
  Future<List<List<bool>>> getClassExisteSchedule(String userId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('schedule').collection('class').doc('class').get()
    .then((value) {
      Map<String, dynamic>? data = value.data();
      return [data?['monday'], data?['tuesday'], data?['wednesday'], data?['thursday'], data?['friday'], data?['saturday']];
    });
    return [[false]];
  }

  // 講義時間スケジュールを2次元配列で取得
  Future<List<List<int>>> getClassTimeSchedule(String userId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('schedule').collection('class').doc('time').get()
    .then((value) {
      Map<String, dynamic>? data = value.data();
      return [data?['1st'], data?['2nd'], data?['3rd'], data?['4th'], data?['5th'], data?['6th']];
    });
    return [[-1]];
  }

  // ユーザ情報を取得
  Future<Map<String, dynamic>> getUserInfo(String userId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('user').get()
    .then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data;
    });
    return {'error': 'error'};
  }

  // ユーザの論文・時間情報を取得
  Future<Map<String, dynamic>> getUserAchieve(String userId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('achieve').get()
    .then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data;
    });
    return {'error': 'error'};
  }

  // ユーザのガチャチケット情報を取得
  Future<int> getUserGachaTicket(String userId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('gacha').get()
    .then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data?['gachaTicket'];
    });
    return -1;
  }


//=== 更新 ==========================================================================================================//

  // ユーザ名の更新
  Future<void> updateUserName(String userId, String userName) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('user').update({
      'userName': userName,
    });
  }

  // 選択ニックネームIDの更新
  Future<void> updateNickNameId(String userId, String nickNameId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('user').update({
      'nickNameId': nickNameId,
    });
  }

  // 選択背景画像IDの更新
  Future<void> updateBackgroundId(String userId, String backgroundId) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('user').update({
      'backgroundId': backgroundId,
    });
  }

  // 選択3DモデルIDの更新
  Future<void> updateCharacter(String userId, String character) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('user').update({
      'character': character,
    });
  }

  // ガチャチケットの更新
  Future<void> updateGachaTicket(String userId, int num) async {
    final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);
    await userCollection.doc('gacha').update({
      'gachaTicket': FieldValue.increment(num),
    });
  }

  // 達成時間などの更新
  Future<void> updateAchieve(String userId, bool penalty, int time) async {
    await getUserInfo(userId).then((value) async {
      final CollectionReference userCollection = _rootCollection.doc('users').collection(userId);

      int paperNum = value['paperNum'];
      int sumTime = value['sumTime'];
      int thisTime = value['thisTime'];
      int needTime = value['needTime'];
      int achieveNum = value['achieveNum'];
      // bool penalty = value['penalty'];  // ペナルティー機能をつける場合はこのフラグを利用

      sumTime += time;
      thisTime += time;
      achieveNum += 1;
      double meanTime = sumTime / achieveNum;

      if (thisTime >= needTime) {
        paperNum += 1;
        thisTime = thisTime - needTime;
        await getNeedTime(paperNum).then((value) async {
          needTime = value;
          await userCollection.doc('user').update({
            'paperNum': paperNum,
            'sumTime': sumTime,
            'thisTime': thisTime,
            'needTime': needTime,
            'achieveNum': achieveNum,
            'meanTime': meanTime,
            'penalty': penalty ? true : false,
          }).then((value) async {
            if (paperNum != 0 && paperNum % 3 == 0){
              await updateGachaTicket(userId, 1);
            }
          });
        });
      } else {
        await userCollection.doc('achieve').update({
          'sumTime': sumTime,
          'thisTime': thisTime,
          'achieveNum': achieveNum,
          'meanTime': meanTime,
          'penalty': penalty ? true : false,
        });
      }      
    });
  }

  // ランキングの更新
  // Future<void> updateRanking(String userId, int time) async {
  //   final CollectionReference userCollection = _rootCollection.doc('ranking').collection('ranking');
  //   await userCollection.doc(userId).get()
  //   .then((value) async {
  //     if (value.exists) {
  //       Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
  //       if (data?['sumTime'] > time) {
  //         await userCollection.doc(userId).update({
  //           'sumTime': time,
  //         });
  //       }
  //     } else {
  //       await userCollection.doc(userId).set({
  //         'sumTime': time,
  //       });
  //     }
  //   });
  // }

}