import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/features/sign_up/providers/SignUpProviders.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';


class NameInputPage extends ConsumerWidget {
  final VoidCallback onNext;
  final TextEditingController nameController = TextEditingController();

  NameInputPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider.notifier);
    final formKey = GlobalKey<FormState>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              onChanged: (value) => name.state = value,
              decoration: const InputDecoration(
                labelText: AppStrings.nameLabelText,
                hintText: AppStrings.nameHintText,
              ),
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
