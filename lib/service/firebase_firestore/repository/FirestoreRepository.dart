import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skeleton/model/UserModel.dart';
import 'package:skeleton/utils/Talker.dart';

abstract class FirestoreRepository {
  Future<void> updateUserData(UserModel user);
  Stream<String> getUserProfileStream(String userId);
  Future<void> createProfileImage(String userId, String profileImageUrl);
  Future<Map<String, dynamic>?> getUserInfo(String userId);
}

class FirebaseFirestoreRepository implements FirestoreRepository {
  final FirebaseFirestore _firestore;

  FirebaseFirestoreRepository(this._firestore);

  @override
  Future<void> updateUserData(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.userId).set(user.toJson());
      talkerLog('FirebaseRepository(updateUserData)', '유저 정보 저장 성공');
    } catch (e) {
      talkerError(
          'FirestorePepository(updateUserData)', '유저 정보 저장에 실패했습니다.', e);
      throw Exception('updateUserData: $e');
    }
  }

  @override
  Stream<String> getUserProfileStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      if (!snapshot.exists) {
        return '';
      }
      final userData = snapshot.data() as Map<String, dynamic>;
      talkerLog('FirestoreRepository(getProfileImage)',
          '프로필 이미지 획득 성공: ${userData['profileImageUrl']}');
      return userData['profileImageUrl'] ?? '';
    });
  }

  @override
  Future<void> createProfileImage(String userId, String profileImageUrl) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'profileImageUrl': profileImageUrl});
      talkerLog('FirestoreRepository(createProfileImage)',
          '프로필 이미지 생성 성공: $profileImageUrl');
    } catch (e) {
      talkerError(
          'FirestoreRepository(createProfileImage)', '프로필 이미지 생성 실패', e);
    }
  }

  @override
  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    try {
      final userDocSnapSnapshot =
          await _firestore.collection('users').doc(userId).get();
      talkerLog('FireStroageRepository', '유저정보 가져오기 성공');
      if (userDocSnapSnapshot.exists) {
        talkerLog(
            'FireStorageRepository', '유저정보: ${userDocSnapSnapshot.data()}');
        return userDocSnapSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      talkerError('FirestoreReposotory(getUserInfo)', '유저정보를 가져오는데 실패했습니다.', e);
      return null;
    }
  }
}
