import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class TimerWidget extends StatelessWidget {
  final CountDownController countDownController;
  final int hours, min, sec;

  TimerWidget({
    this.countDownController,
    this.hours,
    this.min,
    this.sec,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 18,
        borderOnForeground: false,
        shadowColor: const Color(0xFFb9abab),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(300),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF806a6a),
                offset: Offset(0, 10),
                blurRadius: 34,
                spreadRadius: 0,
              ),
              BoxShadow(
                color: const Color(0xFFb9abab),
                offset: Offset(0, 0),
                blurRadius: 34,
                spreadRadius: 0,
              ),
            ],
          ),
          child: CircularCountDownTimer(
            width: 300,
            height: 300,
            duration: Duration(hours: hours, minutes: min, seconds: sec).inSeconds,
            fillColor: Color(0xFF806a6a),
            color: Color(0xFF9E8B8B),
            isTimerTextShown: true,
            controller: countDownController,
            strokeCap: StrokeCap.round,
            strokeWidth: 10,
            textStyle: TextStyle(
              fontSize: 28,
              color: Color(0xFF5A5959),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
