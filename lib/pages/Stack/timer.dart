import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerDemo extends StatefulWidget {
  const CountdownTimerDemo({Key? key}) : super(key: key);

  @override
  State<CountdownTimerDemo> createState() => _CountdownTimerDemoState();
}

class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(days: 5);
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        myDuration = Duration(seconds: seconds);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    final moonLanding = DateTime.parse('1969-07-20 23:59:59Z');

    var now1 = "${moonLanding.hour - date.hour}";
    var now2 = "${moonLanding.minute - date.minute}";
    var now3 = "${moonLanding.second - date.second}";
    var time1 = now1.toString().padLeft(2, "0");
    var time2 = now2.toString().padLeft(2, "0");
    var time3 = now3.toString().padLeft(2, "0");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.grey.shade800,
              child: Text(
                time1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'HRS',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                  fontSize: 10),
            ),
          ],
        ),
        const SizedBox(width: 2),
        const Text(
          ':',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        const SizedBox(width: 2),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.grey.shade800,
              child: Text(
                time2,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'MINS',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                  fontSize: 10),
            ),
          ],
        ),
        const SizedBox(width: 2),
        const Text(
          ':',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        const SizedBox(width: 2),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              color: Colors.grey.shade800,
              child: Text(
                time3,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'SECS',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                  fontSize: 10),
            ),
          ],
        )
      ],
    );
  }
}
