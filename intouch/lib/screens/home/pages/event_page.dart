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
      body: Stack(
        children: [
          Column(
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
                        child: Image(
                          image: NetworkImage(widget.image),))
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
                                Text(dummy),
                                  
                                  
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
        Positioned(
            top: 0.0,
            right: 0.0,
            left: 0.0,
            child: AppBar(
              backgroundColor: Colors.transparent, 
              elevation:0.0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.7)
                  ),
                  child: IconButton.filled(
                    onPressed: Navigator.of(context).pop, 
                    icon: Icon(Icons.arrow_back_outlined), 
                    color: Colors.white,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black.withOpacity(0.8))),
                      
                      ),
                  ),
                ),
              ),
          ),],
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
                              }),
                              );
  }
}


String dummy= "As the twilight dwindle on the horizon, the words of the girl still bore in the mind of the pastor. The world has become a mess of quantities and metrics that can measure anything now: fame, fortune, goals, success, worth of life past present and future. As if humanity could be measured in the atoms that is composed and how they are used to move other atoms from one bond to the next. A bond that could be measured in Anstrong: more than billions times smaller than the dot who closes a spare thought in his diary. Is there, hidden behind those microscopical exchange of energies, a soul one can call their own? Are they just a mass of atoms. 350€ is the price of it.";