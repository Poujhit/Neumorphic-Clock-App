import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:neumorphic_clock_app/alarm/set_alarm.dart';

class AlarmTile extends StatefulWidget {
  final int id;
  AlarmTile(this.id);
  @override
  _AlarmTileState createState() => _AlarmTileState();
}

class _AlarmTileState extends State<AlarmTile> {
  TimeOfDay _selectedTime = TimeOfDay(hour: 06, minute: 30);

  bool isalarmOn = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: UniqueKey(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 20,
        right: 20,
      ),
      elevation: 10,
      shadowColor: Color(0xFFb9abab),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          key: UniqueKey(),
          tileColor: Color(0xFFb9abab),
          leading: FutureBuilder<TimeOfDay>(
              future: SetAlarm.getAlarmfromStorage(id: widget.id),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator();
                if (snapshot.hasData)
                  return Text(
                    snapshot.data.format(context),
                    style: TextStyle(
                      color: Color(0xFF806a6a),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  );
                return Text(
                  _selectedTime.format(context),
                  style: TextStyle(
                    color: Color(0xFF806a6a),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                );
              }),
          trailing: FutureBuilder<bool>(
              future: SetAlarm.getAlarmOnorOff(id: widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return CircularProgressIndicator.adaptive();
                if (snapshot.hasData)
                  return Switch.adaptive(
                    key: UniqueKey(),
                    activeColor: Color(0xFF806a6a),
                    inactiveThumbColor: Color(0xFF806a6a),
                    value: snapshot.data,
                    onChanged: (value) async {
                      if (value) {
                        setState(() {
                          isalarmOn = value;
                        });
                        await SetAlarm.setAlarmOnorOff(id: widget.id, value: value);
                        await SetAlarm.setAlarm(_selectedTime, widget.id, context);
                        Fluttertoast.showToast(msg: 'Alarm On');
                      } else {
                        setState(() {
                          isalarmOn = value;
                        });
                        await SetAlarm.setAlarmOnorOff(id: widget.id, value: value);
                        await SetAlarm.cancelAlarm(widget.id);
                        Fluttertoast.showToast(msg: 'Alarm Off');
                      }
                    },
                  );
                return Switch.adaptive(
                  key: UniqueKey(),
                  activeColor: Color(0xFF806a6a),
                  inactiveThumbColor: Color(0xFF806a6a),
                  value: isalarmOn,
                  onChanged: (value) async {
                    if (value) {
                      setState(() {
                        isalarmOn = value;
                      });
                      await SetAlarm.setAlarmOnorOff(id: widget.id, value: value);
                      await SetAlarm.setAlarm(_selectedTime, widget.id, context);
                      Fluttertoast.showToast(msg: 'Alarm On');
                    } else {
                      setState(() {
                        isalarmOn = value;
                      });
                      await SetAlarm.setAlarmOnorOff(id: widget.id, value: value);
                      await SetAlarm.cancelAlarm(widget.id);
                      Fluttertoast.showToast(msg: 'Alarm Off');
                    }
                  },
                );
              }),
          onTap: () async {
            final newTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            );
            if (newTime == null)
              Fluttertoast.showToast(msg: 'Choose a Time!!');
            else {
              await SetAlarm.setAlarmOnorOff(id: widget.id, value: true);
              setState(() {
                _selectedTime = newTime;

                isalarmOn = true;
              });
              await SetAlarm.setAlarmtoStorage(
                id: widget.id,
                alarmTime: newTime,
              );
              await SetAlarm.cancelAlarm(widget.id);

              await SetAlarm.setAlarm(_selectedTime, widget.id, context);
              Fluttertoast.showToast(msg: 'Alarm On');
            }
          },
        ),
      ),
    );
  }
}
