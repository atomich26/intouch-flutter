import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/event_card.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/post_circle.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});
  final String title = 'Feed';

  void initState()
    {
      print('Feed fuction ran');
    }
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: inTouchAppBar(context, '$this'),
      body: CustomScrollView(
        slivers: [
          
        ],
      )
      
                    
    );
              
  }
}