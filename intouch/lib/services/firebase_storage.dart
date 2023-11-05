import 'package:firebase_storage/firebase_storage.dart';

class StorageService{
  
    final FirebaseStorage storageRef = FirebaseStorage.instance;

    Future<String> getImageUrl(String reference) async {
      String ImageUrl = await storageRef.refFromURL("gs://intouch-c7b87.appspot.com/categories/${reference}").getDownloadURL().then((value) =>  value.toString());
      return ImageUrl;}
}





