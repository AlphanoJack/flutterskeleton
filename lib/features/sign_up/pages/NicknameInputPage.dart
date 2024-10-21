import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/features/sign_up/providers/SignUpProviders.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';
import 'package:skeleton/utils/ForbiddenPatterns.dart';

class NicknameInputPage extends ConsumerWidget {
  final VoidCallback onNext;
  final TextEditingController nicknameController = TextEditingController();
  NicknameInputPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(nicknameProvider.notifier);
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nicknameController,
              onChanged: (value) => nickname.state = value,
              decoration: const InputDecoration(
                labelText: AppStrings.nicknameLabelText,
                hintText: AppStrings.nicknameHintText,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.error_nicknameInput;
                }
                for (var pattern in forbiddenPatterns) {
                  if (pattern.hasMatch(value)) {
                    return AppStrings.wrong_nicknameInput;
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  onNext();
                }
              },
              child: const Text(AppStrings.nextButtonText),
            )
          ],
        ),
      ),
    );
  }
}
