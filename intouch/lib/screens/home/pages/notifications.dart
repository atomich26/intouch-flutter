import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/category_button.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/models/category.dart';

class Notifications extends StatelessWidget {
  Notifications({
    super.key,
    this.categories});
  final String title = 'Notifications';
  List<Category>? categories;

  @override
  Widget build(BuildContext context) {
    List<Widget> categoryMap = List.generate(categories!.length, (e) => CategoryButton(context: context, category: categories![e],
     onTap: (){}));
    return Scaffold(
      appBar: inTouchAppBar(context,'$this', null,(){}),
      body: SingleChildScrollView(
        child: Wrap(
          children: categoryMap
        ),
      )
    );
  }
}