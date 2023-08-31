import 'package:flutter/material.dart';
import 'package:intouch/screens/auth/intro.dart';
import 'package:intouch/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if(user == null){
      return Intro();
      }
    else {
      return Home();
      }

   }
}