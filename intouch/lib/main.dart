import 'package:flutter/material.dart';
import 'package:intouch/screens/auth/intro.dart';
import 'package:intouch/themes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: Intro(),
    );
  }
}

