import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class SignOutButtonWidget extends ConsumerWidget {
  const SignOutButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
        onPressed: (){
          ref.read(authUseCaseProvider).executeSignOut();
        },
          child: const Text(AppStrings.signOutButtonText)
    );
  }
}
