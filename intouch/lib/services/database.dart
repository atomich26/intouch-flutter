import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intouch/models/user.dart';

class UserDatabaseService{


  UserDatabaseService ();

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');


  Future<String?> getUserNameById (String id) async {
    await userCollection.where('id', isEqualTo: id).get().then((value) => {
       value.docs.map((doc){
        final casted = doc.data() as HashMap<String, dynamic>;
        final user = AppUserData.fromJson(casted);
        print(user.name);
        return user.name;

       })
      }
    );
  }
}



  

 // Future updateUserData(String)

