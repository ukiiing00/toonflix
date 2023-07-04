import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  final bool center;
  final Color color;
  final String text, startTime, endTime;
  final List<String> withWho;

  const ScheduleScreen({
    super.key,
    required this.center,
    required this.color,
    required this.text,
    required this.startTime,
    required this.endTime,
    required this.withWho,
  });

  @override
  Widget build(BuildContext context) {
    final String startTimeHour = '${startTime.split(':')[0]}\n';
    final String startTimeMinute = startTime.split(':')[1];
    final String endTimeHour = '${endTime.split(':')[0]}\n';
    final String endTimeMinute = endTime.split(':')[1];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: color,
      ),
      height: 190,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: startTimeHour,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          height: 0.9,
                        ),
                        children: [
                          TextSpan(
                            text: startTimeMinute,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      width: 0.5,
                      height: 22,
                      color: Colors.black,
                    ),
                    Text.rich(
                      TextSpan(
                        text: endTimeHour,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            height: 0.9),
                        children: [
                          TextSpan(
                            text: endTimeMinute,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Text(
                text.replaceAll(' ', '\n'),
                style: const TextStyle(
                  fontSize: 60,
                  height: 0.9,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 60,
                ),
                for (var who in withWho)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 30,
                    ),
                    child: Text(
                      who.toUpperCase(),
                      style: TextStyle(
                        color: who == 'ME'
                            ? Colors.black
                            : Colors.black.withOpacity(0.3),
                        fontWeight: who == 'ME' ? FontWeight.bold : null,
                      ),
                    ),
                  ),
                if (center)
                  for (var widget in [
                    Text(
                      '+4',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                  ])
                    widget,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
