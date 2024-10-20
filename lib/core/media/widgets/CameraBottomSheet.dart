import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/core/media/image_picker/ImagePickerProvider.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class CameraBottomSheet extends ConsumerWidget {
  const CameraBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageState = ref.watch(imagePickerProvider.notifier);

    return Column(
      children: [
        const SizedBox(
          width: double.infinity,
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            imageState.pickImage(ImageGetType.camera);
          },
          child: const Text(AppStrings.cameraBottomSheetButtonText),
        ),
        const SizedBox(
          height: 4,
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              imageState.pickImage(ImageGetType.gallery);
            },
            child: const Text(AppStrings.galleryBottomSheetButtonText)
        ),
      ],
    );
  }
}
