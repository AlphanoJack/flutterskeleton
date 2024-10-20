import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/features/sign_up/providers/SignUpProviders.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class EmailInputPage extends ConsumerWidget {
  final VoidCallback onNext;
  final TextEditingController emailController = TextEditingController();
  EmailInputPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(emailProvider.notifier);
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final formKey = GlobalKey<FormState>();

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: emailController,
                onChanged: (value) => email.state = value,
                decoration: const InputDecoration(
                  labelText: AppStrings.emailLabelText,
                  hintText: AppStrings.emailHintText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.error_emailInput;
                  } else if (!emailRegExp.hasMatch(value)) {
                    return AppStrings.wrong_emailInput;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: (){
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
