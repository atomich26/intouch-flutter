import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/event_card.dart';
import 'package:intouch/intouch_widgets/feed_box.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/post_circle.dart';

import '../../../intouch_widgets/category_empty.dart';
import '../../../models/category.dart';

class Feed extends StatefulWidget {
  Feed({
    super.key,
    this.categories});

  List<Category>? categories;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final String title = 'Feed';

 @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(widget.categories != null){
    return Scaffold(
        appBar: inTouchAppBar(context, '$title'),
        body: 
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1),
              itemBuilder: (context, i){
                return FeedBox(
                  context: context, 
                  category: widget.categories![i], 
                  );
              }, 
              itemCount: widget.categories!.length)
      );}
    else return Scaffold(
        appBar: inTouchAppBar(context, '$title'),
        body: 
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1),
              itemBuilder: (context, i){
                return CategoryEmpty();
              }, 
              itemCount: 15)
      );
  }
}