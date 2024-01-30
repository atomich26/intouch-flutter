import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Event{

  late String id;
  late String address;
  late String city;
  late String cover;
  late String userId;
  late Timestamp startAt;
  late Timestamp? endAt;
  late String? description;
  late String name;
  late GeoPoint? place;
  late bool restricted;
  late List<String> attendees;

  Event({
    required this.id,
    required this.address,
    required this.city,
    required this.cover,
    required this.userId,
    required this.startAt,
    this.endAt,
    this.description,
    required this.name,
    this.place,
    required this.restricted,
    required this.attendees

  });

  Event.fromMap(HashMap<String, dynamic> data){
    
    id = data[id];
    address = data[address];
    city = data[city];
    cover = data[cover];
    userId = data[userId];
    startAt = data[startAt];
    endAt = data[endAt];
    description = data[description];
    name = data[name];
    place = data[place];
    restricted = data[restricted];

  }

  factory Event.fromFirestore(DocumentSnapshot snapshot, SnapshotOptions? options){
    final data = snapshot.data() as Map<String,dynamic>;
    return Event(
      id: snapshot.id,
      address : data['address'],
      city : data['city'],
      cover : data['cover'],
      userId : data['userId'],
      startAt : data['startAt'],
      endAt : data['endAt'],
      description : data['description'],
      name : data['name'],
      place : data['place'],
      restricted : data['restricted'],
      attendees: data['attendees']);
  }
}