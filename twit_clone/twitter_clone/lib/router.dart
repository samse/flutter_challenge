import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/customized_experience_screen.dart';
import 'package:twitter_clone/features/onboarding_screen.dart';

import 'features/signup_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(initialLocation: "/", routes: [
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
  ]);
});
