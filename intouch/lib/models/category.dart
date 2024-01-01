import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Category{
  late String id;
  late String name;
  late String cover;
  
  Category ({
    required this.id,
    required this.name,
    required this.cover
  });

  factory Category.fromFirestore(DocumentSnapshot snapshot, SnapshotOptions? options){
    final data = snapshot.data() as Map<String,dynamic>;
    return Category(
      id: snapshot.id, 
      name: data['name'], 
      cover: data['cover']);
  }

  Map<String, dynamic> toFirestore(){
    return{
      "name": name,
    };
  }
}