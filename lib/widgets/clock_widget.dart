import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:neumorphic_clock_app/widgets/elevation_widget.dart';

class ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 2,
      child: ElevationWidget(
        height: 300,
        width: 300,
        paint: ClockPainter(),
        child: ElevationWidget(
          height: 150,
          width: 150,
          paint: SmallClockPainter(),
          child: CustomPaint(
            painter: DrawClockHand(),
          ),
        ),
      ),
    );
  }
}

class DrawClockHand extends CustomPainter {
  var date = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var center = Offset(size.width / 2, (size.height / 2));
    var centerHour = Offset((size.width / 2), size.height / 2);

    var minHand = Paint()
      ..color = Color(0xFF710C0C)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    var hourHand = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    var secHand = Paint()
      ..color = Color(0xFF806a6a)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 7;

    var secHandX = (size.width / 2) + 106 * cos(date.second * 6 * pi / 180);
    var secHandY = (size.width / 2) + 106 * sin(date.second * 6 * pi / 180);

    var minHandX = (size.width / 2) + 118 * cos(date.minute * 6 * pi / 180);
    var minHandY = (size.width / 2) + 118 * sin(date.minute * 6 * pi / 180);

    var hourHandX = (size.width / 2) + 95 * cos((date.hour * 30 + date.minute * 0.5) * pi / 180);
    var hourHandY = (size.width / 2) + 95 * sin((date.hour * 30 + date.minute * 0.5) * pi / 180);

    canvas.drawLine(centerHour, Offset(hourHandX, hourHandY), hourHand);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHand);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHand);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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

    var outerLinesPaint = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    canvas.drawCircle(center, radiusOuter, fillOuterCircle);

    var m1 = 150 - 14;
    var m2 = radiusOuter - 3.5;

    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + m1 * cos(i * pi / 180);
      var y1 = centerX + m1 * sin(i * pi / 180);

      var x2 = centerX + m2 * cos(i * pi / 180);
      var y2 = centerX + m2 * sin(i * pi / 180);

      canvas.drawLine(Offset(x2, y2), Offset(x1, y1), outerLinesPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
