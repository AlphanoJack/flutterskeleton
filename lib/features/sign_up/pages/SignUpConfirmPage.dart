import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeleton/core/router/RouterProvider.dart';
import 'package:skeleton/features/my_page/MyPageScreen.dart';
import 'package:skeleton/features/sign_up/providers/SignUpProviders.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/service/firebase_firestore/provider/FirestoreProviders.dart';
import 'package:skeleton/utils/Talker.dart';

class SignUpConfirmPage extends ConsumerWidget {
  const SignUpConfirmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.read(emailProvider);
    final name = ref.read(nameProvider);
    final password = ref.read(passwordProvider);
    final nickname = ref.read(nicknameProvider);

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('이메일: $email'),
            Text('비밀번호: $password'),
            Text('이름: $name'),
            Text('닉네임: $nickname'),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(authUseCaseProvider).executeSignUp(email, password);
                  await ref.read(firestoreUseCaseProvider).executeUpdateUserData(email, nickname, nickname, '');
                  ref.invalidate(emailProvider);
                  ref.invalidate(passwordProvider);
                  ref.invalidate(nameProvider);
                  ref.invalidate(nicknameProvider);
                  context.goNamed(MyPageScreen.name);
                } catch (e) {
                  talkerError('SignUPConfirmPage', 'failed to singUp', e);
                }
              },
              child: const Text('로그인 화면으로 이동'),
            ),
          ],
        )
    );
  }
}
