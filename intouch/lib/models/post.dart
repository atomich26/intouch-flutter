

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  late String id;
  late String? userId;
  late String? eventId;
  late String? description;
  late List<dynamic>? album;
  late Timestamp? createdAt;

  Post({

    required this.id,
    this.userId,
    this.eventId,
    this.description,
    this.album,
    this.createdAt
  });

  factory  Post.fromFirestore(DocumentSnapshot snapshot, SnapshotOptions? options){
    final data =snapshot.data() as Map<String,dynamic>;
    return Post(
      id : snapshot.id,
      userId : data["userId"],
      eventId : data["eventId"],
      description : data["description"],
      album : data["album"],
      createdAt : data["createdAt"],
    );
  }

}