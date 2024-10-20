import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeleton/features/sign_up/SingUpScreen.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          context.goNamed(SignUpScreen.name);
        },
          child: const Text(AppStrings.moveToSignUpButtonText)
    );
  }
}
