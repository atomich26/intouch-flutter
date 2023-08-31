import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets.dart';

class Search extends StatelessWidget {
  const Search({super.key});
  final String title = 'Search';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: inTouchAppBar(context, '$title'),
          body: Center(
            child: Text('This is the Search Screen')
          ),
    );
  }
}