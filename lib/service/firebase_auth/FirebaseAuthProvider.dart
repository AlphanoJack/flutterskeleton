import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_auth/repository/FirebaseAuthRepository.dart';
import 'package:skeleton/service/firebase_auth/usecase/AuthUseCase.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = (ref.watch(firebaseAuthProvider));
  return FirebaseAuthRepository(firebaseAuth);
});

final authUseCaseProvider = Provider<AuthUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthUseCase(authRepository);
});
