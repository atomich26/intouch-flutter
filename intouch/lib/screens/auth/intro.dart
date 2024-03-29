import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/screens/auth/login.dart';
import 'package:intouch/screens/auth/register.dart';
import 'package:lottie/lottie.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';

class Intro extends StatelessWidget {
  Intro({super.key});
  final TextEditingController test = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Lottie.asset('assets/anim/intro_background_anim.json', fit:BoxFit.fill)
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Column(
                     children: [
                       Container(
                        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 64.0),
                        child: const Image(image: AssetImage("assets/images/intouch_full_logo.png")),
                       ),
                       const SizedBox(height: 24.0),
                       const Text("Demo Version", textScaler: TextScaler.linear(1.5),),                     
                       ],
                   ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget> [
                              InTouchLongButton(
                                context, 
                                "Login", 
                                null, 
                                true, 
                                (){ 
                                  Navigator.of(context).push(fromTheRight(const Login()));
                                  }),
                              const SizedBox(height: 12.0),
                              InTouchLongButton(
                                context, 
                                "Sign Up", 
                                null, 
                                false, 
                                (){ 
                                  Navigator.of(context).push(fromTheRight(const Register()));
                                  }),
                              ]
                            ),
                        ),
                        
                      ],
                    ),
              ),
            )
        ],)
      
    );
  }
}