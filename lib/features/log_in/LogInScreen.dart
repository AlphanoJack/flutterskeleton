import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class LogInScreen extends ConsumerWidget {
  static const String logInScreen = 'LogInScreen';
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: AppStrings.emailLabelText,
              hintText: AppStrings.inputHintEmail,
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: AppStrings.passwordLabelText,
              hintText: AppStrings.inputHintPassword,
            ),
          ),
          TextButton(
              onPressed: () {}, child: const Text(AppStrings.loginButtonText)),
        ],
      )),
    );
  }
}
