import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:toonflix/screens/widget/gradient_text.dart';
import 'package:toonflix/screens/widget/ui.dart';

const cfgMinBtnWidth = 74.0;
const cfgMinBtnHeight = 52.0;
const cfgMinTextSize = 26.0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const configMinutes = [15, 20, 25, 30, 35];

  static const twentyFiveMinutes = 60 * 25;
  int totalSeconds = twentyFiveMinutes;
  int selectedSeconds = configMinutes[2];
  bool roundCompleted = false;
  DateTime? roundCompletedTime;
  bool isRunning = false;
  int totalPomodoros = 0;
  int goalPomodoros = 0;
  bool _animTrigger = false;

  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        _triggerAnimation();
        totalPomodoros = totalPomodoros + 1;
        if (totalPomodoros > 3) {
          // round 완료, 5분동안 중단.
          roundCompleted = true;
          roundCompletedTime = DateTime.now();

          totalPomodoros = 0;
          goalPomodoros = goalPomodoros + 1;
        }
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        _triggerAnimation();
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void _triggerAnimation() {
    _animTrigger = true;
    Future.delayed(Duration(milliseconds: 200),
        () => setState(() => _animTrigger = false));
  }

  void onStartPressed() {
    if (roundCompleted) {
      if (roundCompletedTime != null) {
        if (DateTime.now().difference(roundCompletedTime!).inMinutes < 5) {
          AlertBuilder(context: context)
            ..title = "POMOTIMER"
            ..message =
                "5분동안 휴식을 취한 후 시도해주세요\n${format(DateTime.now().difference(roundCompletedTime!).inSeconds)} 지났습니다."
            ..showAlert();
          return;
        } else {
          roundCompleted = false;
          roundCompletedTime = null;
        }
      }
    }

    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  String formatRestMin(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 4);
  }

  String formatRestSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(5, 7);
  }

  Future<void> _onMinSelected(BuildContext context, int min) async {
    print("onMinSelected -=> $min");
    if (isRunning) {
      final confirm = AlertBuilder(context: context)
        ..title = "POMOTIMER"
        ..message = "현재 타이머가 동작 중입니다.\n중지하고 시간을 재설정 하시겠습니까?";
      final ret = await confirm.showConfirm(context);
      if (ret) {
        onPausePressed();
        selectedSeconds = min;
        totalSeconds = min * 60;
        totalPomodoros = 0;
        goalPomodoros = 0;
      }
    } else {
      selectedSeconds = min;
      totalSeconds = min * 60;
      totalPomodoros = 0;
      goalPomodoros = 0;
    }
    print("totalSeconds -=> $totalSeconds");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "POMOTIMER",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    height: 180,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(""),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(""),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                // format(totalSeconds),
                                formatRestMin(totalSeconds),
                                style: TextStyle(
                                  color: Theme.of(context).backgroundColor,
                                  fontSize: 75,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    height: 180,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        ":",
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 140,
                    height: 180,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(""),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 5,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(""),
                            ),
                          ),
                        ),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 800),
                              curve: Curves.fastOutSlowIn,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                // format(totalSeconds),
                                formatRestSeconds(totalSeconds),
                                style: TextStyle(
                                  color: _animTrigger
                                      ? Theme.of(context)
                                          .backgroundColor
                                          .withOpacity(0.5)
                                      : Theme.of(context).backgroundColor,
                                  fontSize: _animTrigger ? 70 : 75,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 시간선택과 플레이버튼
          Flexible(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (selectedSeconds == 15)
                        selectedButton(context, 15, _onMinSelected)
                      else
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 32),
                            child: Container(
                              width: cfgMinBtnWidth,
                              height: cfgMinBtnHeight,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context)
                                          .backgroundColor
                                          .withOpacity(0.5),
                                      Colors.white60
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )),
                              child: GestureDetector(
                                onTap: () => _onMinSelected(context, 15),
                                child: Container(
                                  width: cfgMinBtnWidth - 4,
                                  height: cfgMinBtnHeight - 4,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: linearGradientText(
                                    text: "15",
                                    fontSize: cfgMinTextSize,
                                    fontWeight: FontWeight.w700,
                                    colors: [
                                      Theme.of(context)
                                          .backgroundColor
                                          .withOpacity(0.5),
                                      Colors.white60,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (selectedSeconds == 20)
                        selectedButton(context, 20, _onMinSelected)
                      else
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 32),
                            child: Container(
                              width: cfgMinBtnWidth,
                              height: cfgMinBtnHeight,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: const LinearGradient(
                                    colors: [Colors.white60, Colors.white],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )),
                              child: GestureDetector(
                                onTap: () => _onMinSelected(context, 20),
                                child: Container(
                                  width: cfgMinBtnWidth - 4,
                                  height: cfgMinBtnHeight - 4,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  // child: Text(
                                  //   "20",
                                  //   style: TextStyle(
                                  //     color: Colors.white,
                                  //     fontSize: cfgMinTextSize,
                                  //     fontWeight: FontWeight.w700,
                                  //   ),
                                  // ),
                                  child: linearGradientText(
                                    text: "20",
                                    fontSize: cfgMinTextSize,
                                    fontWeight: FontWeight.w700,
                                    colors: [Colors.white30, Colors.white],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (selectedSeconds == 25)
                        selectedButton(context, 25, _onMinSelected)
                      else
                        unselectedButton(context, 25, _onMinSelected),
                      if (selectedSeconds == 30)
                        selectedButton(context, 30, _onMinSelected)
                      else
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 32),
                            child: Container(
                              width: cfgMinBtnWidth,
                              height: cfgMinBtnHeight,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: const LinearGradient(
                                    colors: [Colors.white, Colors.white60],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )),
                              child: GestureDetector(
                                onTap: () => _onMinSelected(context, 30),
                                child: Container(
                                  width: cfgMinBtnWidth - 4,
                                  height: cfgMinBtnHeight - 4,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text("30",
                                      style: TextStyle(
                                          foreground: Paint()
                                            ..shader = ui.Gradient.linear(
                                                Offset(150, 20),
                                                Offset(0, 20), [
                                              Colors.white,
                                              Colors.white10,
                                            ]),
                                          fontSize: cfgMinTextSize,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (selectedSeconds == 35)
                        selectedButton(context, 35, _onMinSelected)
                      else
                        Flexible(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6, right: 6, top: 32),
                            child: Container(
                              width: cfgMinBtnWidth,
                              height: cfgMinBtnHeight,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white60,
                                      Theme.of(context)
                                          .backgroundColor
                                          .withOpacity(0.5),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )),
                              child: GestureDetector(
                                onTap: () => _onMinSelected(context, 35),
                                child: Container(
                                  width: cfgMinBtnWidth - 4,
                                  height: cfgMinBtnHeight - 4,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  // child: (Text("35")),
                                  child: Text("35",
                                      style: TextStyle(
                                          foreground: Paint()
                                            ..shader = ui.Gradient.linear(
                                                Offset(150, 20),
                                                Offset(0, 20), [
                                              Colors.white60,
                                              Theme.of(context)
                                                  .backgroundColor
                                                  .withOpacity(0.5),
                                            ]),
                                          fontSize: cfgMinTextSize,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: IconButton(
                        iconSize: 80,
                        color: Theme.of(context).cardColor,
                        onPressed: isRunning ? onPausePressed : onStartPressed,
                        icon: Icon(
                          isRunning
                              ? Icons.pause_circle
                              : Icons.play_arrow_sharp,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 하단 카운트 표시
          Flexible(
            flex: 1,
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$totalPomodoros/4',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFEEABA2),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'ROUND',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$goalPomodoros/12',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFEEABA2),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'GOAL',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget selectedButton(BuildContext context, int min, Function _onMinSelected) {
  return Flexible(
    flex: 1,
    child: Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 32),
      child: GestureDetector(
        onTap: () => _onMinSelected(context, min),
        child: Container(
          width: cfgMinBtnWidth,
          height: cfgMinBtnHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Text(
            "$min",
            style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontSize: cfgMinTextSize,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ),
  );
}

Widget unselectedButton(
    BuildContext context, int min, Function _onMinSelected) {
  return Flexible(
    flex: 1,
    child: Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 32),
      child: GestureDetector(
        onTap: () => _onMinSelected(context, min),
        child: Container(
          width: cfgMinBtnWidth,
          height: cfgMinBtnHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Text(
            "$min",
            style: TextStyle(
                color: Colors.white,
                fontSize: cfgMinTextSize,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ),
  );
}
