import 'package:firebase_auth/firebase_auth.dart';
import 'package:skeleton/service/firebase_auth/repository/FirebaseAuthRepository.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase(this.authRepository);

  Future<User> executeSignIn(String email, String password) async {
    return await authRepository.signInWithEmailAndPassword(email, password);
  }

  Future<User> executeSignUp(String email, String password) async {
    return await authRepository.signUpWithEmailAndPassword(email, password);
  }

  Future<void> executeSignOut() async {
    return await authRepository.signOut();
  }
}
