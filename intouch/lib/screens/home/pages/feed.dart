import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/feed_box.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/post_feed.dart';
import 'package:intouch/models/event.dart';

import '../../../intouch_widgets/category_empty.dart';
import '../../../models/category.dart';

class Feed extends StatefulWidget {
  Feed({
    super.key,
    this.events});

  List<Event>? events;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final String title = 'Feed';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(widget.events != null){
    return Scaffold(
        appBar: inTouchAppBar(context, title, null, (){}),
        body: 
              Column(
                children:[
                  Expanded(
                    child: PostFeed()
                    ),
                  Expanded(
                    flex: 5,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1),
                      itemBuilder: (context, i){
                        return FeedBox(
                          context: context, 
                          event: widget.events![i], 
                          );
                        }, 
                      itemCount: widget.events!.length),
                  ),
                ],
              ),
            );
      }
    else {
      return Scaffold(
        appBar: inTouchAppBar(context, title, null, (){}),
        body: 
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1),
              itemBuilder: (context, i){
                return CategoryEmpty();
              }, 
              itemCount: 15)
      );
    }
  }
}