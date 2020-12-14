import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:neumorphic_clock_app/widgets/clock_widget.dart';
import 'package:neumorphic_clock_app/widgets/alarm_tile.dart';

class ClockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb9abab),
      body: SingleChildScrollView(
        child: Column(
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
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            ClockWidget(),
            SizedBox(
              height: 20,
            ),
            AlarmTile(0),
            AlarmTile(1),
            AlarmTile(2),
          ],
        ),
      ),
    );
  }
}
