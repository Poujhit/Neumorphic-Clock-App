import 'dart:async';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';

import 'package:bordered_text/bordered_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic_clock_app/widgets/timer_widget.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  AudioPlayer audioPlugin = AudioPlayer();
  StreamSubscription<Duration> _audioPlayerStateSubscription;

  CountDownController countDownController;
  int hours = 0;
  int min = 0;
  int sec = 0;

  @override
  void initState() {
    countDownController = CountDownController();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayerStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb9abab),
      body: ListView(
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
                    'Timer',
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
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TimerWidget(
                countDownController: countDownController,
                hours: hours,
                min: min,
                sec: sec,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NumberPicker.integer(
                        zeroPad: true,
                        step: 1,
                        initialValue: -1,
                        minValue: -1,
                        maxValue: 12,
                        onChanged: (value) {
                          hours = value;
                        },
                        selectedTextStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF5A5959),
                          fontWeight: FontWeight.bold,
                        ),
                        haptics: true,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        highlightSelectedValue: true,
                        textStyle: TextStyle(
                          fontSize: 28,
                          color: Color(0xFF5A5959),
                          fontWeight: FontWeight.bold,
                        ),
                        textMapper: (numberText) {
                          if (numberText == '-1')
                            return 'Scroll';
                          else
                            return numberText;
                        },
                      ),
                      Text(
                        'Hour(s)',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF5A5959),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NumberPicker.integer(
                        zeroPad: true,
                        step: 1,
                        initialValue: -1,
                        minValue: -1,
                        maxValue: 60,
                        onChanged: (value) {
                          min = value;
                        },
                        selectedTextStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF5A5959),
                          fontWeight: FontWeight.bold,
                        ),
                        haptics: true,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        textMapper: (numberText) {
                          if (numberText == '-1')
                            return 'Scroll';
                          else
                            return numberText;
                        },
                        highlightSelectedValue: true,
                        textStyle: TextStyle(
                          fontSize: 28,
                          color: Color(0xFF5A5959),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Min(s)',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF5A5959),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NumberPicker.integer(
                        zeroPad: true,
                        step: 1,
                        initialValue: -1,
                        minValue: -1,
                        maxValue: 60,
                        textMapper: (numberText) {
                          if (numberText == '-1')
                            return 'Scroll';
                          else
                            return numberText;
                        },
                        onChanged: (value) {
                          sec = value;
                        },
                        selectedTextStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF5A5959),
                          fontWeight: FontWeight.bold,
                        ),
                        haptics: true,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        highlightSelectedValue: true,
                        textStyle: TextStyle(
                          fontSize: 28,
                          color: Color(0xFF5A5959),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Sec(s)',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF5A5959),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: NeumorphicButton(
                      duration: Duration(milliseconds: 200),
                      onPressed: () {
                        setState(() {});
                        countDownController.restart(
                            duration: Duration(hours: hours, minutes: min, seconds: sec).inSeconds);
                        audioPlugin.play(
                            'https://download1074.mediafire.com/u1zqgp7fq6rg/ovak25qjlu7e9dq/Meditation+Music+%5BFull+Tracks%5D+Royalty+Free+Background+Music.mp3');
                        _audioPlayerStateSubscription = audioPlugin.onAudioPositionChanged.listen((event) {
                          if (Duration(hours: hours, minutes: min, seconds: sec).inSeconds == Duration.zero.inSeconds)
                            audioPlugin.stop();
                        });
                      },
                      style: NeumorphicStyle(
                        color: Color(0xFFb9abab),
                        shadowLightColor: Color(0xFFB4B0B0),
                        depth: 25,
                        disableDepth: false,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(21)),
                        shape: NeumorphicShape.concave,
                      ),
                      child: Text(
                        'Start',
                        style: TextStyle(
                          color: Color(0xFF0C7127),
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: NeumorphicButton(
                      duration: Duration(milliseconds: 200),
                      onPressed: () {
                        setState(() {
                          hours = 0;
                          min = 0;
                          sec = 0;
                        });

                        countDownController.restart(
                            duration: Duration(hours: hours, minutes: min, seconds: sec).inSeconds);

                        audioPlugin.stop();
                      },
                      style: NeumorphicStyle(
                        color: Color(0xFFb9abab),
                        shadowLightColor: Color(0xFFB4B0B0),
                        depth: 25,
                        disableDepth: false,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(21)),
                        shape: NeumorphicShape.concave,
                      ),
                      child: Text(
                        'Stop',
                        style: TextStyle(
                          color: Colors.red[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
