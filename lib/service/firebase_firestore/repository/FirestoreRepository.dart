import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skeleton/model/UserModel.dart';
import 'package:skeleton/utils/Talker.dart';

abstract class FirestoreRepository {
  Future<void> updateUserData(UserModel user);
}

class FirebaseFirestoreRepository implements FirestoreRepository {
  final FirebaseFirestore _firestore;

  FirebaseFirestoreRepository(this._firestore);

  @override
  Future<void> updateUserData(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.userId).set(user.toJson());
    } catch (e) {
      talkerError(
          'FirestorePepository(updateUserData)', '유저 정보 저장에 실패했습니다.', e);
      throw Exception('updateUserData: $e');
    }
  }
}
