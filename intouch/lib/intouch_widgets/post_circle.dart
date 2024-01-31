import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/screens/home/pages/post_page.dart';
import 'package:intouch/services/database.dart';
import 'package:intouch/services/firebase_storage.dart';

class PostCircle extends StatefulWidget {
  
  final Post post;
  
  PostCircle({
    super.key,
    required this.post});

  

  @override
  State<PostCircle> createState() => _PostCircleState();
}

class _PostCircleState extends State<PostCircle> {

  Future<String>? imageUrl;
  Future<AppUserData>? user;
  final StorageService _storage = StorageService();
  final UserDatabaseService _database = UserDatabaseService();

@override
  void initState() {
    super.initState();
    
    user = _database.getUserById(widget.post.userId!);
    
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: user,
      builder:(context,user){
        return !user.hasData ? const SizedBox.shrink():
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(fromTheRight(PostPage(post: widget.post)));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: _storage.getUserImageUrl(user.data!.img!),
                builder: (context, user) {
                  return CircleAvatar(
                    backgroundColor: widget.post.createdAt!.millisecondsSinceEpoch >= Timestamp.now().millisecondsSinceEpoch-86400000?  Colors.purple[500] : Colors.grey[500],
                    radius:36,
                    child: CircleAvatar(
                      foregroundImage: user.hasData? NetworkImage(user.data!): const AssetImage("assets/images/intouch-default.png") as ImageProvider,
                      radius: 32),
                      
                  );
                }
              ),
              //Text(user.data!.username!)
            ],
          ),
        ),
      );
    });
    }
  }