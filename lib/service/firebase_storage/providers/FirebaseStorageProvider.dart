import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_storage/repository/FirebaseStorageRepository.dart';
import 'package:skeleton/service/firebase_storage/usecase/FirebaseStorageUseCase.dart';

final firebaseStorageProvider = Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final firebaseStorageRepositoryProvider = Provider<FirebaseStorageRepository>((ref) {
  final firebaseStorage = ref.watch(firebaseStorageProvider);
  return FirebaseStorageRepository(firebaseStorage);
});

final firebaseStorageUseCaseProvider = Provider<FirebaseStorageUseCase>((ref) {
  final firebaseStorageRepository = ref.watch(firebaseStorageRepositoryProvider);
  return FirebaseStorageUseCase(firebaseStorageRepository);
});