
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/category_box.dart';
import 'package:intouch/intouch_widgets/category_empty.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/screens/home/pages/search_page.dart';

import '../../../models/category.dart';

class Search extends StatefulWidget {
  Search({
    super.key,
    this.categories});

  final List<Category>? categories;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final String title = 'Search';
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if(widget.categories != null){
    return Scaffold(
        appBar: inTouchAppBar(
          context, 
          title, 
          Icons.search_rounded, 
          () {Navigator.of(context).push(fromTheRight(const SearchPage()));
              return null;}),
        body: 
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75),
              itemBuilder: (context, i){
                return CategoryBox(
                  context: context,
                  category: widget.categories![i]
                  );
              }, 
              itemCount: widget.categories!.length)
      );}
    else {
    //If internet isn't available (referred to the future at Home level)
      return Scaffold(
        appBar: inTouchAppBar(context, title, null, (){
          return null;
        }),
        body: 
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75),
              itemBuilder: (context, i){
                return CategoryEmpty();
              }, 
        itemCount: 15)
      );
    }
  }
}