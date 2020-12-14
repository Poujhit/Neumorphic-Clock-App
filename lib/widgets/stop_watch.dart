import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import './elevation_widget.dart';

class StopWatchWidget extends StatefulWidget {
  final stopWatch;
  StopWatchWidget({this.stopWatch});
  @override
  _StopWatchWidgetState createState() => _StopWatchWidgetState();
}

class _StopWatchWidgetState extends State<StopWatchWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevationWidget(
      height: 300,
      width: 300,
      paint: StopWatchFirstCirclePainter(),
      child: StreamBuilder<int>(
        stream: widget.stopWatch.rawTime,
        initialData: 0,
        builder: (context, snap) {
          final value = snap.data;
          final displayTime = StopWatchTimer.getDisplayTime(value);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  displayTime,
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  value.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class StopWatchFirstCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);

    var radiusOuter = min(centerX, centerY);

    var fillOuterCircle = Paint()..color = Color(0xFFb9abab);

    var outerLinesPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    canvas.drawCircle(center, radiusOuter, fillOuterCircle);

    var m1 = 150 - 14;
    var m2 = radiusOuter - 3.5;

    for (double i = 0; i < 360; i += 8) {
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
