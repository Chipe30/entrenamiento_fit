
import 'dart:async';
import 'package:flutter/material.dart';

class ExerciseTimer extends StatefulWidget {
  final int seconds;

  const ExerciseTimer({super.key, required this.seconds});

  @override
  State<ExerciseTimer> createState() => _ExerciseTimerState();
}

class _ExerciseTimerState extends State<ExerciseTimer> {
  late int remainingSeconds;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.seconds;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$remainingSeconds s',
        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      ),
    );
  }
}
