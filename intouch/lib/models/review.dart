

import 'dart:collection';

class Review {
  
  late String id;
  late String authorId;
  late DateTime createdAt;
  late bool liked;
  late String comment;

  Review({
    required this.id,
    required this.authorId,
    required this.createdAt,
    required this.liked,
    required this.comment
  });

  Review.fromMap(HashMap<String, dynamic> data){
    
    id = data[id];
    authorId = data[authorId];
    createdAt = data[createdAt];
    liked = data[liked];
    comment = data[comment];

  }

}