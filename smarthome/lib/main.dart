import 'package:flutter/material.dart';
import 'package:smarthome/DesktopScreen.dart';
import 'package:smarthome/HomeScreen.dart';
import 'package:smarthome/ResponsiveLayout.dart';

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
      home: ResponsiveLayout(
        homeView: HomeScreen(),
        desktopView: DesktopView(),

      )
    );
  }
}
