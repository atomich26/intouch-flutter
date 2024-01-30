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

  final String? id;
  final String? address;
  final String? city;
  final String? cover;
  final String? name;
  final String? date;

  final StorageService _storageService = StorageService();
  final EventDatabaseService _eventDatabaseService = EventDatabaseService();

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 32,
                      backgroundImage: imageUrl.hasData? NetworkImage(imageUrl.data!): const AssetImage("assets/images/intouch-default.png") as ImageProvider,
                    ),
                    SizedBox(width:24),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:<Widget> [
                        Text(name!.length>=30?(name ?? "").substring(0, 30)+"..." : name!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Column(
                          children:<Widget>[
                            //Text(date.toString()),
                            Text(address! + " " + city!),
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
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                  children: <Widget>[
                    const CircleAvatar(
                      foregroundColor: Colors.amber,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Text(name?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                        Column(
                          children:<Widget>[
                            Text(date.toString()),
                            Text("${address!} ${city!}"),
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