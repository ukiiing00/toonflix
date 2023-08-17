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
  int totalRound = 0;
  int totalGoal = 1;
  int _selectNum = 2;
  bool isBreakTime = false;

  late Timer timer;

  late final ScrollController _scrollController =
      ScrollController(initialScrollOffset: _selectNum * 90);

  @override
  void initState() {
    super.initState();
  }

  void onSelectTime({required int time, required int index}) {
    timer.cancel();
    setState(() {
      isRunning = false;
      _selectNum = index;
      selectMinute = time * 60;
      totalSecond = selectMinute;
      _scrollController.animateTo(
        index * 90,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  void breakTime() {
    totalSecond = 5 * 60;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isBreakTime = true;
      isRunning = true;
    });
  }

  void onTick(Timer timer) {
    print(timer.tick);
    if (totalSecond == 0) {
      if (totalRound == 4) {
        totalGoal + 1;
        totalRound = 1;
        breakTime();
      } else if (isBreakTime) {
        isBreakTime = false;
      } else {
        totalRound += 1;
        breakTime();
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
    if (totalRound == 0) totalRound = 1;
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
              height: 50,
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 161,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: minutes.length,
                itemBuilder: (context, index) {
                  var opacity = 1 - (index - _selectNum).abs() * 0.4;
                  return GestureDetector(
                    onTap: () =>
                        onSelectTime(time: minutes[index], index: index),
                    child: AnimatedOpacity(
                      opacity: opacity.abs(),
                      duration: const Duration(milliseconds: 500),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 70,
                          decoration: BoxDecoration(
                            color: _selectNum == index ? Colors.white : null,
                            border: Border.all(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              '${minutes[index]}',
                              style: TextStyle(
                                color: _selectNum == index
                                    ? Theme.of(context).primaryColor
                                    : Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
            child: Stack(
              fit: StackFit.loose,
              children: [
                Align(
                  alignment: const Alignment(0, 0),
                  child: GestureDetector(
                    onTap: isRunning ? onStopPressed : onStartPressed,
                    child: Container(
                      height: 110,
                      width: 110,
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
                ),
                Align(
                  alignment: const Alignment(0.4, 1.2),
                  child: GestureDetector(
                    onTap: onResetPressed,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.refresh_outlined,
                        size: 25,
                        color: Color(0xFFBF3B2B),
                      ),
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
