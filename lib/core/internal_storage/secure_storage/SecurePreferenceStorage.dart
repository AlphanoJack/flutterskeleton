import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurePreferenceStorage {
  final _storage = const FlutterSecureStorage();

  IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  AndroidOptions _getAndroidOptions() => const AndroidOptions();

  // 저장소 내부 string 읽기
  Future<String?> readString(String key) {
    return _storage.read(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  // 저장소 내부 Int 값 읽기
  Future<int?> readInt(String key) async {
    final value = await readString(key) ?? '';
    return int.tryParse(value);
  }

  // 저장소 내부 bool 값 읽기
  Future<bool> readBool(String key) async {
    final value = await readString(key) ?? 'false';
    return bool.tryParse(value) ?? false;
  }

  // 저장소에 쓰기
  Future<void> write(String key, dynamic value) {
    final response = _storage.write(
      key: key,
      value: value?.toString(),
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    return response;
  }

  // 전체 삭제
  Future<void> clear() {
    return _storage.deleteAll(
        iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  // 특정 키 삭제
  Future<void> delete(String key) async {
    _storage.delete(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  // 키 존재 여부 확인
  Future<bool> contains(String key) {
    return _storage.containsKey(
        key: key, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }
}