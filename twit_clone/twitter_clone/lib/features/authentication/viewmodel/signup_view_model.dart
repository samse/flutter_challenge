import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app.dart';

import '../repo/authentication_repo.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<bool> signUp(BuildContext context) async {
    state = AsyncValue.loading();
    final form = ref.read(signUpForm);
    // final users = ref.read(usersProvider.notifier);
    final String email = form["email"];
    final String password = form["password"];
    // final String username = form["username"];
    print("SignUp email=${email}, password=${password}");
    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.signUpWithEmail(email, password);
    });

    if (state.hasError) {
      context.showAlert(
          title: "",
          message: (state.error as FirebaseException).message ?? "알수 없는 오류 발생!",
          positiveCallback: () {});
      return false;
    } else {
      return true;
    }
  }

  Future<bool> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      print("sign");
      final userCredential = await _authRepo.signIn(email, password);
    });
    if (state.hasError) {
      // alert
      print("state = ${state}");
      context.showAlert(
          title: "",
          message: (state.error as FirebaseException).message ?? "알수 없는 오류 발생!",
          positiveCallback: () {});
      return false;
    } else {
      return true;
    }
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
  }
}

final singUpProvider =
    AsyncNotifierProvider<SignUpViewModel, void>(() => SignUpViewModel());

final signUpForm = StateProvider((ref) => {});
