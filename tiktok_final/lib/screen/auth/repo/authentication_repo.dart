import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => (user != null && user!.emailVerified);
  User? get user => _firebaseAuth.currentUser;

  /// 인증상태 변경 모니터
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  /// 이메일로 가입하기
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// 이메일로 로그인하기
  Future<UserCredential> signIn(String email, String password) async {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  /// 로그아웃
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());
final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
