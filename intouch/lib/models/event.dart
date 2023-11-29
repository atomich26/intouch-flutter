import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class Event{

  late String id;
  late String address;
  late String city;
  late String cover;
  late String createdBy;
  late double date;
  late String? description;
  late String name;
  late GeoPoint place;
  late bool restricted;

  Event({
    required this.id,
    required this.address,
    required this.city,
    required this.cover,
    required this.createdBy,
    required this.date,
    this.description,
    required this.name,
    required this.place,
    required this.restricted

  });

  Event.fromMap(HashMap<String, dynamic> data){
    
    id = data[id];
    address = data[address];
    city = data[city];
    cover = data[cover];
    createdBy = data[createdBy];
    date = data[date];
    description = data[description];
    name = data[name];
    place = data[place];
    restricted = data[restricted];

  }
}