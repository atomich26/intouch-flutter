import 'package:flutter/material.dart';
import 'package:intouch/models/category.dart';

class Notifications extends StatelessWidget {
  Notifications({
    super.key,
    this.categories});
  List<Category>? categories;
  
  final String title = 'Notifications';

  Set<Category> categorySelected = <Category> {};

  @override
  Widget build(BuildContext context) {

      return const Scaffold(body: Center(child: Text("This is the Notification Page"),));
  }
}