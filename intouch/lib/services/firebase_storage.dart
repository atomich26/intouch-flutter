import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:crypto/crypto.dart';

class StorageService{
  
    final FirebaseStorage storageRef = FirebaseStorage.instance;

    Future<String> getCategoryImageUrl(String reference) async {
      String imageUrl = await storageRef.refFromURL("gs://intouch-c7b87.appspot.com/categories/$reference").getDownloadURL().then((value) =>  value.toString());
      return imageUrl; 
    }

    Future<String> getUserImageUrl(String reference) async {
      String imageUrl = await storageRef.refFromURL("gs://intouch-c7b87.appspot.com/users/$reference").getDownloadURL().then((value) =>  value.toString());
      return imageUrl; 
    }

    Future<String> getEventImageUrl(String reference) async {
      String imageUrl = await storageRef.refFromURL("gs://intouch-c7b87.appspot.com/events/$reference").getDownloadURL().then((value) =>  value.toString());
      return imageUrl; 
    }

    Future<String> getPostImageUrl(String reference) async {
      String imageUrl = await storageRef.refFromURL("gs://intouch-c7b87.appspot.com/posts/$reference").getDownloadURL().then((value) =>  value.toString());
      return imageUrl; 
    }

    void setUserImage (String id, File file) async {
      final hashed = md5.convert(utf8.encode(id));
      final imageRef = storageRef.ref().child("users/${Timestamp.now().millisecondsSinceEpoch}_$hashed");
      try{
        await imageRef.putFile(file);
      } on FirebaseException catch (e) {
        return null;
      }
    }

    Future<String?> setPostImage (String id, File file) async {
      final hashed = md5.convert(utf8.encode(id));
      final imageUrl = "${Timestamp.now().millisecondsSinceEpoch}_$hashed";
      final imageRef = storageRef.ref().child("posts/$imageUrl");
      try{
        await imageRef.putFile(file);
        return imageUrl.toString();
      } on FirebaseException catch (e) {
        return null;
      }
    }

    Future<void> deleteEventImage(String id) async {
      final imageRef = storageRef.ref("events/$id");
      try{
        await imageRef.delete();
        print ("Image Deleted");
      } on FirebaseException catch (e) {
        print(e);
      }
    }

    Future<String> setEventImage (String id, File file) async {
      final hashed = md5.convert(utf8.encode(id));
      final imageUrl = "${Timestamp.now().millisecondsSinceEpoch}_$hashed";
      final imageRef = storageRef.ref().child("events/$imageUrl");
      try{
        await imageRef.putFile(file);
        return imageUrl.toString();
      } on FirebaseException catch (e) {
        return "error";
      }
    }

}





