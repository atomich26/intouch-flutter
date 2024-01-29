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
  
  Future<List<Future<Post>?>?>? posts;

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
        if(posts.hasData && posts.data!.isNotEmpty){ 
          print(posts.data!.length);
            return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: posts.data!.length,
            itemBuilder: (context, i){
              return FutureBuilder(
                future: posts.data![i],
                builder: (context, post) {
                  return !post.hasData? const SizedBox.shrink():
                  PostCircle(post : post.data!);
                }
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      });
  }
}