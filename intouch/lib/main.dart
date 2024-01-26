import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/services/auth_service.dart';
import 'package:intouch/themes.dart';
import 'package:intouch/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future <void> main() async {
  //initialize Firebase services before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Provider call
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
  ],
    supportedLocales: [
      Locale('en'), // English
      Locale('it'), // Italian
  ],
        theme: lightTheme,
        home: const Wrapper(),
      ),
    );
  }
}

