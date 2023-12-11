import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  final CollectionReference _rootCollection =
      FirebaseFirestore.instance.collection('dev');

//=== 追加 ==========================================================================================================//

  // アカウント作成, db初期化
  Future<void> createUser(String userId, String userName, String gender) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);

    await userCollection.doc('user').set({
      'userName': userName,
      'nickNameId': 'n0',
      'backgroundId': 'b0',
      'characterId': '${gender}0', // gender = 'm' or 'w'
    }).then((value) async {
      List<String> nickNameIdList = await getAllNickNameId();
      nickNameIdList.remove('n0');
      List<String> characterIdList = await getAllCharacterId(gender);
      characterIdList.remove('${gender}0');
      List<String> backgroundIdList = await getAllBackgroundId();
      backgroundIdList.remove('b0');
      await userCollection.doc('gacha').set({
        'gachaTicket': 0,
        // 'notHaveNickNameList': ['n1', 'n2'],
        'notHaveNickNameList': nickNameIdList,
        // 'notHaveCharacterList': ['${gender}1', '${gender}m2'],
        'notHaveCharacterList': characterIdList,
        // 'notHaveBackgroundList': ['b1', 'b2'],
        'notHaveBackgroundList': backgroundIdList,
      }).then((value) async {
        await getNeedTime(0).then((value) async {
          await userCollection.doc('achieve').set({
            'paperNum': 0,
            'sumTime': 0,
            'thisTime': 0,
            'needTime': value, // paperNumをIDとしてneedTimesから取得
            'achieveNum': 0,
            'meanTime': 0,
            'penalty': false,
          }).then((value) async {
            await userCollection.doc('nickName').set({
              'haveList': ['n0'],
            }).then((value) async {
              await userCollection.doc('character').set({
                'haveList': ['${gender}0'],
              }).then((value) async {
                await userCollection.doc('background').set({
                  'haveList': ['b0'],
                }).then((value) async {
                  final CollectionReference classCollection =
                      userCollection.doc('schedule').collection('class');
                  await classCollection.doc('class').set({
                    'monday': [false, false, false, false, false, false],
                    'tuesday': [false, false, false, false, false, false],
                    'wednesday': [false, false, false, false, false, false],
                    'thursday': [false, false, false, false, false, false],
                    'friday': [false, false, false, false, false, false],
                    'saturday': [false, false, false, false, false, false],
                  }).then((value) async {
                    await classCollection.doc('time').set({
                      '1st': [0, 0, 0, 0],
                      '2nd': [0, 0, 0, 0],
                      '3rd': [0, 0, 0, 0],
                      '4th': [0, 0, 0, 0],
                      '5th': [0, 0, 0, 0],
                      '6th': [0, 0, 0, 0],
                      // }).then((value) {
                      //   print("ユーザ情報を登録しました1");
                      // }).onError((error, stackTrace) {
                      //   print("ユーザ情報の登録に失敗しました5 ${error}");
                    });
                  });
                });
              });
            });
          });
        });
      });
    });
    await _rootCollection
        .doc('rankings')
        .collection('userData')
        .doc(userId)
        .set({
      'userName': userName,
      'nickName': '研究生',
      'paperNum': 0,
      'paperNumUpdated': DateTime.now(),
      'sumTime': 0,
      'meanTime': 0,
      'timeUpdated': DateTime.now(),
    });
  }

  // 獲得済みの二つ名IDリストに追加
  Future<void> addHaveNickName(String userId, String nickNameId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('nickName').get().then((value) async {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      List<String> haveList = data?['haveList'] as List<String>;
      haveList.add(nickNameId);
      await userCollection.doc('nickName').update({
        'haveList': haveList,
      });
    });
  }

  // 獲得済みの3DモデルIDリストに追加
  Future<void> addHaveCharacter(String userId, String characterId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('character').get().then((value) async {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      List<String> haveList = data?['haveList'] as List<String>;
      haveList.add(characterId);
      await userCollection.doc('character').update({
        'haveList': haveList,
      });
    });
  }

  // 獲得済みの背景画像IDリストに追加
  Future<void> addHaveBackground(String userId, String backgroundId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('background').get().then((value) async {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      List<String> haveList = data?['haveList'] as List<String>;
      haveList.add(backgroundId);
      await userCollection.doc('background').update({
        'haveList': haveList,
      });
    });
  }

//=== 削除 ==========================================================================================================//

  // 未獲得の二つ名IDリストから削除
  Future<void> deleteNotHaveNickName(String userId, String nickNameId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('gacha').get().then((value) async {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      List<String> notHaveList = data?['notHaveNickNameList'] as List<String>;
      notHaveList.remove(nickNameId);
      await userCollection.doc('gacha').update({
        'notHaveNickNameList': notHaveList,
      });
    });
  }

  // 未獲得の3DモデルIDリストから削除
  Future<void> deleteNotHaveCharacter(String userId, String characterId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('gacha').get().then((value) async {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      List<String> notHaveList = data?['notHaveCharacterList'] as List<String>;
      notHaveList.remove(characterId);
      await userCollection.doc('gacha').update({
        'notHaveCharacterList': notHaveList,
      });
    });
  }

  // 未獲得の背景画像IDリストから削除
  Future<void> deleteNotHaveBackground(
      String userId, String backgroundId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('gacha').get().then((value) async {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      List<String> notHaveList = data?['notHaveBackgroundList'] as List<String>;
      notHaveList.remove(backgroundId);
      await userCollection.doc('gacha').update({
        'notHaveBackgroundList': notHaveList,
      });
    });
  }

//=== 取得 ==========================================================================================================//

  // 3種類のランキングを取得
  Future<List<List<dynamic>>> getRanking() async {
    DateTime now = DateTime.now();
    DateTime nextUpdateTime = await getRankingUpdateTime();
    if (now.isAfter(nextUpdateTime)) {
      print('ランキング更新');
      return await updateRanking('userId', nextUpdateTime, now)
          .then((value) async {
        List<List> pRanking = await getPaperNumRanking();
        List<List> sRanking = await getSumTimeRanking();
        List<List> mRanking = await getMeanTimeRanking();
        return [pRanking, sRanking, mRanking];
      });
    } else {
      List<List> pRanking = await getPaperNumRanking();
      List<List> sRanking = await getSumTimeRanking();
      List<List> mRanking = await getMeanTimeRanking();
      return [pRanking, sRanking, mRanking];
    }
  }

  // 論文数によるランキングを取得
  Future<List<List<dynamic>>> getPaperNumRanking() async {
    return await _rootCollection
        .doc('rankings')
        .collection('rankings')
        .doc('paperNumRanking')
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return [
        data?['1st'],
        data?['2nd'],
        data?['3rd'],
        data?['4th'],
        data?['5th'],
        data?['6th'],
        data?['7th'],
        data?['8th'],
        data?['9th'],
        data?['10th']
      ];
    });
  }

  // 合計時間によるランキングを取得
  Future<List<List<dynamic>>> getSumTimeRanking() async {
    return await _rootCollection
        .doc('rankings')
        .collection('rankings')
        .doc('sumTimeRanking')
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return [
        data?['1st'],
        data?['2nd'],
        data?['3rd'],
        data?['4th'],
        data?['5th'],
        data?['6th'],
        data?['7th'],
        data?['8th'],
        data?['9th'],
        data?['10th']
      ];
    });
  }

  // 平均時間によるランキングを取得
  Future<List<List<dynamic>>> getMeanTimeRanking() async {
    return await _rootCollection
        .doc('rankings')
        .collection('rankings')
        .doc('meanTimeRanking')
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return [
        data?['1st'],
        data?['2nd'],
        data?['3rd'],
        data?['4th'],
        data?['5th'],
        data?['6th'],
        data?['7th'],
        data?['8th'],
        data?['9th'],
        data?['10th']
      ];
    });
  }

  // ランキング更新時間を取得
  Future<DateTime> getRankingUpdateTime() async {
    return await _rootCollection
        .doc('rankings')
        .collection('rankingUpdate')
        .doc('updateTime')
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return data?['nextUpdateTime'].toDate();
    });
  }

  // 二つ名本体を取得
  Future<String> getNickName(String nickNameId) async {
    return await _rootCollection
        .doc('nickNames')
        .collection('nickNames')
        .doc(nickNameId)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return data?['nickName'];
    });
    // return 'error';
  }

  // 二つ名の総数を取得
  Future<int> getTotalNickNameNum() async {
    return await _rootCollection
        .doc('nickNames')
        .collection('nickNames')
        .count()
        .get()
        .then((value) {
      return value.count;
    });
    // return -1;
  }

  // 二つ名IDを全て取得
  Future<List<String>> getAllNickNameId() async {
    return await _rootCollection
        .doc('nickNames')
        .collection('nickNames')
        .get()
        .then((value) {
      List<String> nickNameIdList = [];
      value.docs.forEach((element) {
        nickNameIdList.add(element.id);
      });
      return nickNameIdList;
    });
    // return ['error'];
  }

  // 二つ名を全て取得
  Future<List<String>> getAllNickName() async {
    return await _rootCollection
        .doc('nickNames')
        .collection('nickNames')
        .get()
        .then((value) {
      List<String> nickNameList = [];
      value.docs.forEach((element) {
        Map<String, dynamic> data = element.data();
        nickNameList.add(data['nickName'] as String);
      });
      return nickNameList;
    });
    // return ['error'];
  }

  // 3DモデルのURLを取得
  Future<String> getCharacter(String characterId) async {
    return await _rootCollection
        .doc('characters')
        .collection(characterId[0])
        .doc(characterId)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return data?['characterPath'];
    });
    // return 'error';
  }

  // 3Dモデルの総数を取得
  Future<int> getTotalCharacterNum() async {
    int num = 0;
    int m_num = 0;
    int w_num = 0;

    m_num = await _rootCollection
        .doc('characters')
        .collection('m')
        .count()
        .get()
        .then((value) {
      return value.count;
    });
    w_num = await _rootCollection
        .doc('characters')
        .collection('w')
        .count()
        .get()
        .then((value) {
      return value.count;
    });
    num = m_num + w_num;
    return num;
    // return -1;
  }

  // 3DモデルIDを全て取得
  Future<List<String>> getAllCharacterId(String _gender) async {
    List<String> characterIdList = [];
    await _rootCollection
        .doc('characters')
        .collection(_gender)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        characterIdList.add(element.id);
      });
    });
    return characterIdList;
    // return ['error'];
  }

  // 3Dモデルを全て取得
  Future<List<String>> getAllCharacterPath(String _gender) async {
    List<String> characterPathList = [];
    await _rootCollection
        .doc('characters')
        .collection(_gender)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Map<String, dynamic> data = element.data();
        characterPathList.add(data['characterPath'] as String);
      });
    });
    return characterPathList;
    // return ['error'];
  }

  // 背景画像のURLを取得
  Future<String> getBackground(String backgroundId) async {
    return await _rootCollection
        .doc('backgrounds')
        .collection('backgrounds')
        .doc(backgroundId)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return data?['backgroundPath'];
    });
    // return 'error';
  }

  // 背景画像の総数を取得
  Future<int> getTotalBackgroundNum() async {
    return await _rootCollection
        .doc('backgrounds')
        .collection('backgrounds')
        .count()
        .get()
        .then((value) {
      return value.count;
    });
    // return -1;
  }

  // 背景画像IDを全て取得
  Future<List<String>> getAllBackgroundId() async {
    return await _rootCollection
        .doc('backgrounds')
        .collection('backgrounds')
        .get()
        .then((value) {
      List<String> backgroundIdList = [];
      value.docs.forEach((element) {
        backgroundIdList.add(element.id);
      });
      return backgroundIdList;
    });
    // return ['error'];
  }

  // 背景画像を全て取得
  Future<List<String>> getAllBackgroundPath() async {
    return await _rootCollection
        .doc('backgrounds')
        .collection('backgrounds')
        .get()
        .then((value) {
      List<String> backgroundPathList = [];
      value.docs.forEach((element) {
        Map<String, dynamic> data = element.data();
        backgroundPathList.add(data['backgroundPath'] as String);
      });
      return backgroundPathList;
    });
    // return ['error'];
  }

  // レベルごとの論文完成までの必要時間を取得
  Future<int> getNeedTime(int paperNum) async {
    String paper = paperNum.toString();
    return await _rootCollection
        .doc('needTimes')
        .collection('needTimes')
        .doc(paper)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return data?['needTime'];
    });
    // return -1;
  }

  // 獲得済みの二つ名IDリストを取得
  Future<List<String>> getHaveNickNameList(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    return await userCollection.doc('nickName').get().then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data?['haveList'] as List<String>;
    });
    // return ['error'];
  }

  // 獲得済みの3DモデルIDリストを取得
  Future<List<String>> getHaveCharacterList(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    return await userCollection.doc('character').get().then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data?['haveList'] as List<String>;
    });
    // return ['error'];
  }

  // 獲得済みの背景画像IDリストを取得
  Future<List<String>> getHaveBackgroundList(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    return await userCollection.doc('background').get().then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data?['haveList'] as List<String>;
    });
    // return ['error'];
  }

  // 講義有無スケジュールを2次元配列で取得
  Future<List<List<bool>>> getClassExisteSchedule(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    return await userCollection
        .doc('schedule')
        .collection('class')
        .doc('class')
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return [
        data?['monday'] as List<bool>,
        data?['tuesday'] as List<bool>,
        data?['wednesday'] as List<bool>,
        data?['thursday'] as List<bool>,
        data?['friday'] as List<bool>,
        data?['saturday'] as List<bool>
      ];
    });
    // return [[false]];
  }

  // 講義時間スケジュールを2次元配列で取得
  Future<List<List<int>>> getClassTimeSchedule(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    return await userCollection
        .doc('schedule')
        .collection('class')
        .doc('time')
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      return [
        data?['1st'] as List<int>,
        data?['2nd'] as List<int>,
        data?['3rd'] as List<int>,
        data?['4th'] as List<int>,
        data?['5th'] as List<int>,
        data?['6th'] as List<int>
      ];
    });
    // return [[-1]];
  }

  // ユーザ情報を取得
  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    return await userCollection.doc('user').get().then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data;
    });
    // return {'error': 'error'};
  }

  // ユーザの論文・時間情報を取得
  Future<Map<String, dynamic>?> getUserAchieve(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    return await userCollection.doc('achieve').get().then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data;
    });
    // return {'error': 'error'};
  }

  // ユーザのガチャ情報を取得
  Future<Map<String, dynamic>?> getUserGacha(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    return await userCollection.doc('gacha').get().then((value) {
      Map<String, dynamic>? data = value.data() as Map<String, dynamic>?;
      return data;
    });
    // return {'error': 'error'};
  }

//=== 更新 ==========================================================================================================//

  // ユーザ名の更新
  Future<void> updateUserName(String userId, String userName) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('user').update({
      'userName': userName,
    }).then((value) async {
      await _rootCollection
          .doc('rankings')
          .collection('userData')
          .doc(userId)
          .update({
        'userName': userName,
      });
    });
  }

  // 選択ニックネームIDの更新
  Future<void> updateNickNameId(String userId, String nickNameId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('user').update({
      'nickNameId': nickNameId,
      // }).then((value) async {
      //   await _rootCollection
      //       .doc('rankings')
      //       .collection('userData')
      //       .doc(userId)
      //       .update({
      //     'nickName': nickNameId,
      //   });
    });
  }

  // 選択ニックネームの更新
  Future<void> updateNickName(String userId, String nickName) async {
    await _rootCollection
        .doc('rankings')
        .collection('userData')
        .doc(userId)
        .update({
      'nickName': nickName,
    });
  }

  // 選択背景画像IDの更新
  Future<void> updateBackgroundId(String userId, String backgroundId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('user').update({
      'backgroundId': backgroundId,
      // })
      // .then((value) async {
      //   await _rootCollection
      //       .doc('rankings')
      //       .collection('userData')
      //       .doc(userId)
      //       .update({
      //     'backgroundId': backgroundId,
      //   });
    });
  }

  // 選択3DモデルIDの更新
  Future<void> updateCharacter(String userId, String characterId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('user').update({
      'characterId': characterId,
      // }).then((value) async {
      //   await _rootCollection
      //       .doc('rankings')
      //       .collection('userData')
      //       .doc(userId)
      //       .update({
      //     'characterId': characterId,
      //   });
    });
  }

  // ガチャチケットの更新
  Future<void> updateGachaTicket(String userId, int num) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection.doc('gacha').update({
      'gachaTicket': FieldValue.increment(num),
    });
  }

  // 時間割(有無)の更新
  Future<void> updateClassExisteSchedule(
      String userId, List<List<bool>> schedule) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection
        .doc('schedule')
        .collection('class')
        .doc('class')
        .update({
      'monday': schedule[0],
      'tuesday': schedule[1],
      'wednesday': schedule[2],
      'thursday': schedule[3],
      'friday': schedule[4],
      'saturday': schedule[5],
    });
  }

  // 時間割(時間)の更新
  Future<void> updateClassTimeSchedule(
      String userId, List<List<int>> schedule) async {
    final CollectionReference userCollection =
        _rootCollection.doc('users').collection(userId);
    await userCollection
        .doc('schedule')
        .collection('class')
        .doc('time')
        .update({
      '1st': schedule[0],
      '2nd': schedule[1],
      '3rd': schedule[2],
      '4th': schedule[3],
      '5th': schedule[4],
      '6th': schedule[5],
    });
  }

  // 達成時間などの更新
  Future<void> updateAchieve(String userId, bool penalty, int time) async {
    await getUserInfo(userId).then((value) async {
      final CollectionReference userCollection =
          _rootCollection.doc('users').collection(userId);

      int paperNum = value?['paperNum'];
      int sumTime = value?['sumTime'];
      int thisTime = value?['thisTime'];
      int needTime = value?['needTime'];
      int achieveNum = value?['achieveNum'];
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
            if (paperNum != 0 && paperNum % 3 == 0) {
              await updateGachaTicket(userId, 1);
            }
            await _rootCollection
                .doc('rankings')
                .collection('userData')
                .doc(userId)
                .update({
              'paperNum': paperNum,
              'paperNumUpdated': DateTime.now(),
              'sumTime': sumTime,
              'meanTime': meanTime,
              'timeUpdated': DateTime.now(),
            });
          });
        });
      } else {
        await userCollection.doc('achieve').update({
          'sumTime': sumTime,
          'thisTime': thisTime,
          'achieveNum': achieveNum,
          'meanTime': meanTime,
          'penalty': penalty ? true : false,
        }).then((value) async {
          await _rootCollection
              .doc('rankings')
              .collection('userData')
              .doc(userId)
              .update({
            'sumTime': sumTime,
            'meanTime': meanTime,
            'timeUpdated': DateTime.now(),
          });
        });
      }
    });
  }

  // ランキングの更新
  Future<void> updateRanking(String userId, DateTime last, DateTime now) async {
    await updatePaperNumRanking(userId);
    await updateSumTimeRanking(userId);
    await updateMeanTimeRanking(userId);
    await updateLastUpdateTime(userId, last, now);
  }

  // 論文数によるランキングの更新
  Future<void> updatePaperNumRanking(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('rankings').collection('userData');
    // FirebaseFirestore.instance
    //     .collection('test')
    //     .doc('testData')
    //     .collection('testData');
    List<List<String>> ranking = [];
    await userCollection
        .orderBy('paperNum', descending: true)
        .orderBy('paperNumUpdated', descending: false)
        .limit(10)
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
        List<String> tmp = [
          data?['userName'],
          data?['nickName'],
          data?['paperNum'].toString() as String
        ];
        ranking.add(tmp);
      });
      for (int i = ranking.length; i < 10; i++) {
        ranking.add(['', '', '']);
      }
      print('ランキング１：' + ranking.toString());
      await _rootCollection
          .doc('rankings')
          .collection('rankings')
          .doc('paperNumRanking')
          .update({
        '1st': ranking[0],
        '2nd': ranking[1],
        '3rd': ranking[2],
        '4th': ranking[3],
        '5th': ranking[4],
        '6th': ranking[5],
        '7th': ranking[6],
        '8th': ranking[7],
        '9th': ranking[8],
        '10th': ranking[9],
      });
    });
  }

  // 合計時間によるランキングの更新
  Future<void> updateSumTimeRanking(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('rankings').collection('userData');
    // FirebaseFirestore.instance
    //     .collection('test')
    //     .doc('testData')
    //     .collection('testData');
    List<List<String>> ranking = [];
    await userCollection
        .orderBy('sumTime', descending: true)
        .orderBy('timeUpdated', descending: false)
        .limit(10)
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
        List<String> tmp = [
          data?['userName'],
          data?['nickName'],
          data?['sumTime'].toString() as String
        ];
        ranking.add(tmp);
      });
      for (int i = ranking.length; i < 10; i++) {
        ranking.add(['', '', '']);
      }
      await _rootCollection
          .doc('rankings')
          .collection('rankings')
          .doc('sumTimeRanking')
          .update({
        '1st': ranking[0],
        '2nd': ranking[1],
        '3rd': ranking[2],
        '4th': ranking[3],
        '5th': ranking[4],
        '6th': ranking[5],
        '7th': ranking[6],
        '8th': ranking[7],
        '9th': ranking[8],
        '10th': ranking[9],
      });
    });
  }

  // 平均時間によるランキングの更新
  Future<void> updateMeanTimeRanking(String userId) async {
    final CollectionReference userCollection =
        _rootCollection.doc('rankings').collection('userData');
    // FirebaseFirestore.instance
    //     .collection('test')
    //     .doc('testData')
    //     .collection('testData');
    List<List<String>> ranking = [];
    await userCollection
        .orderBy('meanTime', descending: true)
        .orderBy('timeUpdated', descending: false)
        .limit(10)
        .get()
        .then((value) async {
      value.docs.forEach((element) {
        Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;
        List<String> tmp = [
          data?['userName'],
          data?['nickName'],
          data?['meanTime'].toString() as String
        ];
        ranking.add(tmp);
      });
      for (int i = ranking.length; i < 10; i++) {
        ranking.add(['', '', '']);
      }
      await _rootCollection
          .doc('rankings')
          .collection('rankings')
          .doc('meanTimeRanking')
          .update({
        '1st': ranking[0],
        '2nd': ranking[1],
        '3rd': ranking[2],
        '4th': ranking[3],
        '5th': ranking[4],
        '6th': ranking[5],
        '7th': ranking[6],
        '8th': ranking[7],
        '9th': ranking[8],
        '10th': ranking[9],
      });
    });
  }

  // 最新更新時間の更新
  Future<void> updateLastUpdateTime(
      String userId, DateTime last, DateTime now) async {
    final CollectionReference userCollection =
        _rootCollection.doc('rankings').collection('rankingUpdate');
    // DateTime next = DateTime(now.year, now.month, now.day + 1, last.hour, last.minute, last.second); // 1日1回更新
    // DateTime next = DateTime(now.year, now.month, now.day, now.hour+1, last.minute, last.second); // 1時間1回更新
    DateTime next = DateTime(now.year, now.month, now.day, now.hour,
        now.minute + 10, last.second); // 10分1回更新
    await userCollection.doc('updateTime').update({
      'nextUpdateTime': next,
    });
  }
}
