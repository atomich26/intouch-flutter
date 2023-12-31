import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/screens/home/pages/event_sliver.dart';
import 'package:intouch/services/database.dart';
import 'package:intouch/services/firebase_storage.dart';

class EventSearchTile extends StatelessWidget {
  EventSearchTile({
    super.key,
    this.id,
    this.address,
    this.city,
    this.cover,
    this.name,
    this.date
    });

  String? id;
  String? address;
  String? city;
  String? cover;
  String? name;
  String? date;

  StorageService _storageService = new StorageService();
  EventDatabaseService _eventDatabaseService = EventDatabaseService();

  @override
  Widget build(BuildContext context) {
    Future<Event>? event = _eventDatabaseService.getEventById(id!);
    return FutureBuilder(
      future: event, 
      builder: (context, event){
      if(cover != null){
      Future<String>? imageUrl = _storageService.getEventImageUrl(cover!);
      return FutureBuilder(
        future: imageUrl, 
        builder: (context, imageUrl){
          return InkWell(
            splashColor: Colors.purple[500]!.withOpacity(0.1),
            onTap:() {
              Navigator.of(context).push(fromTheBottom(EventSliver(event: event.data!, image: imageUrl.data!)));
          
              },
            child: Card(
              color: Colors.transparent,
              elevation: 0.0,
              //borderOnForeground: true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  children: <Widget>[
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: imageUrl.hasData? NetworkImage(imageUrl.data!): AssetImage("assets/images/intouch-default.png") as ImageProvider,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Text(name ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                        Column(
                          children:<Widget>[
                            Text(date.toString()),
                            //Text(address! + " " + city!),
                          ],
                        )
                      ],
                    )
                  ]
                ),
              )
            ),
          );
        }
      );
    } else {
      return InkWell(
        child: Card(
              elevation: 0.0,
              borderOnForeground: true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  children: <Widget>[
                    CircleAvatar(
                      foregroundColor: Colors.amber,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Text(name ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                        Column(
                          children:<Widget>[
                            Text(date.toString()),
                            Text(address! + " " + city!),
                          ],
                        )
                      ],
                    )
                  ]
                ),
              )
            )
      );
    }
    });
  }
}