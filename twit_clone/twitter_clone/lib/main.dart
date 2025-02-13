import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/app.dart';
import 'package:twitter_clone/features/authentication/customized_experience_screen.dart';
import 'package:twitter_clone/features/authentication/onboarding_screen.dart';
import 'package:twitter_clone/firebase_options.dart';
import 'package:twitter_clone/router.dart';

import 'config/viewmodel/config_view_model.dart';
import 'features/authentication/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    FirebaseMessaging.instance.requestPermission();
  }

  runApp(const ProviderScope(
    child: TwitApp(),
  ));
}

class TwitApp extends ConsumerStatefulWidget {
  const TwitApp({super.key});

  @override
  ConsumerState<TwitApp> createState() => _TwitAppState();
}

class _TwitAppState extends ConsumerState<TwitApp> {
  @override
  void initState() {
    super.initState();
    ref.read(configProvider.notifier).addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Twitter Clone',
      themeMode: ref.read(configProvider.notifier).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        useMaterial3: true,
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.green.shade50,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 26,
              fontFamily: "NanumGothicExtraBold",
              fontWeight: FontWeight.w700),
          titleMedium:
              TextStyle(fontSize: 22, fontFamily: "NanumGothicExtraBold"),
          titleSmall:
              TextStyle(fontSize: 18, fontFamily: "NanumGothicExtraBold"),
          bodyMedium: TextStyle(fontSize: 14),
          headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
          displayLarge: TextStyle(fontSize: 24),
          displayMedium: TextStyle(fontSize: 16),
          displaySmall: TextStyle(fontSize: 12),
        ),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xFF52A2D8),
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 26,
              fontFamily: "NanumGothicExtraBold",
              fontWeight: FontWeight.w700),
          titleMedium:
              TextStyle(fontSize: 22, fontFamily: "NanumGothicExtraBold"),
          titleSmall:
              TextStyle(fontSize: 18, fontFamily: "NanumGothicExtraBold"),
          bodyMedium: TextStyle(fontSize: 14),
          headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          headlineSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
          displayLarge: TextStyle(fontSize: 24),
          displayMedium: TextStyle(fontSize: 16),
          displaySmall: TextStyle(fontSize: 12),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', 'KR'), // Korea
        Locale('en', 'US'), // English
      ],
    );
  }
}
