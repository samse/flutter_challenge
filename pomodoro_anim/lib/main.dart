import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_anim/guage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pomodoro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _isRunning = false;
  bool _forcedStopped = false;
  late Timer timer;
  late double goalSeconds = 30;
  late double elapsedSeconds = goalSeconds;
  late final AnimationController _controller =
      AnimationController(duration: Duration(milliseconds: 300), vsync: this);

  late final CurvedAnimation _curved =
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
  late Animation<double> _progress =
      Tween<double>(begin: 0.0, end: 0.0).animate(_curved);
  late final Animation<double> _scaleAnim =
      Tween<double>(begin: 1.1, end: 1.0).animate(_curved);
  late final Animation<double> _fontAnim =
      Tween<double>(begin: 60.0, end: 56.0).animate(_curved);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(milliseconds: 500),
      onTick,
    );
  }

  void _onTogglePlay() {
    setState(() {
      _isRunning = !_isRunning;
      if (_isRunning && _forcedStopped) {
        elapsedSeconds = goalSeconds;
        _forcedStopped = false;
      }
    });
  }

  /// timer 설정시간 도달 시
  void onCompleted() {
    elapsedSeconds = goalSeconds;
    _isRunning = false;
  }

  /// 타이머 종료, 초기상태 진입
  void _onReset() {
    onCompleted();
    setState(() {
      _progress = Tween(begin: _progress.value, end: 0.0).animate(_controller);
      _controller.forward(from: 0);
    });
  }

  /// 탸이머 종료, 진행상태는 유지, 다시 시작하면 처음부터
  void _onStop() {
    _isRunning = false;
    _forcedStopped = true; // 중지버튼으로 정지됨.
    setState(() {});
  }

  void onTick(Timer timer) {
    if (_isRunning == false) return;

    elapsedSeconds = elapsedSeconds - 1;
    if (elapsedSeconds <= 0) {
      onCompleted();
    }

    setState(() {
      final guageValue = goalSeconds - elapsedSeconds;
      if (guageValue != 0) {
        _progress =
            Tween(begin: _progress.value, end: guageValue).animate(_curved);
        _controller.forward(from: 0);
      } else {
        _progress =
            Tween(begin: _progress.value, end: guageValue).animate(_controller);
        _controller.forward(from: 0);
      }
    });
  }

  String formatElapsedSeconds() {
    var duration = Duration(seconds: elapsedSeconds.toInt());
    return "${duration.toString().split(".").first.substring(2, 4)}:${duration.toString().split(".").first.substring(5, 7)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.withOpacity(0.1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            child: Stack(
              children: [
                SizedBox(
                  width: 250,
                  height: 250,
                  child: AnimatedBuilder(
                    animation: _progress,
                    builder: (context, w) {
                      return Transform.scale(
                        scale: _scaleAnim.value,
                        child: Guage(
                          guageValue:
                              _progress.value, //goalSeconds - elapsedSeconds,
                          min: 0,
                          max: goalSeconds,
                          guageColor: Colors.purpleAccent.shade400,
                          guageBackgroundColor: Colors.purple.withOpacity(0.1),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: AnimatedBuilder(
                    animation: _progress,
                    builder: (context, w) {
                      return Text(
                        formatElapsedSeconds(),
                        style: TextStyle(
                          color: Colors.purpleAccent.shade400,
                          fontSize: _fontAnim.value,
                          fontWeight: FontWeight.w900,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _onReset,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20.0, right: 20.0),
                      child: Icon(
                        Icons.refresh,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _onTogglePlay,
                    child: Icon(
                      _isRunning ? Icons.pause_circle : Icons.play_circle,
                      size: 80,
                      color: Colors.purpleAccent.shade400,
                    ),
                  ),
                  GestureDetector(
                    onTap: _onStop,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Icon(
                        Icons.stop,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
