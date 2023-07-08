import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'package:toonflix/screens/pomodoros_challenge_screen.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/button.dart';
import 'package:toonflix/widgets/currency_card.dart';
import 'package:toonflix/widgets/schedule_card.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..userAgent =
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36';
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(WebToonHomeScreen());
}

class WebToonHomeScreen extends StatelessWidget {
  WebToonHomeScreen({super.key});

  var webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            '오늘의 웹툰',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
        ),
        body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: makeList(snapshot),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebToonModel>> snapshot) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var webtoon = snapshot.data![index];
          return WebToon(
            id: webtoon.id,
            title: webtoon.title,
            thumb: webtoon.thumb,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              width: 40,
            ),
        itemCount: snapshot.data!.length);
  }
}

class PomodorosChallenge extends StatefulWidget {
  const PomodorosChallenge({super.key});

  @override
  State<PomodorosChallenge> createState() => _PomodorosChallengeState();
}

class _PomodorosChallengeState extends State<PomodorosChallenge> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFE64D3D),
      ),
      home: const PomodoroChallengeScreen(),
    );
  }
}

class Pomodoro extends StatelessWidget {
  const Pomodoro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: const Color(0xFFE7626C),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class CodeChallenge extends StatelessWidget {
  const CodeChallenge({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF202020),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        "https://avatars.githubusercontent.com/u/89124782?v=4",
                        width: 70,
                        height: 70,
                      ),
                    ),
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  'MONDAY 16',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'TODAY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                    ),
                  ),
                  const Icon(
                    Icons.circle,
                    color: Color(0xFFB2257F),
                    size: 10,
                  ),
                  Text(
                    '17  18  19  2',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 40,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const ScheduleScreen(
                center: false,
                color: Color(0xFFFFF754),
                text: 'DESIGN MEETING',
                startTime: '11:12',
                endTime: '12:20',
                withWho: ['ALEX', 'HELENA', 'NANA'],
              ),
              const SizedBox(
                height: 10,
              ),
              const ScheduleScreen(
                center: true,
                color: Color(0xFF9C6BCE),
                text: 'DAILY PROJECT',
                startTime: '12:35',
                endTime: '14:10',
                withWho: ['ME', 'richard', 'Ciry'],
              ),
              const SizedBox(
                height: 10,
              ),
              const ScheduleScreen(
                center: false,
                color: Color(0xFFBCEE4C),
                text: 'WEEKLY PLANNING',
                startTime: '15:00',
                endTime: '16:30',
                withWho: ['den', 'nana', 'mark'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Hey, Selena",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "Welcome back",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Total Balance",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "\$5 194 382",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Button(
                      text: 'Transfer',
                      bgColor: Color(0xFFF1B33B),
                      textColor: Colors.black,
                    ),
                    Button(
                      text: 'Request',
                      bgColor: Color(0xFF1F2123),
                      textColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Wallets",
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const CurrencyCard(
                    name: "Euro",
                    code: "EUR",
                    amount: "6 284",
                    icon: Icons.euro_rounded,
                    isInverted: false),
                Transform.translate(
                  offset: const Offset(0, -15),
                  child: const CurrencyCard(
                      name: "BitCoin",
                      code: "BTC",
                      amount: "9 785",
                      icon: Icons.currency_bitcoin,
                      isInverted: true),
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: const CurrencyCard(
                      name: "Dollar",
                      code: "USD",
                      amount: "428",
                      icon: Icons.attach_money,
                      isInverted: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
