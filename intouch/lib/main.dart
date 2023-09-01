import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/services/auth_service.dart';
import 'package:intouch/themes.dart';
import 'package:intouch/wrapper.dart';
import 'package:provider/provider.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: lightTheme,
        home: Wrapper(),
      ),
    );
  }
}

