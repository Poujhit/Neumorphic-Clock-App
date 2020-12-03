import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SetAlarm {
  static Future<void> cancelAlarm(int id) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> setAlarm(TimeOfDay selectedTime, int id) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    print(currentTimeZone);
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var notifydate;
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
      // tz.TZDateTime.now(tz.local)
      //     .subtract(Duration(seconds: tz.TZDateTime.now(tz.local).second))
      //     .add(Duration(days: 1, hours: hour, minutes: min));
      print(notifydate.toString());
      print('isAfter true(alarm time is after the now date)');
    } else {
      notifydate = tz.TZDateTime.now(tz.local)
          .subtract(Duration(seconds: tz.TZDateTime.now(tz.local).second))
          .add(Duration(hours: hour, minutes: min));
      print('isAfter:false');
    }
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'time',
      sound: RawResourceAndroidNotificationSound('alarm_ringtone'),
      largeIcon: DrawableResourceAndroidBitmap('time'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
      sound: 'alarm_ringtone.mp3',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      'Alarm',
      'Wake Up!!!!!!!',
      notifydate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
