import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  late String id;
  late String? content;
  late Timestamp? createdAt;
  late String? userId;

  Comment({
    required this.id,
    this.content,
    this.createdAt,
    this.userId
  });

  factory Comment.fromFirestore(DocumentSnapshot snapshot, SnapshotOptions? options){
    final data = snapshot.data() as Map<String,dynamic>;
    return Comment(
      id: snapshot.id,
      content: data["content"],
      createdAt: data["createdAt"],
      userId: data["userId"]
    );
  }
}