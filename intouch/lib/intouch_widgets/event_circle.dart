import 'package:flutter/material.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/services/firebase_storage.dart';

class EventCircle extends StatelessWidget {
  
  final Event? event;
  final double size;
  
  EventCircle({
    super.key,
    this.event,
    required this.size});

  final StorageService _storage = StorageService();

  @override
  Widget build(BuildContext context) {
    if(event!.cover.isEmpty){
        return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          image: DecorationImage(image: AssetImage("assets/images/intouch-default.png"),)
        ),
      );
    } else {
      Future<String>? imageUrl = _storage.getEventImageUrl(event!.cover);
        return FutureBuilder(
          future: imageUrl, 
          builder: (context, imageUrl){
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                image: DecorationImage(image: imageUrl.hasData? NetworkImage(imageUrl.data!): const AssetImage("assets/images/intouch-default.png") as ImageProvider )
              ),
            );
          });
    }
    
  }
}