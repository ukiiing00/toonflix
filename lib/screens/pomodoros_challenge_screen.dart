import 'dart:async';

import 'package:flutter/material.dart';

class PomodoroChallengeScreen extends StatefulWidget {
  const PomodoroChallengeScreen({super.key});

  @override
  State<PomodoroChallengeScreen> createState() =>
      _PomodoroChallengeScreenState();
}

class _PomodoroChallengeScreenState extends State<PomodoroChallengeScreen> {
  List<int> minutes = [15, 20, 25, 30, 35];

  int selectMinute = 1500;
  int totalSecond = 1500;
  bool isRunning = false;
  int totalRound = 1;
  int totalGoal = 1;
  int _selectNum = 2;

  late Timer timer;

  void onSelectTime({required int time, required int index}) {
    setState(() {
      _selectNum = index;
      selectMinute = time * 60;
      totalSecond = selectMinute;
    });
  }

  void onTick(Timer timer) {
    if (totalSecond == 0) {
      if (totalRound == 4) {
        totalGoal + 1;
        totalRound = 1;
      } else {
        totalRound += 1;
      }
      setState(() {
        isRunning = false;
        totalSecond = selectMinute;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSecond = totalSecond - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onStopPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    if (totalGoal == 12) {
      totalGoal = 0;
    }
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSecond = selectMinute;
    });
  }

  List<String> format(int seconds) {
    Duration duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2).split(':');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'POMOTIMER',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -5,
                      child: Container(
                        width: size.width * 0.4 * 0.9,
                        height: size.height * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -10,
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.4 * 0.8,
                        height: size.height * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                          ),
                          child: Text(
                            format(totalSecond)[0],
                            style: TextStyle(
                                fontSize: 90,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ':',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 80,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: Container(
                        width: size.width * 0.4,
                        height: size.height * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -5,
                      child: Container(
                        width: size.width * 0.4 * 0.9,
                        height: size.height * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    Positioned(
                      top: -10,
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.4 * 0.8,
                        height: size.height * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            format(totalSecond)[1],
                            style: TextStyle(
                                fontSize: 90,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              height: 60,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: minutes.length,
                itemBuilder: (context, index) {
                  print(index);
                  return GestureDetector(
                    onTap: () =>
                        onSelectTime(time: minutes[index], index: index),
                    child: Container(
                      width: 70,
                      decoration: BoxDecoration(
                        color: _selectNum == index ? Colors.white : null,
                        border: Border.all(
                          width: 3,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          '${minutes[index]}',
                          style: TextStyle(
                            color: _selectNum == index
                                ? Theme.of(context).primaryColor
                                : Colors.white.withOpacity(0.6),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: isRunning ? onStopPressed : onStartPressed,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFBF3B2B),
                    ),
                    child: Icon(
                      isRunning ? Icons.pause : Icons.play_arrow,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onResetPressed,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFBF3B2B),
                    ),
                    child: const Icon(
                      Icons.refresh_outlined,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '$totalRound/4',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'ROUND',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '0/12',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        'GOAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
