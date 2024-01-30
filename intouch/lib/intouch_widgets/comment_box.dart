import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/comment.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/screens/home/pages/profile_page.dart';
import 'package:intouch/services/database.dart';

class CommentBox extends StatelessWidget {
  CommentBox({
    super.key,
    required this.comment,
    });
  
  final Comment comment;
  final UserDatabaseService _userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    Future<AppUserData>? userById = _userDatabaseService.getUserById(comment.userId!);
    return FutureBuilder(
      future: userById, 
      builder: (context, user){
        if(user.hasData){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: (){Navigator.of(context).push(fromTheRight(ProfilePage(user:user.data!)));},
                    child: Text("@${user.data!.username!}", 
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(comment.content?? "")
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }
    );
  }
}