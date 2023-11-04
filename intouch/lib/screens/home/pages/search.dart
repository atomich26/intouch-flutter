import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/category_box.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';

import '../../../models/category.dart';

class Search extends StatefulWidget {
  Search({
    super.key,
    required this.categories});

  List<Category> categories;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final String title = 'Search';
  
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: inTouchAppBar(context, '$title'),
        body: 
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75),
              itemBuilder: (context, i){
                return CategoryBox(
                  context: context, 
                  id: widget.categories[i].id, 
                  name: widget.categories[i].name, 
                  cover: "assets/images/concert.png");
              }, 
              itemCount: widget.categories.length)
          
    );
  }
}