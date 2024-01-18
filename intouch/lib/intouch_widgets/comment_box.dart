import 'package:flutter/material.dart';
import 'package:intouch/models/comment.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/services/database.dart';

class CommentBox extends StatelessWidget {
  CommentBox({
    super.key,
    required this.comment,
    });
  
  Comment comment;
  UserDatabaseService _userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    Future<AppUserData>? userById = _userDatabaseService.getUserById(comment.userId!);
    return FutureBuilder(
      future: userById, 
      builder: (context, user){
        if(user.hasData){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("@"+user.data!.username!),
              Text(comment.content!)
            ],
          );
        } else {
          return SizedBox();
        }
      }
    );
  }
}