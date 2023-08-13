import 'package:flutter/material.dart';
import 'package:intouch/screens/home/home.dart';
import 'package:lottie/lottie.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                        child: Image(image: AssetImage("assets/images/intouch_full_logo.png")),
                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 48.0),
                       ),
                       SizedBox(height: 6,),
                       Text("Demo Version"),
                     ],
                   ),
                   FilledButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>Home())
                        );
                    }, 
                    child: Text("Enter"))
                   

                ],
              ),
              ),
          )
        ],)
      
    );
  }
}