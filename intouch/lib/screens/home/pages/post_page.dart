import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/comment_box.dart';
import 'package:intouch/intouch_widgets/profile_circle.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/comment.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/screens/home/pages/event_sliver.dart';
import 'package:intouch/screens/home/pages/profile_page.dart';
import 'package:intouch/services/database.dart';
import 'package:intouch/services/firebase_storage.dart';

class PostPage extends StatelessWidget {
  PostPage({
    super.key,
    required this.post});

    Post post;
    final StorageService _storage = StorageService();
    final EventDatabaseService _eventDatabaseService = EventDatabaseService();
    final PostDatabaseService _postDatabaseService = PostDatabaseService();
    final UserDatabaseService _userDatabaseService =UserDatabaseService();
    final TextEditingController controller = TextEditingController();

    @override
    void dispose() {
    controller.dispose();
    }
  @override
  Widget build(BuildContext context) {
    Future<Event> event = _eventDatabaseService.getEventById(post.eventId!);
    Future<AppUserData> user = _userDatabaseService.getUserById(post.userId!);
    List<Future<NetworkImage>> images = List.generate(post.album!.length, (e) => _storage.getPostImageUrl(post.album![e]).then((e) => NetworkImage(e)));
    return FutureBuilder<AppUserData>(
      future: user,
      builder: (context, user) {
        return Scaffold(
          //avoid resizing of the image
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: Alignment.topLeft,
            children: [
              PageView.builder(
              itemBuilder: (context, i){
                return FutureBuilder<NetworkImage>(
                  future: images[i],
                  builder: (context, snapshot) {
                    return SafeArea(
                      child: Container(
                        decoration: snapshot.hasData? 
                        BoxDecoration(
                          image: DecorationImage(
                            image: snapshot.data as ImageProvider,
                            fit: BoxFit.cover
                            )
                          ) : 
                        const BoxDecoration( color:Colors.black),
                        ),
                    );
                  }
                );
              },
              itemCount: post.album!.length,),
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent])
                    ),
                  )
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent])
                    ),
                  )
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(fromTheBottom(ProfilePage(user: user.data!)));},
                    child: Row(
                      children: [
                        user.hasData? ProfileCircle(radius: 18, user: user.data!,) : SizedBox(),
                        SizedBox(width:8),
                        Text(user.hasData?"@"+user.data!.username!:"",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                      
                        ),
                      ],
                    ),
                  ),
                )
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 72.0, 36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FutureBuilder<Event>(
                          future: event,
                          builder: (context, event) {
                            return event.hasData?
                            FutureBuilder<String>(
                              future: _storage.getEventImageUrl(event.data!.cover),
                              builder: (context, image) {
                                return TextButton(
                                  onPressed: event.hasData?(){
                                    Navigator.of(context).push(fromTheBottom(
                                    EventSliver(event: event.data!, image: image.data!,)));} :(){}, 
                                  child: Text(event.hasData? event.data!.name : "", 
                                              style: TextStyle(color: Colors.white),));
                              }
                            ): SizedBox();
                          }
                        ),
                        Text(
                          post.description!,
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          )
                        ),
                      ],
                    ),
                  )
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(
                    child: Icon(Icons.comment),
                    onPressed: (){
                      Future<List<Comment>?>? _comments = _postDatabaseService.getCommentOfPost(post.id) ;
                      showModalBottomSheet(
                        //isScrollControlled: true,
                        context: context, 
                        builder: (context){
                          return Scaffold(
                            backgroundColor: Colors.transparent,
                            //resizeToAvoidBottomInset: true,
                            body: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder(
                                future: _comments!, 
                                builder: (context, comments){
                                  if(comments.hasData){
                                    if(comments.data!.isEmpty){
                                      return SizedBox(width: double.infinity);
                                    } else {
                                      return ListView.builder(
                                        itemCount: comments.data!.length,
                                        itemBuilder: ((context, i){
                                          return CommentBox(comment: comments.data![i]);
                                              
                                        }));
                                    }
                                  } else return SizedBox();
                                }),
                            ),
                          bottomNavigationBar: Padding(
                            padding: EdgeInsets.fromLTRB(12.0, 0, 12.0, MediaQuery.of(context).viewInsets.bottom + 12.0),
                            child: TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.message),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () async {
                                    await _postDatabaseService.uploadComment(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      controller.text, 
                                      post.id);
                                    controller.text ="";
                                    Navigator.pop(context);
                                    },
                                  )
                                ),
                              ),
                            ),
                          );
                        }
                      );
                    }
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}