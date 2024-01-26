import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intouch/models/post.dart';

class AppUser{
  
  final String id;
  AppUser ({ required this.id });

}


class AppUserData{
  
  late String? id;
  late String? name;
  late String? username;
  late String? email;
  late Timestamp? birthdate;
  late String? biography;
  late String? img;
  late List<dynamic>? friends;
  late List<dynamic>? joined;
  late List<dynamic>? created;
  late List<String>? preferences;
  late List<Post>? posts;

  AppUserData ({
    this.id,
    this.name,
    this.username,
    this.email,
    this.birthdate,
    this.biography,
    this.img,
    this.friends,
    this.joined,
    this.created,
    this.preferences,
    this.posts,
    });

    AppUserData.fromJson (Map<String,dynamic> data){
      id = data['id'];
      name = data['name'] ?? 'Unknown';
      username = data['username'] ?? 'Unknown';
      email = data['email'] ?? 'Unknown';
      birthdate = data['birthdate'];
      biography = data['biography'] ?? 'this user hasn\'t written a bio yet';
      img = data['img'] ?? 'intouch-default.png';
      friends = data['friends'] ?? 0;
      joined = data['joined'] ?? 0;
      created = data['created'] ?? 0;
      //preferences = data['preferences'];
      posts = data['posts'] ?? 0;
    }

      factory  AppUserData.fromFirestore (DocumentSnapshot snapshot){
      final data = snapshot.data() as Map<String,dynamic>;
      return AppUserData(
        id :snapshot.id,
        name :data['name'] ?? 'Unknown',
        username : data['username'] ?? 'Unknown',
        email :data['email'] ?? 'Unknown',
        birthdate : data['birthdate'],
        biography : data['biography'] ?? 'this user hasn\'t written a bio yet',
        img : data['img'] ?? 'intouch-default.png',
        friends : data['friends'] ?? List.empty(),
        joined : data['joined'] ?? List.empty(),
        created : data['created'] ?? List.empty(),
        //preferences = data['preferences'],
        posts : data['posts'] ?? List.empty(),);
    }
      
      
}