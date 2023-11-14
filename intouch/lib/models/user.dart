import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  
  final String uid;
  AppUser ({ required this.uid });

}


class AppUserData{
  
  late final String uid;
  late final String? name;
  late final String? username;
  late final String? email;
  late final double? birthdate;
  late final String? biography;
  late final String? img;
  late final List<String>? friendsRef;
  late final List<String>? eventsRef;
  late final List<String>? preferences;

  AppUserData ({
    required this.uid,
    this.name,
    this.username,
    this.email,
    this.birthdate,
    this.biography,
    this.img,
    this.friendsRef,
    this.eventsRef,
    this.preferences,
    });

    AppUserData.fromMap (Map<String,dynamic> data){
      uid = data[uid];
      name = data[name];
      username = data[username];
      email = data[email];
      birthdate = data[birthdate];
      biography = data[biography];
      img = data[img];
      friendsRef = data[friendsRef];
      eventsRef = data[eventsRef];
      preferences = data[preferences];
    }
      
}