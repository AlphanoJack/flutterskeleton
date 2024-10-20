import 'dart:io';

import 'package:skeleton/service/firebase_storage/repository/FirebaseStorageRepository.dart';

class FirebaseStorageUseCase {
  final FirebaseStorageRepository firebaseStorageRepository;

  FirebaseStorageUseCase(this.firebaseStorageRepository);

  Future<String> executeUploadImageFromApp(File appImageFile, ImageType type, {String? fixedFileName}) async {
    return await firebaseStorageRepository.uploadImageFromApp(appImageFile, type, fixedFileName: fixedFileName);
  }
}