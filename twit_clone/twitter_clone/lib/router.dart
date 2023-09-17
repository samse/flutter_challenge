import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:twitter_clone/features/authentication/customized_experience_screen.dart';
import 'package:twitter_clone/features/authentication/interest_screen.dart';
import 'package:twitter_clone/features/authentication/onboarding_screen.dart';
import 'package:twitter_clone/features/authentication/password_screen.dart';
import 'package:twitter_clone/features/authentication/pincode_verify_screen.dart';
import 'package:twitter_clone/features/home/home_screen.dart';
import 'package:twitter_clone/features/home/subviews/attach_file_screen.dart';
import 'package:twitter_clone/features/search/search_screen.dart';
import 'package:twitter_clone/features/settings/settings_screen.dart';

import 'features/activities/activities_screen.dart';
import 'features/authentication/login_screen.dart';
import 'features/authentication/repo/authentication_repo.dart';
import 'features/authentication/signup_screen.dart';
import 'features/settings/subviews/privacy_screen.dart';
import 'features/user_profile/user_profile_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
      initialLocation: "/signIn",
      redirect: (context, state) {
        print(
            "redirect to ${state.fullPath}, ${state.uri}, ${state.pathParameters}");
        var isLoggedIn = ref.read(authRepo).isLoggedIn;
        print("isLoggedIn => $isLoggedIn");
        if (!isLoggedIn) {
          // || ref.read(preferenceProvider).isFirstRun) {
          // if (isLoggedIn) return LoginScreen.routeURL;

          if (state.fullPath != SignUpScreen.routeURL &&
              state.fullPath != LoginScreen.routeURL &&
              state.fullPath != PinCodeVerifyScreen.routeURL &&
              state.fullPath != CustomizedExperienceScreen.routeURL &&
              state.fullPath != PasswordScreen.routeURL &&
              state.fullPath != InterestsScreen.routeURL) {
            return SignUpScreen.routeURL;
          } else {}
        }
        return null;
      },
      routes: [
        GoRoute(
          name: OnBoardingScreen.routeName,
          path: OnBoardingScreen.routeURL,
          builder: (context, state) => const OnBoardingScreen(),
        ),
        GoRoute(
          name: SearchScreen.routeName,
          path: SearchScreen.routeURL,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          name: ActivitiesScreen.routeName,
          path: ActivitiesScreen.routeURL,
          builder: (context, state) => const ActivitiesScreen(),
        ),
        GoRoute(
          name: UserProfileScreen.routeName,
          path: UserProfileScreen.routeURL,
          builder: (context, state) => const UserProfileScreen(),
        ),
        GoRoute(
          name: SignUpScreen.routeName,
          path: SignUpScreen.routeURL,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeURL,
          builder: (context, state) => const LoginScreen(),
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
          builder: (context, state) => InterestsScreen(),
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
            routes: [
              GoRoute(
                name: PrivacyScreen.routeName,
                path: PrivacyScreen.routeURL,
                builder: (context, state) {
                  // final userId = state.params["userId"];
                  return PrivacyScreen();
                },
              ),
            ]),
        GoRoute(
          name: AttachFileScreen.routeName,
          path: AttachFileScreen.routeURL,
          builder: (context, state) => const AttachFileScreen(),
        ),
      ]);
});
