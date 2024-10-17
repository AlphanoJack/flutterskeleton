import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skeleton/model/UserModel.dart';
import 'package:skeleton/service/firebase_auth/repository/FirebaseAuthRepository.dart';
import 'package:skeleton/service/firebase_firestore/repository/FirestoreRepository.dart';

class FirestoreUseCase {
  final FirebaseFirestoreRepository firestoreRepository;
  final AuthRepository authRepository;

  FirestoreUseCase(this.firestoreRepository, this.authRepository);

  Future<void> executeUpdateUserData(String email, String userNickname,
      String userName, String userPhone) async {
    final userId = authRepository.getCurrentUser()!.uid;

    final user = UserModel(
        userId: userId,
        userNickname: userNickname,
        userName: userName,
        userPhone: userPhone,
        createdAt: FieldValue.serverTimestamp(),
        profileImageUrl: '');

    await firestoreRepository.updateUserData(user);
  }
}
