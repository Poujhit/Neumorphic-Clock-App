import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:neumorphic_clock_app/widgets/elevation_widget.dart';

class ClockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb9abab),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + 25,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 29,
            ),
            child: BorderedText(
              strokeWidth: 1.0,
              strokeColor: Color(0xFF707070),
              child: Text(
                'Clock',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFF806a6a),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          ElevationWidget(
            height: 300,
            width: 300,
            paint: ClockPainter(),
            child: ElevationWidget(
              height: 150,
              width: 150,
              paint: SmallClockPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class SmallClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    var radiusOuter = min(centerX, centerY);

    var fillOuterCircle = Paint()..color = Color(0xFFb9abab);

    canvas.drawCircle(center, radiusOuter, fillOuterCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    var radiusOuter = min(centerX, centerY);

    var fillOuterCircle = Paint()..color = Color(0xFFb9abab);

    canvas.drawCircle(center, radiusOuter, fillOuterCircle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
