import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/post_circle.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/services/cloud_functions.dart';

class PostFeed extends StatefulWidget {
  const PostFeed({
    super.key
    });

  @override
  State<PostFeed> createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  
  Future<List<Post>>? posts;

  @override
  void initState() {
    super.initState();
    posts = feedPost();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: posts, 
      builder: (context, posts){
        if(posts.hasData){
          print(posts.data);
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: posts.data!.length,
            itemBuilder: (context, i){
              return PostCircle(post :posts.data![i]);
            },
          );
        } else {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount : 10,
            itemBuilder: (context, i){
              return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundColor: Colors.grey[50],
                            ),
                            );

            });
        }
      });
  }
}