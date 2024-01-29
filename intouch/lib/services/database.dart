import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intouch/models/category.dart';
import 'package:intouch/models/comment.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/services/firebase_storage.dart';

class UserDatabaseService{


  UserDatabaseService ();

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  //final CollectionReference categoryReference = FirebaseFirestore.instance.collection('categories');
  //final CollectionReference eventsReference = FirebaseFirestore.instance.collection('events');


  Future<String>? getUserNameById (String id) async {
    
       await userCollection.where('id', isEqualTo: id).get().then((value) => {
       value.docs.map((doc){
        final casted = doc.data() as HashMap<String, dynamic>;
        final user = AppUserData.fromJson(casted);
        return user.name;

       })
      }
    );
    return "Unknown";
    
  }
  
  Future<AppUserData> getUserById (String id) async {
  var value = await userCollection.doc(id).get();
  return AppUserData.fromFirestore(value);
  }
}



class CategoryDatabaseService{

  CategoryDatabaseService();

  final CollectionReference categoryCollection = FirebaseFirestore.instance.collection('categories');

  Future<List<Category>> getCategoriesFirestore() async {
    return categoryCollection.orderBy("name").get().then((values){
     return values.docs.map((e) => Category.fromFirestore(e, null)).toList();
    });
  }

  Future<Category> getCategorybyId (String id)async{
    var value = await categoryCollection.doc(id).get();
    return Category(id: id, name: value['name'], cover: value['cover']);
  }
}

class PostDatabaseService{

  StorageService storage = StorageService();

  PostDatabaseService();

  final CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');

  Future<Post> getPostById(String id) async {
    var value = await postCollection.doc(id).get();
    return Post.fromFirestore(value, null);
  }

  Future<List<Post>?>? getPostByAuthorId(String authorId) async {
    return postCollection.where('userId', isEqualTo: authorId).orderBy("createdAt").get().then((values){
      return values.docs.map((e) => Post.fromFirestore(e, null)).toList();
    });
  }

  Future<List<Comment>?>? getCommentOfPost(String id) async {
    var value = await postCollection.doc(id).collection("comments").orderBy("createdAt").get();
    return value.docs.map((e)=>Comment.fromFirestore(e, null)).toList();
  }

  Future<void> uploadComment(String userId, String comment, String postId) async {
    var data = <String, dynamic> {
      "userId" : userId,
      "content" : comment,
      "createdAt" : Timestamp.now()
    };
    await postCollection.doc(postId).collection("comments").add(data);
  }

  Future<void> uploadPost (String userId, String eventId, String description, List<File>? files) async {
    List<String?> filesNames = [];
    for(File e in files!){
      filesNames.add(await storage.setPostImage(userId, e));
    }
    var data = <String,dynamic> {
      "userId" : userId,
      "eventId" : eventId,
      "description" : description,
      "album" : filesNames,
      "createdAt" : Timestamp.now()
    };
    await postCollection.add(data);

    
  }

}

class EventDatabaseService{

  EventDatabaseService();

  final CollectionReference eventCollection = FirebaseFirestore.instance.collection('events');

  Future<List<Event>> getEventsFirestore(AppUserData userData) async {
    return userData.preferences!.isNotEmpty?
    eventCollection
      .where("startAt", isGreaterThan:Timestamp.now())
      .where("categoryId", whereIn:userData.preferences!)
      //.where("userId", isNotEqualTo: userData.id!)
      .orderBy("startAt", descending: false).get().then((values){
      return values.docs.map((e) => Event.fromFirestore(e, null)).toList();
    })  :
    eventCollection.orderBy("startAt", descending: false).get().then((values){
      return values.docs.map((e) => Event.fromFirestore(e, null)).toList();
  });
  }
  Future<Event> getEventById(String id) async {
    var value = await eventCollection.doc(id).get();
    return Event.fromFirestore(value, null);
  }

  Future<List<Event>?> getEventsByCategory(String category) async {
    return eventCollection.where('categoryId',isEqualTo: category).get().then((value){
      return value.docs.map((e) => Event.fromFirestore(e, null)).toList();
    });
  }

  

}


  

 // Future updateUserData(String)

