import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/features/sign_up/providers/SignUpProviders.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class PasswordInputPage extends ConsumerWidget {
  final VoidCallback onNext;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  PasswordInputPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final password = ref.watch(passwordProvider.notifier);
    final passwordConfirm = ref.watch(passwordConfirmProvider.notifier);
    // final RegExp passwordRegExp =
    // RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: passwordController,
              onChanged: (value) => password.state = value,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: AppStrings.passwordLabelText,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.error_passwordInput;
                }
                return null;
              },
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordConfirmController,
              onChanged: (value) => passwordConfirm.state = value,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: AppStrings.passwordConfirmLabelText,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.error_passwordConfirmInput;
                } else if (value != passwordController.text) {
                  return AppStrings.wrong_passwordConfirmInput;
                }
                return null;
              },
            ),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: (){
                if (passwordController.text == passwordConfirmController.text) {
                  if (formKey.currentState!.validate()) {
                    onNext();
                  }
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
