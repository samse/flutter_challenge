import 'package:final_prj/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/config/config_view_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Final Prj",
      routerConfig: ref.watch(routerProvider),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
