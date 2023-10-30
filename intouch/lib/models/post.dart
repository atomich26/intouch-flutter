

import 'dart:collection';

class Post{

  late String id;
  late String authorId;
  late String eventId;
  late DateTime createdAt;
  late String? description;
  late List<String?>? album;

  Post({
    required this.id,
    required this.authorId,
    required this.eventId,
    required this.createdAt,
    this.description,
    this.album,
  });

  Post.fromMap(HashMap<String, dynamic> data){
    
    id = data[id];
    authorId = data[authorId];
    eventId = data[eventId];
    createdAt = data[createdAt];
    description = data[description];
    album = data[album];

  }

}