import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intouch/models/comment.dart';

class Post{

  late String id;
  late String? userId;
  late String? eventId;
  late String? description;
  late List<dynamic>? album;
  late List<Comment>? comments;
  late Timestamp? createdAt;

  Post({

    required this.id,
    this.userId,
    this.eventId,
    this.description,
    this.album,
    this.comments,
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
      comments : data["comments"],
      createdAt : data["createdAt"],
    );
  }

}