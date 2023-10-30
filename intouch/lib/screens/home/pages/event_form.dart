import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';


class EventForm extends StatelessWidget {
  const EventForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: inTouchAppBar(context, 'Event Form'),
      body:Center(
        child: Text('This is the Event Form')
      ),
    );
  }
}