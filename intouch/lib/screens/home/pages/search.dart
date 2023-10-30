import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/category_box.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';

class Search extends StatefulWidget {
  const Search(categories, {super.key});

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
        body: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CategoryBox(context: context, index: index);
                },
                childCount: 25,
              ),
            ),
          ]
        ),
    );
  }
}