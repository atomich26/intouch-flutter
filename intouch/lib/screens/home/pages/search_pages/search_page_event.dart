import 'package:flutter/material.dart';

class SearchPageEvent extends StatelessWidget {
  SearchPageEvent({
    super.key,
    required this.query
    });

  String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Events search"),
    );
  }
}