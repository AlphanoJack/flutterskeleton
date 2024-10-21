import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/core/media/image_picker/ImagePickerProvider.dart';
import 'package:skeleton/core/media/widgets/CameraBottomSheet.dart';
import 'package:skeleton/core/theme/AppColors.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/service/firebase_firestore/usecase/CreateProfileImageUseCase.dart';
import 'package:skeleton/service/firebase_storage/repository/FirebaseStorageRepository.dart';
import 'package:skeleton/service/firebase_storage/usecase/FirebaseStorageUseCase.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';
import 'package:skeleton/utils/Talker.dart';

class SetProfileImageWidget extends ConsumerWidget {
  final String? imageUrl;
  const SetProfileImageWidget({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageState = ref.watch(imagePickerProvider);
    final user = ref.read(authRepositoryProvider).getCurrentUser();

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(AppStrings.setProfileImage),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: primaryDarkColor2,
                  context: context,
                  builder: (context) {
                    return FractionallySizedBox(
                      heightFactor: 0.3,
                      child: Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: const CameraBottomSheet()),
                    );
                  });
            },
            child: Container(
              width: 100,
              height: 100,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: imageState.when(
                data: (file) {
                  if (file != null) {
                    return Image.file(file, fit: BoxFit.cover);
                  } else if (imageUrl != null && imageUrl!.isNotEmpty) {
                    return Image.network(imageUrl!, fit: BoxFit.cover);
                  } else {
                    return const Icon(Icons.person, size: 50);
                  }
                },
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Icon(Icons.error, size: 50),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(
              onPressed: () {
                imageState.when(
                  data: (image) async {
                    try {
                      if (image == null) return;

                      var userId = user!.uid;

                      final imageUrl = await ref
                          .read(firebaseStorageUseCaseProvider)
                          .executeUploadImageFromApp(
                              image, ImageType.profileImage,
                              fixedFileName: userId);
                      talkerLog('MyPageWidget/SetProfileImage',
                          '프로필 이미지 Url 생성: $imageUrl');

                      await ref
                          .read(createProfileImageProvider)
                          .execute(userId, imageUrl);
                      talkerLog(
                          'MyPageWidget/SetProfileImage', '프로필 이미지 업로드 성공');
                      Navigator.pop(context);
                    } catch (e) {
                      talkerError(
                          'MyPageWidget/SetProfileImage', '프로필 이미지 업로드 실패', e);
                    }
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const Icon(Icons.error),
                );
              },
              child: const Text("적용하기"))
        ],
      ),
    );
  }
}
