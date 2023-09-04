import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/authentication/customized_experience_screen.dart';
import 'package:twitter_clone/features/authentication/interest_screen.dart';
import 'package:twitter_clone/features/authentication/onboarding_screen.dart';
import 'package:twitter_clone/features/authentication/password_screen.dart';
import 'package:twitter_clone/features/authentication/pincode_verify_screen.dart';
import 'package:twitter_clone/features/home/home_screen.dart';
import 'package:twitter_clone/features/settings/settings_screen.dart';

import 'features/authentication/signup_screen.dart';
import 'features/settings/subviews/privacy_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(initialLocation: "/home", routes: [
    GoRoute(
      name: OnBoardingScreen.routeName,
      path: OnBoardingScreen.routeURL,
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: CustomizedExperienceScreen.routeName,
      path: CustomizedExperienceScreen.routeURL,
      builder: (context, state) => const CustomizedExperienceScreen(),
    ),
    GoRoute(
      name: PinCodeVerifyScreen.routeName,
      path: PinCodeVerifyScreen.routeURL,
      builder: (context, state) => const PinCodeVerifyScreen(),
    ),
    GoRoute(
      name: PasswordScreen.routeName,
      path: PasswordScreen.routeURL,
      builder: (context, state) => const PasswordScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      name: HomeScreen.routeName,
      path: HomeScreen.routeURL,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: SettingsScreen.routeName,
      path: SettingsScreen.routeURL,
      builder: (context, state) => SettingsScreen(),
    ),
    GoRoute(
      name: PrivacyScreen.routeName,
      path: PrivacyScreen.routeURL,
      builder: (context, state) => PrivacyScreen(),
    ),
  ]);
});
