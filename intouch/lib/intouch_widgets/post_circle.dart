import 'package:flutter/material.dart';

class PostCircle extends StatelessWidget {
  
  String image;
  
  PostCircle({
    super.key,
    required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        foregroundImage: AssetImage('$image'),
        minRadius: 32.0,
        maxRadius: 48.0
      ),
    );
  }
}