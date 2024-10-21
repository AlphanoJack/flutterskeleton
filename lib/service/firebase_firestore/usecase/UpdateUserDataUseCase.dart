import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/model/UserModel.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/service/firebase_auth/repository/FirebaseAuthRepository.dart';
import 'package:skeleton/service/firebase_firestore/provider/FirestoreProviders.dart';
import 'package:skeleton/service/firebase_firestore/repository/FirestoreRepository.dart';

final updateUserDataUseCaseProvider =
    Provider.autoDispose<UpdateUserDataUseCase>((ref) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return UpdateUserDataUseCase(firestoreRepository, authRepository);
});

class UpdateUserDataUseCase {
  final FirestoreRepository firestoreRepository;
  final AuthRepository authRepository;

  UpdateUserDataUseCase(this.firestoreRepository, this.authRepository);

  Future<void> execute(String email, String userNickname, String userName,
      String userPhone) async {
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
