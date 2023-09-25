import 'dart:async';

import 'package:final_prj/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repo/authentication_repo.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  /// 가입하기
  Future<bool> signUp(
      BuildContext context, String email, String password) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signUpWithEmail(email, password);
    });

    if (state.hasError) {
      if (context.mounted) {
        context.showAlert(
            title: "",
            message:
                (state.error as FirebaseException).message ?? "Firebase error",
            positiveCallback: () {});
      }
      return false;
    } else {
      return true;
    }
  }

  /// 로그인하기
  Future<bool> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signIn(email, password);
    });
    if (state.hasError) {
      if (context.mounted) {
        context.showAlert(
            title: "",
            message:
                (state.error as FirebaseException).message ?? "Firebase error",
            positiveCallback: () {});
      }
      return false;
    } else {
      return true;
    }
  }

  /// 로그아웃
  Future<void> signOut() async {
    await _authRepo.signOut();
  }

  /// 이메일인증메일 전송하기
  Future<bool> sendEmailVerification(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepo.user?.sendEmailVerification();
    });
    if (state.hasError) {
      if (context.mounted) {
        context.showAlert(
            title: "",
            message: state.error.toString(),
            positiveCallback: () {});
      }
      return false;
    }
    return true;
  }
}

final singUpProvider =
    AsyncNotifierProvider<SignUpViewModel, void>(() => SignUpViewModel());
