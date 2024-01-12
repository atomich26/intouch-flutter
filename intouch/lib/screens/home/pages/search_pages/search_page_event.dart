import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/search_tile_event.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/services/cloud_functions.dart';
import 'package:intouch/services/database.dart';

class SearchPageEvent extends StatelessWidget {
  SearchPageEvent({
    super.key,
    required this.query
    });

  String query;
  final EventDatabaseService _eventDatabaseService = EventDatabaseService();

  @override
  Widget build(BuildContext context) {
    Future<List<String>>? eventByName = searchEventByName(query);
    return FutureBuilder(
      future: eventByName,
      builder: (context, events){
        if(events.hasData){
          if(events.data!.isEmpty){
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Nothing here to see, sorry"),
                ],
              )
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: events.data!.length,
                itemBuilder: ((context, i){
                  Future<Event>? eventById = _eventDatabaseService.getEventById(events.data![i]);
                  return FutureBuilder(
                    future: eventById, 
                    builder: (context, events){
                      if(events.hasData){
                        return EventSearchTile(
                          id: events.data?.id,
                          name: events.data?.name,
                          cover: events.data?.cover,
                        );
                      } else {
                        return const Text("");
                      }
                    }
                  );
                })
              ),
            );
          }
        } else {
          return const Center(
          child: Column(children: [
            Text("Loading...")
          ]),
        );
      }
    });
  }
}