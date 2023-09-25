import 'package:final_prj/screen/auth/login_screen.dart';
import 'package:final_prj/screen/auth/signup_screen.dart';
import 'package:final_prj/screen/home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
      initialLocation: "/signUp",
      redirect: (context, state) {
        return null;
      },
      routes: [
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
          name: HomeScreen.routeName,
          path: HomeScreen.routeURL,
          builder: (context, state) => const HomeScreen(),
        ),
      ]);
});
