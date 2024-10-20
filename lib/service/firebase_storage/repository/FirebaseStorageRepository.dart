import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:skeleton/utils/Talker.dart';
import 'package:uuid/uuid.dart';

enum ImageType {
  profileImage,
  chat,
}

abstract class StorageRepository {
  Future<String> uploadImageFromApp(File appImageFile, ImageType type,
      {String? fixedFileName});
}

class FirebaseStorageRepository implements StorageRepository {
  final FirebaseStorage _storage;

  FirebaseStorageRepository(this._storage);

  @override
  Future<String> uploadImageFromApp(File appImageFile, ImageType type,
      {String? fixedFileName}) async {
    try {

    var uuid = const Uuid();

    String fullPath = '';

    switch (type) {
      case ImageType.profileImage:
        fullPath = '${type.name}$fixedFileName.webp';
        break;
      case ImageType.chat:
        String fileName = '${uuid.v4()}.webp';
        fullPath = '${type.name}/$fileName';
        break;
    }

    final storageRef = _storage.ref().child(fullPath);
    await storageRef.putFile(appImageFile);
    talkerLog('FirebaseStorageRepository(uploadImageFromApp)', '이미지 저장에 성공했습니다');
    final url = await storageRef.getDownloadURL();
    talkerLog('FirebaseStorageRepository(uploadImageFromApp)', '이미지 URL: $url');

    return url;

    } catch (e) {
      talkerError('FirebaseStorageRepository(uploadImageFromApp)', '이미지 업로드에 실패하셨습니다.', e);
      throw Exception('uploadImageFromApp: $e');
    }
  }
}