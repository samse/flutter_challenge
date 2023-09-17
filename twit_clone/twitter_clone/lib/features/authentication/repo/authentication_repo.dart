import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => (user != null);
  User? get user => _firebaseAuth.currentUser;

  // 인증상태 변경 모니터
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  /**
   * email로 로그인
   */
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /**
   * 로그아웃
   */
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /**
   * email로 로그인
   */
  Future<UserCredential> signIn(String email, String password) async {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  /**
   * 탈퇴하기
   */
  Future<bool> outofService(BuildContext context, String password) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      String email = user.email!;
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      UserCredential userCredential =
          await user.reauthenticateWithCredential(credential);
      await user.delete();
      await _firebaseAuth.signOut();
      return true;
    }
    return false;
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());
final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
