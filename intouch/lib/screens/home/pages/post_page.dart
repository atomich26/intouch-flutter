import 'package:flutter/material.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/services/firebase_storage.dart';

class PostPage extends StatelessWidget {
  PostPage({
    super.key,
    required this.post});

    Post post;
    final StorageService _storage =StorageService();

  @override
  Widget build(BuildContext context) {
    List<Future<String>> imageUrl = List.generate(post.album!.length, (e) => _storage.getPostImageUrl(post.album![e]));
    return PageView.builder(
      itemBuilder: (context, i){
        return FutureBuilder<String>(
          future: imageUrl[i],
          builder: (context, snapshot) {
            return SafeArea(
              child: Container(
                decoration: snapshot.hasData? 
                BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(snapshot.data!) ,
                    fit: BoxFit.cover
                    )
                  ) : 
                const BoxDecoration( color:Colors.black),
                ),
            );
          }
        );
      },
      itemCount: post.album!.length,);
  }
}