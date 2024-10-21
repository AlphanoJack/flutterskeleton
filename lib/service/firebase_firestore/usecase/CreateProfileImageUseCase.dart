import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_firestore/provider/FirestoreProviders.dart';
import 'package:skeleton/service/firebase_firestore/repository/FirestoreRepository.dart';

final createProfileImageProvider =
    Provider.autoDispose<CreateProfileImageUseCaseProvider>((ref) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return CreateProfileImageUseCaseProvider(firestoreRepository);
});

class CreateProfileImageUseCaseProvider {
  final FirestoreRepository firestoreRepository;

  CreateProfileImageUseCaseProvider(this.firestoreRepository);

  Future<void> execute(String userId, String profileImageUrl) async {
    await firestoreRepository.createProfileImage(userId, profileImageUrl);
  }
}
