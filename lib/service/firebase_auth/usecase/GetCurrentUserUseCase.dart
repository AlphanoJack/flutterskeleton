import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeleton/service/firebase_auth/FirebaseAuthProvider.dart';
import 'package:skeleton/service/firebase_auth/repository/FirebaseAuthRepository.dart';

final getCurrentUserProvider = Provider<GetCurrentUserUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(authRepository);
});

class GetCurrentUserUseCase {
  final AuthRepository authRepository;

  GetCurrentUserUseCase(this.authRepository);

  User? execute() {
    return authRepository.getCurrentUser();
  }
}
