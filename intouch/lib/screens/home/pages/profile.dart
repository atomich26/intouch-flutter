import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets.dart';
import 'package:intouch/services/auth_service.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final String title = 'Profile';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: inTouchAppBar(context, '$title'),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : <Widget> [
                    Text('This is the Profile Page'),
                    SizedBox(height:12.0),
                    inTouchLongButton(context, 'LOGOUT', null, true, () async {
                      await _auth.signOut();
                    })
                  ],
                ),
              )
            )
      );
    }
}