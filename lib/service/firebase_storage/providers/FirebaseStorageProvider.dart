import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_storage/repository/FirebaseStorageRepository.dart';

final firebaseStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final firebaseStorageRepositoryProvider = Provider<StorageRepository>((ref) {
  final firebaseStorage = ref.watch(firebaseStorageProvider);
  return FirebaseStorageRepository(firebaseStorage);
});
