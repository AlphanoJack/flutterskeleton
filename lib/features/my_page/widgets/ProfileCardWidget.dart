import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/core/theme/AppColors.dart';
import 'package:skeleton/core/theme/AppTextStyle.dart';
import 'package:skeleton/service/firebase_auth/usecase/GetCurrentUserUseCase.dart';
import 'package:skeleton/service/firebase_firestore/usecase/GetUserInfoUseCase.dart';

class ProfileCardWidget extends ConsumerWidget {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(getCurrentUserProvider).execute();
    final userInfo = ref.watch(userInfoProvider(user!.uid));

    return Card(
      color: primaryDarkColor2,
      child: userInfo.when(
        data: (userInfo) {
          if (userInfo == null) {
            return const Center(child: Text('User info not found'));
          }
          return Column(
            children: [
              Text('Name: ${userInfo.userName}', style: white12BoldTextStyle),
              Text('Email: ${userInfo.userEmail}', style: white12BoldTextStyle),
              Text('Nickname: ${userInfo.userNickname}',
                  style: white12BoldTextStyle),
              Text('CreatAt: ${userInfo.createdAt}',
                  style: white12BoldTextStyle),
              Text('Phone: ${userInfo.phone}', style: white12BoldTextStyle),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
