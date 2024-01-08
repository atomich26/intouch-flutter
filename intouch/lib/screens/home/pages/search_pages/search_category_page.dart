import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/search_tile_event.dart';
import 'package:intouch/models/category.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/services/database.dart';

class SearchCategoryPage extends StatelessWidget {
  SearchCategoryPage({
    super.key,
    required this.category,
    required this.image});

    
    Category category;
    String image;
    EventDatabaseService _eventDatabaseService = new EventDatabaseService();

  @override
  Widget build(BuildContext context) {
    Future<List<Event>?> eventsByCategory = _eventDatabaseService.getEventsByCategory(category.id);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 200),
        child: AppBar(
          leading: IconButton.filledTonal(
            onPressed: Navigator.of(context).pop, 
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            focusColor: Colors.purple[300]!.withOpacity(0.2),),
          flexibleSpace: Stack(
            alignment: Alignment.bottomLeft,
            children: <Widget> [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover),
                )
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5))
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  category.name,
                  style:TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    
                    )
                  ),
              ),
            ]
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
        child: SafeArea(
              child:
                FutureBuilder(
                future: eventsByCategory, 
                builder: (context, events){
                  if(events.hasData){
                    if(events.data!.isEmpty){
                      return Center(
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
                                if(events.hasData){
                                  return EventSearchTile(
                                    id: events.data![i].id,
                                    name: events.data![i].name,
                                    cover: events.data![i].cover,
                                  );
                                } else {
                                  return const Text("");
                                }     
                          })
                        ),
                      );
                    }
                  } else {
                    return Center(
                    child: Column(children: [
                      Text("Loading...")
                    ]),
                  );
                }
              })
            
          ),
      ),
      
    );
}}