import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/models/category.dart';

import '../../../services/firebase_storage.dart';

class EventPage extends StatefulWidget {
  
  Category event;
  String image;
  

  EventPage({
    super.key,
    required this.event,
    required this.image});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget> [
              Hero(
                tag: 'eventImage${widget.event.name}', 
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(28.0)),
                  ),
                child: Image(image: NetworkImage(widget.image),))
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.event.name,
                        textAlign: TextAlign.left,
                        textScaleFactor: 2.5,
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 24.0,
                                foregroundColor: Colors.blueAccent,
                              ),
                              SizedBox( width: 8.0),
                              Text('Some Stupid Fool')
                            ],
                          ),
                        SizedBox(height: 16.0),
                        Column(
                          children:[
                              Row(
                                children: <Widget> [
                                  Icon(Icons.place, size: 28.0,),
                                  Text("Somewhere far far away", textScaleFactor: 1.4)
                                ],
                              ),
                            SizedBox(height: 12.0),
                            Row(
                              children: <Widget> [
                                Icon(Icons.calendar_month, size: 28.0,),
                                Text("01/01/00 20:30", textScaleFactor: 1.4)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(dummy),
                            ),  
                          ],
                        ),
                      ],
                    ),
                  ), 
                ],
              ),
              )
          ],
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InTouchLongButton(
                              context, 
                              isSelected? "I'll Pass": "I'll be there!", 
                              null, 
                              isSelected? false: true, 
                              () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              }),);
  }
}


String dummy= "In our definition of deterministic automaton, the initial state is a single state, all transitions have event labels e ∈ E, and the transition function is deterministic in the sense that if event e ∈ Γ(x), then e causes a transition from x to a unique state y=f (x, e). For modeling and analysis purposes, it becomes necessary to relax these three requirements. ";