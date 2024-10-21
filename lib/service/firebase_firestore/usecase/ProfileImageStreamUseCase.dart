import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_firestore/provider/FirestoreProviders.dart';
import 'package:skeleton/service/firebase_firestore/repository/FirestoreRepository.dart';

final getUserProfileImageProvider = Provider<GetUserImageStreamUseCase>((ref) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  return GetUserImageStreamUseCase(firestoreRepository);
});

final profileImageStream =
    StreamProvider.autoDispose.family<String, String>((ref, userId) {
  final getProfileImageUseCase = ref.watch(getUserProfileImageProvider);
  return getProfileImageUseCase.execute(userId);
});

class GetUserImageStreamUseCase {
  final FirestoreRepository firestoreRepository;

  GetUserImageStreamUseCase(this.firestoreRepository);

  Stream<String> execute(String userId) {
    return firestoreRepository.getUserProfileStream(userId);
  }
}
