import 'package:firebase_auth/firebase_auth.dart';
import 'package:skeleton/utils/Talker.dart';

abstract class AuthRepository {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  User? getCurrentUser();
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthRepository(this._auth);

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return user!;
    } catch (e) {
      talkerError('FirebaseAuthRepository(signIn)', '로그인 실패', e);
      throw Exception('로그인 실패: $e');
    }
  }

  @override
  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return result.user!;
    } catch (e) {
      talkerError('FirebaseAuthRepository(signUp)', '회원가입 실패', e);
      throw Exception('회원가입 실패: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      talkerError('FirebaseAuthRepository(signOut)', '로그아웃 실패', e);
      throw Exception('로그아웃 실패: $e');
    }
  }

  @override
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
