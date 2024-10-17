import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/service/firebase_firestore/repository/FirestoreRepository.dart';
import 'package:skeleton/service/firebase_firestore/usecase/FirestoreUseCase.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firestoreRepositoryProvider = Provider<FirebaseFirestoreRepository>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirebaseFirestoreRepository(firestore);
});

final firestoreUseCaseProvider = Provider<FirestoreUseCase>((ref) {
  final firestoreRepository = ref.watch(firestoreRepositoryProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  return FirestoreUseCase(firestoreRepository, authRepository);
});