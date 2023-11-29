import 'package:firebase_storage/firebase_storage.dart';

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

}





