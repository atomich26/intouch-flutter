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
      tertiary: Colors.red[300]!,
      onTertiary: Colors.white,
      onTertiaryContainer: Colors.pink[900]!,
      error: Colors.red[500]!,
      onError: Colors.white,
      onErrorContainer: Colors.red[900]!,
      background: Colors.grey[50]!,
      onBackground: Colors.black,
      surface: Colors.grey[50]!,
      onSurface: Colors.black,
      
   ),
);
