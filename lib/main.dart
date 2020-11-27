import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/clock_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic Clock App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Pro',
      ),
      home: ClockScreen(),
    );
  }
}
// #806A6A
