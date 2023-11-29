

import 'dart:collection';

class Post{

  late String id;
  late String userId;
  late String? userImg;
  late String? username;
  late String? eventName;
  late String? eventId;
  late DateTime? createdBy;
  late String? description;
  late List<String>? album;

  Post({

    required this.id,
    required this.userId,
    this.username,
    this.userImg,
    this.eventName,
    this.eventId,
    this.createdBy,
    this.description,
    this.album,
  });

  Post.fromMap(HashMap<String, dynamic> data){
    
    id = data["id"];
    userId = data["userId"];
    username = data["username"];
    userImg = data["userImg"];
    eventId = data["eventId"];
    createdBy = data["createdBy"];
    description = data["description"];
    album = data["album"];

  }

}