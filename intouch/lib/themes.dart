import 'package:flutter/material.dart';



ThemeData lightTheme = ThemeData(
  fontFamily: 'righteous',
  useMaterial3: true,
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.purple[700]!,
      onPrimary: Colors.white,
      primaryContainer: Colors.white70 ,
      secondary: Colors.grey[600]!,
      onSecondary: Colors.white,
      onSecondaryContainer: Colors.black,
      tertiary: Colors.purple[50]!,
      onTertiary: Colors.black,
      onTertiaryContainer: Colors.pink[900]!,
      error: Colors.red[500]!,
      onError: Colors.white,
      onErrorContainer: Colors.red[900]!,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
   ),
);
