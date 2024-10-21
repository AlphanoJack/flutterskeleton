import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeleton/features/log_in/LogInScreen.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class LogInButtonWidget extends StatelessWidget {
  const LogInButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.goNamed(LogInScreen.name);
        },
        child: const Text(AppStrings.moveToLoginButtonText));
  }
}
