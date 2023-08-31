import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});
  final String title = 'Feed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: inTouchAppBar(context, '$this'),
        body: Center(
          child: Text('this is the Feed Screen'),
      ),
    );
  }
}