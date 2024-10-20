import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';

class SecondScreen extends ConsumerWidget {
  static const String name = 'SecondScreen';
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Second Screen'),
          TextButton(onPressed: (){
            ref.read(authUseCaseProvider).executeSignOut();
          }, child: Text("로그아웃"))
        ],
      ),
    );
  }
}
