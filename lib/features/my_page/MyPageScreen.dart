import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/features/my_page/widgets/MyPageWidget.dart';
import 'package:skeleton/features/my_page/widgets/NonUserWidget.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/utils/AppStringsKorean.dart';

class MyPageScreen extends ConsumerWidget {
  static const String name = 'MyPageScreen';
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authRepositoryProvider).getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.myPageAppBarTitle),
        actions: user != null
            ? [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // 설정 페이지로 이동하는 로직
            },
          ),
        ]
            : [],  // 빈 리스트를 반환
      ),
      body: user == null ? const NonUserWidget() : const MyPageWidget(),
    );
  }
}