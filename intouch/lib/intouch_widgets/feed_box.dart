import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/screens/home/pages/event_sliver.dart';
import 'package:intouch/services/database.dart';

import '../services/firebase_storage.dart';

class FeedBox extends StatefulWidget {
  
  BuildContext context;
  Event event;

  FeedBox({
    super.key,
    required this.context,
    required this.event});

  @override
  State<FeedBox> createState() => _FeedBoxState();
}

class _FeedBoxState extends State<FeedBox> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final StorageService _storageRef = StorageService();
  final UserDatabaseService _userDatabaseService =UserDatabaseService();


  @override
  Widget build(BuildContext context) {
    super.build(context);
    Future<String>? imageUrl = _storageRef.getEventImageUrl(widget.event.cover);
    Future<String> userId = _userDatabaseService.getUserById(widget.event.userId).then((value) => value.name!);
    return FutureBuilder(
      future: Future.wait([imageUrl, userId]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
        print(snapshot.data?[1]);
        return GestureDetector(
          onTap:() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => EventSliver(event: widget.event, image: snapshot.data![0])));
            },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:6.0, horizontal: 12.0),
              child: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.purple[50],
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                Expanded(
                  flex: 7,
                  child:Hero(
                    tag: 'eventImage${widget.event.name}',
                    child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: snapshot.hasData? NetworkImage(snapshot.data![0]) :  const AssetImage("assets/images/intouch-default.png") as ImageProvider,
                                  fit: BoxFit.cover,)
                        )
                      ),
                  )
                  ),
                Expanded(
                  flex:3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.event.name,
                          
                          maxLines: 1,
                          style:const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis)
                          ),
                        Text(snapshot.hasData? snapshot.data![1] : ""),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            Row(
                              children: <Widget> [
                                const Icon(Icons.place, size: 18.0,),
                                Text(widget.event.city, overflow: TextOverflow.ellipsis,)
                              ], 
                            ),
                            //PORCO DIEGO
                             Row(
                              children: <Widget> [
                                const Icon(Icons.calendar_month, size: 18.0,),
                                Text(DateFormat('dd/MM/yyyy HH:mm').format(widget.event.startAt.toDate()))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                )
              ]
            ),
          )
        ),
        );
      }
      
    );
  }
}