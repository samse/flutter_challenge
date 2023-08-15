import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _days = [17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30];
  final _schedules = [
    Schedule(
        color: const Color(0xFFFEF655),
        periods: [11, 30, 12, 20],
        title: ["DESIGN", "MEETING"],
        attendees: ["ALEX", "HELENA", "NANA"]),
    Schedule(
        color: const Color(0xFF9C6BCE),
        periods: [12, 35, 14, 10],
        title: ["DAILY", "PROJECT"],
        attendees: ["RECHARD", "CIRY", "MARK"]),
    Schedule(
        color: const Color(0xFFBBEF4C),
        periods: [15, 0, 16, 30],
        title: ["WEEKLY", "PLANNING"],
        attendees: ["SAMSE", "HELENA", "NANA", "+4"]),
    Schedule(
        color: const Color(0xFFFB8C00),
        periods: [17, 00, 18, 20],
        title: ["PERSONAL", "TRAINING"],
        attendees: ["DEN", "HELENA", "MARK"]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(32, 32, 32, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 4.0),
              child: Text(
                "MONDAY 16",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            DateScroll(days: _days),
            const SizedBox(
              height: 2,
            ),
            ScheduleCard(schedules: _schedules),
          ],
        ),
      ),
    );
  }
}

///
/// 상단헤더 뷰 : 아바타와 일정추가하기 버튼 배치
///
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30,
            foregroundImage: NetworkImage(
                "https://lh3.googleusercontent.com/ogw/AGvuzYYoD70U4deBCUYM20LNjC12Xi61nrgKMRSJGOSUwMc=s64-c-mo"),
          ),
          Icon(
            Icons.add_outlined,
            color: Colors.white,
            size: 38,
          ),
        ],
      ),
    );
  }
}

///
/// 날자목록 위젯
///
class DateScroll extends StatelessWidget {
  final List<int> days;
  const DateScroll({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Text(
              "TODAY",
              style: TextStyle(
                fontSize: 44,
                color: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Icon(
                Icons.circle,
                color: Colors.purple,
                size: 10,
              ),
            ),
            for (var day in days)
              Text(
                "$day ",
                style: const TextStyle(
                  fontSize: 42,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

///
/// Schedule 모델 : 간략하게 모두 리스트로 처리
///
class Schedule {
  final Color color;
  final List<int> periods;
  final List<String> title;
  final List<String> attendees;

  Schedule(
      {required this.color,
      required this.periods,
      required this.title,
      required this.attendees});
}

///
/// Schedule 카드
///
class ScheduleCard extends StatelessWidget {
  final List<Schedule> schedules;

  const ScheduleCard({super.key, required this.schedules});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              for (var schedule in schedules)
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0, left: 6.0, right: 6.0),
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                      color: schedule.color,
                      borderRadius: BorderRadius.circular(44),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, top: 34.0, right: 20.0),
                              child: Column(
                                children: [
                                  Text(
                                    "${schedule.periods[0] ?? ""}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "${schedule.periods[1] ?? ""}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                    child: VerticalDivider(
                                      thickness: 1,
                                      width: 1,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    "${schedule.periods[2] ?? ""}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "${schedule.periods[3] ?? ""}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: Text(
                                      schedule.title[0] ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 64,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 72),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: Text(
                                      schedule.title[1] ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 64,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 180),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          for (var attendee
                                              in schedule.attendees)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: Text(
                                                attendee ?? "",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
