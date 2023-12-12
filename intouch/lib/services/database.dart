import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intouch/models/category.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/models/user.dart';

class UserDatabaseService{


  UserDatabaseService ();

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference categoryReference = FirebaseFirestore.instance.collection('categories');
  final CollectionReference eventsReference = FirebaseFirestore.instance.collection('events');


  Future<String?> getUserNameById (String id) async {
    var value = await userCollection.where('id', isEqualTo: id).get().then((value) => {
       value.docs.map((doc){
        final casted = doc.data() as HashMap<String, dynamic>;
        final user = AppUserData.fromJson(casted);
        print(user.name);
        return user.name;

       })
      }
    );
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
}

class PostDatabaseService{

  PostDatabaseService();

  final CollectionReference postCollection = FirebaseFirestore.instance.collection('posts');

  //Future<Post> getPostbyId(){ return}
}


  

 // Future updateUserData(String)

