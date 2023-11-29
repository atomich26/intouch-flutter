import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});
  final String title = 'Notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: inTouchAppBar(context,'$this', null,(){}),
      body: Center(
        child: Text('This is the Notifications Screen'),
        ),
    );
  }
}