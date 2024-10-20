import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeleton/features/sign_up/SingUpScreen.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';
import 'package:skeleton/utils/Talker.dart';

class LogInScreen extends ConsumerWidget {
  static const String name = 'LogInScreen';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LogInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/mypage');
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.emailLabelText,
                      hintText: AppStrings.emailHintText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: AppStrings.passwordLabelText,
                      hintText: AppStrings.passwordHintText,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        ref.read(authUseCaseProvider).executeSignIn(
                            emailController.text, passwordController.text);
                        context.go('/mypage');
                      } catch (e) {
                        talkerError('loginScreen', 'failed to logIn', e);
                      }
                    },
                    child: const Text(AppStrings.loginButtonText),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      context.goNamed(SignUpScreen.name);
                    },
                    child: const Text(AppStrings.signUpButtonText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
