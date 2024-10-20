import 'package:flutter/material.dart';
import 'package:skeleton/features/my_page/widgets/LogInButtonWidget.dart';
import 'package:skeleton/features/my_page/widgets/SignUpButtonWidget.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class NonUserWidget extends StatelessWidget {
  const NonUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            Text(AppStrings.needLoginText),
            LogInButtonWidget(),
            SignUpButtonWidget()
          ],
        ),
      ),
    );
  }
}
