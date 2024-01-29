import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/search_tile_event.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/services/database.dart';

class EventsListPage extends StatelessWidget {
  
  List<dynamic>eventId;
  final EventDatabaseService _eventDatabaseService = EventDatabaseService();
  
  EventsListPage({
    super.key,
    required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, i ){
            Future<Event>? eventById = _eventDatabaseService.getEventById(eventId[i].toString());
            return FutureBuilder(
              future: eventById, 
              builder: (context, events){
                if (events.hasData){
                  return EventSearchTile(
                    id:events.data?.id,
                    name: events.data?.name,
                    cover: events.data?.cover,
                    address: events.data?.address,
                    city: events.data?.city,
                    
                  );
                  } else {
                    return const SizedBox.shrink();
                  }
                });
                
              },
              itemCount: eventId.length,)
            )
          );}
  }
