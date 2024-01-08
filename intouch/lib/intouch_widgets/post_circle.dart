import 'package:flutter/material.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/services/database.dart';
import 'package:intouch/services/firebase_storage.dart';

class PostCircle extends StatefulWidget {
  
  Post post;
  
  PostCircle({
    super.key,
    required this.post});

  

  @override
  State<PostCircle> createState() => _PostCircleState();
}

class _PostCircleState extends State<PostCircle> {

  Future<String>? imageUrl;
  Future<String?>? userName;
  final StorageService _storage = StorageService();
  final UserDatabaseService _database = UserDatabaseService();

@override
  void initState() {
    super.initState();
    //imageUrl = _storage.getUserImageUrl(widget.post.userImg!);
    userName = _database.getUserNameById(widget.post.id);
    
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: imageUrl,
      builder:(context,imageUrl){
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: (){
            print(widget.post);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                foregroundImage: imageUrl.hasData? NetworkImage(imageUrl.data!): const AssetImage("assets/images/intouch-default.png") as ImageProvider,
                radius: 36  ,
              ),
              //Text(widget.post.username!)
            ],
          ),
        ),
      );
    });
    }
  }