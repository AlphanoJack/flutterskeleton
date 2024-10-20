import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skeleton/model/UserModel.dart';
import 'package:skeleton/utils/Talker.dart';

abstract class FirestoreRepository {
  Future<void> updateUserData(UserModel user);
  Stream<String> getProfileImage(String userId);
  Future<void> createProfileImage(String userId, String profileImageUrl);
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
  Stream<String> getProfileImage(String userId) {
    return _firestore.collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) {
          if (!snapshot.exists) {
            return '';
          }
          final userData = snapshot.data() as Map<String, dynamic>;
          talkerLog('FirestoreRepository(getProfileImage)', '프로필 이미지 획득 성공: ${userData['profileImageUrl']}');
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
      talkerLog('FirestoreRepository(createProfileImage)', '프로필 이미지 생성 성공: $profileImageUrl');
    } catch (e) {
      talkerError('FirestoreRepository(createProfileImage)', '프로필 이미지 생성 실패', e);
    }
  }
}
