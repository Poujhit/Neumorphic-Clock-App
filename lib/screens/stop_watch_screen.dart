import 'package:flutter/material.dart';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'package:neumorphic_clock_app/widgets/stop_watch.dart';

class StopWatchScreen extends StatefulWidget {
  @override
  _StopWatchScreenState createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  int stopCheck = 0;

  List<String> _lapTimes = [];

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  Widget neumorphicButton({double left, double right, String text, Color textcolor, void Function() pressAction}) {
    return Container(
      height: 50,
      width: 110,
      margin: EdgeInsets.only(left: left, right: right),
      child: NeumorphicButton(
        duration: Duration(milliseconds: 200),
        onPressed: pressAction,
        style: NeumorphicStyle(
          color: Color(0xFFb9abab),
          shadowLightColor: Color(0xFFB4B0B0),
          depth: 25,
          disableDepth: false,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(21)),
          shape: NeumorphicShape.concave,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb9abab),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 29,
                ),
                child: BorderedText(
                  strokeWidth: 1.0,
                  strokeColor: Color(0xFF707070),
                  child: Text(
                    'Stop Watch',
                    style: TextStyle(
                      fontSize: 28,
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
              StopWatchWidget(stopWatch: _stopWatchTimer),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.16 - 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  neumorphicButton(
                    left: 40,
                    right: 0,
                    text: 'Reset',
                    textcolor: Color(0xFF707070),
                    pressAction: () async {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                      _lapTimes.clear();
                      setState(() {
                        stopCheck = 0;
                      });
                    },
                  ),
                  neumorphicButton(
                    left: 0,
                    right: 40,
                    text: 'Start',
                    textcolor: Color(0xFF0C7127),
                    pressAction: () async {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13 - 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  neumorphicButton(
                    left: 40,
                    right: 0,
                    text: 'Stop',
                    textcolor: Colors.red[900],
                    pressAction: () async {
                      if (stopCheck == 0) {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                        _stopWatchTimer.rawTime.first.then((value) {
                          if (value == 0) return;
                          print('value $value');
                          _lapTimes.add(StopWatchTimer.getDisplayTime(value));
                          setState(() {
                            stopCheck = 1;
                          });
                          return;
                        });
                      } else {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                      }
                    },
                  ),
                  neumorphicButton(
                    left: 0,
                    right: 40,
                    text: 'Lap',
                    textcolor: Color(0xFF707070),
                    pressAction: () async {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                      _stopWatchTimer.records.listen((allLaps) {
                        if (allLaps.length == 0) return;
                        _lapTimes.clear();
                        for (StopWatchRecord eachlap in allLaps) {
                          _lapTimes.add(eachlap.displayTime);
                        }
                        setState(() {});
                        return;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ..._lapTimes.map((eachLap) {
            return Card(
              key: UniqueKey(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              margin: const EdgeInsets.only(
                bottom: 12,
                left: 20,
                right: 20,
              ),
              elevation: 10,
              shadowColor: Color(0xFFC5C1C1),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: Color(0xFFb9abab),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      '  ${_lapTimes.indexWhere((element) => element == eachLap) + 1}',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF806a6a),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      ' Lap',
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF707070),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.17,
                    ),
                    Text(
                      eachLap,
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF806a6a),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
