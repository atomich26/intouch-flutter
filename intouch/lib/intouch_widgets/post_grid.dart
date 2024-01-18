import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/screens/home/pages/post_page.dart';
import 'package:intouch/services/firebase_storage.dart';

class PostGrid extends StatelessWidget {
  PostGrid({
    super.key,
    required this.post});

  Post post;
  final StorageService _storage = StorageService();

  @override
  Widget build(BuildContext context) {

    Future<String> imageUrl = _storage.getPostImageUrl(post.album![0]);
    return FutureBuilder(
      future: imageUrl, 
      builder: (context, imageUrl){
        return GestureDetector(
          onTap:(){ Navigator.of(context).push(fromTheBottom(PostPage(post: post)));},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              image: DecorationImage(
                image: imageUrl.hasData? NetworkImage(imageUrl.data!):  const AssetImage("assets/images/intouch-default.png") as ImageProvider,
                fit: BoxFit.cover
                )
            ),
          ),
        );
      });
  }
}