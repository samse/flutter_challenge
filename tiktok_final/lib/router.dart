import 'package:final_prj/screen/auth/login_screen.dart';
import 'package:final_prj/screen/auth/repo/authentication_repo.dart';
import 'package:final_prj/screen/auth/signup_screen.dart';
import 'package:final_prj/screen/home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        var isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          // 로그인안된 상태에서 가입/로그인화면이 아니면 가입화면으로 이동
          if (state.fullPath != SignUpScreen.routeURL &&
              state.fullPath != LoginScreen.routeURL) {
            return SignUpScreen.routeURL;
          }
        }
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
