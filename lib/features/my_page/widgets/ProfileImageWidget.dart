import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/core/theme/AppColors.dart';
import 'package:skeleton/features/my_page/widgets/SetProfileImageWidget.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/service/firebase_firestore/usecase/ProfileImageStreamUseCase.dart';
import 'package:skeleton/utils/BasicSize.dart';

class ProfileImageWidget extends ConsumerWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authRepositoryProvider).getCurrentUser();

    if (user == null) {
      return const CircleAvatar(
        radius: radius,
        child: Icon(Icons.person, size: radius),
      );
    }

    final profileImage = ref.watch(profileImageStream(user.uid));

    return profileImage.when(
      data: (imageUrl) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: radius,
              backgroundImage:
                  imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
              child: imageUrl == null && imageUrl.isNotEmpty
                  ? const Icon(Icons.person, size: radius)
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.camera_alt, color: lemonChiffon),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SetProfileImageWidget(imageUrl: imageUrl);
                    },
                  );
                },
              ),
            )
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const CircleAvatar(
        radius: radius,
        child: Icon(Icons.error),
      ),
    );
  }
}
