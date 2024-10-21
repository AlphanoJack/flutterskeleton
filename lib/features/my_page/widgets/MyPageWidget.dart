import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/features/my_page/widgets/ProfileCardWidget.dart';
import 'package:skeleton/features/my_page/widgets/ProfileImageWidget.dart';
import 'package:skeleton/features/my_page/widgets/SignOutButtonWidget.dart';

class MyPageWidget extends ConsumerWidget {
  const MyPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        ProfileImageWidget(),
        ProfileCardWidget(),
        SignOutButtonWidget(),
      ],
    );
  }
}
