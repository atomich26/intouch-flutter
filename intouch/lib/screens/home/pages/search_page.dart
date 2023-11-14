import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, 
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: TextField(
          decoration: InputDecoration(
            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded))
          ),
        ),),
      body: Center(),
    );
  }
}