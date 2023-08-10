// Developer by : Azozz ALFiras
// https://github.com/AzozzALFiras/Task_Manager

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_inapp_notifications/flutter_inapp_notifications.dart';
import 'package:taskmanager/ui/screens/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SlpashScreen(),
      builder: InAppNotifications.init(),
    );
  }
}
