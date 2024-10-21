import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeleton/utils/Talker.dart';

enum ImageGetType { gallery, camera, message }

// ImagePicker 로 가져온 이미지 Provider
final imagePickerProvider =
    StateNotifierProvider.autoDispose<ImageNotifier, AsyncValue<File?>>(
  (ref) => ImageNotifier(),
);

class ImageNotifier extends StateNotifier<AsyncValue<File?>> {
  ImageNotifier() : super(const AsyncValue.data(null));

  Future<void> pickImage(ImageGetType imageGetType) async {
    try {
      XFile? pickedFile;
      List<XFile>? pickedFiles;

      switch (imageGetType) {
        case ImageGetType.camera:
          pickedFile =
              await ImagePicker().pickImage(source: ImageSource.camera);
          break;
        case ImageGetType.gallery:
          pickedFile =
              await ImagePicker().pickImage(source: ImageSource.gallery);
          break;
        case ImageGetType.message:
          pickedFiles = await ImagePicker().pickMultiImage(
            limit: 2,
          );

          break;
      }

      if (pickedFile == null) return;

      final resizedImage = await resizeAndConvertToWebP(pickedFile, 800, 800);

      if (resizedImage != null) {
        state = AsyncValue.data(resizedImage);
      } else {
        state = AsyncValue.error("Failed to resize image", StackTrace.current);
      }
    } catch (e) {
      talker.error("error occur $e");
      state = AsyncValue.error("error occur $e", StackTrace.current);
    }
  }

  Future<File?> resizeAndConvertToWebP(
      XFile imageFile, int width, int height) async {
    try {
      // 임시 디렉토리 얻기
      final directory = await getTemporaryDirectory();
      final targetPath =
          '${directory.path}/resized_${DateTime.now().millisecondsSinceEpoch}.webp';

      // XFile을 File로 변환
      File file = File(imageFile.path);

      // 이미지 압축 및 WebP로 변환
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        format: CompressFormat.webp,
        quality: 80,
        minWidth: width,
        minHeight: height,
      );

      if (result == null) {
        throw Exception('Failed to compress and convert image');
      }

      return File(result.path);
    } catch (e) {
      talker.error('Error resizing and converting image: $e');
      return null;
    }
  }

  void clearImage() {
    state = const AsyncValue.data(null);
  }
}
