import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_storage/providers/FirebaseStorageProvider.dart';
import 'package:skeleton/service/firebase_storage/repository/FirebaseStorageRepository.dart';

final firebaseStorageUseCaseProvider = Provider<FirebaseStorageUseCase>((ref) {
  final firebaseStorageRepository =
      ref.watch(firebaseStorageRepositoryProvider);
  return FirebaseStorageUseCase(firebaseStorageRepository);
});

class FirebaseStorageUseCase {
  final StorageRepository storageRepository;

  FirebaseStorageUseCase(this.storageRepository);

  Future<String> executeUploadImageFromApp(File appImageFile, ImageType type,
      {String? fixedFileName}) async {
    return await storageRepository.uploadImageFromApp(appImageFile, type,
        fixedFileName: fixedFileName);
  }
}
