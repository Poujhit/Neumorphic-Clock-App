import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SetAlarm {
  static BuildContext context;
  static Future<void> setAlarmtoStorage({
    int id,
    TimeOfDay alarmTime,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('$id', [alarmTime.hour.toString(), alarmTime.minute.toString()]);
  }

  static Future<TimeOfDay> getAlarmfromStorage({int id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final hourAndMin = pref.getStringList('$id');
    final time = TimeOfDay(
      hour: int.parse(hourAndMin[0]),
      minute: int.parse(hourAndMin[1]),
    );
    return time;
  }

  static Future<void> setAlarmOnorOff({
    bool value,
    int id,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('${id * 10 + 100}', value);
  }

  static Future<bool> getAlarmOnorOff({int id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final value = pref.getBool('${id * 10 + 100}');
    return value;
  }

  static void openAScreen() {
    print('running alarm');
    Fluttertoast.showToast(
      msg: 'Turn off the toggle to off the alarm or just press the power button to turn it off!!',
      fontSize: 16,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 10,
    );
  }

  static Future<void> cancelAlarm(int id) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.cancel(id);
    await AndroidAlarmManager.cancel(id);
  }

  static Future<void> setAlarm(TimeOfDay selectedTime, int id, BuildContext context) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var notifydate, notifydateForAlarmManager;
    final hour = (TimeOfDay.now().hour - selectedTime.hour).abs();
    final min = (TimeOfDay.now().minute - selectedTime.minute).abs();
    if (tz.TZDateTime.now(tz.local).isAfter(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      selectedTime.hour,
      selectedTime.minute,
    ))) {
      notifydate = tz.TZDateTime.local(DateTime.now().year, DateTime.now().month,
          DateTime.now().add(Duration(days: 1)).day, selectedTime.hour, selectedTime.minute);
      notifydateForAlarmManager = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().add(Duration(days: 1)).day, selectedTime.hour, selectedTime.minute);
      print('isAfter true(alarm time is after the now date)');
    } else {
      notifydate = tz.TZDateTime.now(tz.local)
          .subtract(Duration(seconds: tz.TZDateTime.now(tz.local).second))
          .add(Duration(hours: hour, minutes: min));
      notifydateForAlarmManager = DateTime.now()
          .subtract(Duration(seconds: tz.TZDateTime.now(tz.local).second))
          .add(Duration(hours: hour, minutes: min));
      print('isAfter:false');
    }
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notify',
      'alarm_notify',
      'Channel for Alarm notification',
      icon: 'time',
      sound: RawResourceAndroidNotificationSound('alarm_ringtone'),
      largeIcon: DrawableResourceAndroidBitmap('time'),
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
      enableLights: true,
      enableVibration: true,
      fullScreenIntent: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'alarm_ringtone.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    SetAlarm.context = context;
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Alarm',
      'Wake Up!!!',
      notifydate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
    final result = await AndroidAlarmManager.oneShotAt(
      notifydateForAlarmManager,
      id,
      SetAlarm.openAScreen,
      alarmClock: true,
      allowWhileIdle: true,
      exact: true,
      rescheduleOnReboot: true,
      wakeup: true,
    );
    print('result :$result');
  }
}
