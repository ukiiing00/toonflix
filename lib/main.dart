import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toonflix/screens/home_screen.dart';
import 'package:toonflix/screens/pomodoros_challenge_screen.dart';
import 'package:toonflix/widgets/schedule_card.dart';

void main() {
  runApp(const PomodorosChallenge());
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
