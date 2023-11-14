import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';


class EventForm extends StatelessWidget {
  const EventForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, 
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      body:Center(
        child: Text('This is the Event Form')
      ),
    );
  }
}