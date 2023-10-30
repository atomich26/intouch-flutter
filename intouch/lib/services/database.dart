import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService{

  final String uid;

  UserDatabaseService ({required this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

 // Future updateUserData(String)

}