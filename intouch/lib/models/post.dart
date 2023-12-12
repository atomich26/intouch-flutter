

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  late String id;
  late String? userId;
  late String? userImg;
  late String? username;
  late String? eventName;
  late String? eventId;
  late DateTime? createdBy;
  late String? description;
  late List<String>? album;
  late bool? viewed;
  late Timestamp? createdAt;

  Post({

    required this.id,
    this.userId,
    this.username,
    this.userImg,
    this.eventName,
    this.eventId,
    this.createdBy,
    this.description,
    this.album,
    this.viewed,
    this.createdAt
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
    viewed = data["viewed"];
    createdAt = data["createdAt"];

  }

}