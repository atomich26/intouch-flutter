import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/models/category.dart';



class EventSliver extends StatefulWidget {
  
  Category event;
  String image;

  EventSliver({
    super.key,
    required this.event,
    required this.image});

  @override
  State<EventSliver> createState() => _EventSliverState();
}

class _EventSliverState extends State<EventSliver> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 0.0,
          backgroundColor: Colors.purple[50],
          ),
        backgroundColor: Colors.purple[50],
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              //stretch: true,
              floating: true,
              snap:true,
              //pinned: true,
              leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.5)
                    ),
                    child: IconButton.filled(
                      onPressed: Navigator.of(context).pop, 
                      icon: const Icon(Icons.arrow_back_outlined), 
                      color: Colors.white,
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.black.withOpacity(0.8))),
                        
                        ),
                    ),
                  ),
              expandedHeight: 300.0,
              elevation: 0.0,
              backgroundColor: Colors.purple[50],
              flexibleSpace: Stack(
                children: <Widget> [
                      Hero(
                      tag: 'eventImage${widget.event.name}', 
                      child: 
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.image),
                                //image: AssetImage("assets/images/${widget.event.name}.png"),
                                fit: BoxFit.cover,
                                alignment: Alignment.center)
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
          SliverList.list(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.event.name,
                  textAlign: TextAlign.left,
                  textScaler: const TextScaler.linear(2.5),
                  style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [
                      CircleAvatar(
                        radius: 24.0,
                        foregroundColor: Colors.blueAccent,
                      ),
                      SizedBox( width: 8.0),
                      Text('Some Stupid Fool')
                    ],
                  )
                
              ),
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
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(dummy),
                        Text(dummy),
                        Text(dummy),
                        Text(dummy),
                        Text(dummy),
                      ],
                    ),
                  ),
                ],
              ), 
              
            ]
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          color: Colors.purple[50],
          child: InTouchLongButton(
                                  context, 
                                  isSelected? "I'll Pass": "I'll be there!", 
                                  null, 
                                  isSelected? false: true, 
                                  () {
                                    setState(() {
                                      isSelected = !isSelected;
                                    });
                                  }),
        ),
    );
  }
}

String dummy= "As the twilight dwindle on the horizon, the words of the girl still bore in the mind of the pastor. The world has become a mess of quantities and metrics that can measure anything now: fame, fortune, goals, success, worth of life past present and future. As if humanity could be measured in the atoms that is composed and how they are used to move other atoms from one bond to the next. A bond that could be measured in Anstrong: more than billions times smaller than the dot who closes a spare thought in his diary. Is there, hidden behind those microscopical exchange of energies, a soul one can call their own? Are they just a mass of atoms. 350€ is the price of it.";