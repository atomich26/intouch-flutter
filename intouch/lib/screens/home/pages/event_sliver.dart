import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/profile_circle.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/screens/home/pages/post_form.dart';
import 'package:intouch/screens/home/pages/profile_page.dart';
import 'package:intouch/services/database.dart';
import 'package:intouch/services/google_services.dart';



class EventSliver extends StatefulWidget {
  
  final Event event;
  final String image;

  EventSliver({
    super.key,
    required this.event,
    required this.image});

  @override
  State<EventSliver> createState() => _EventSliverState();
}

class _EventSliverState extends State<EventSliver> {
  
  final UserDatabaseService _userDatabaseService = UserDatabaseService();
  final EventDatabaseService _eventDatabaseService = EventDatabaseService();
  final GoogleServices _googleServices = GoogleServices();
  //late final Future<dynamic> _attendees;

  bool _isSelected = false;
  @override
  void initState(){
    //_attendees = FirebaseFirestore.instance.collection('events').doc(widget.event.id).collection('attendees').snapshots().first.then((value) => value.docs.first.get('users'));
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    Future<AppUserData>? user= _userDatabaseService.getUserById(widget.event.userId);
    Future<dynamic> _attendees = FirebaseFirestore.instance.collection('events').doc(widget.event.id).collection('attendees').snapshots().first.then((value) => value.docs.first.get('users'));
    
  
    return FutureBuilder<AppUserData>(
      future: user,
      builder: (context, user) {
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
                  stretch: true,
                  //floating: true,
                  //snap:true,
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
                            ),
                          Positioned(
                            bottom: -1,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.purple[50],
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(50),
                                ),
                              ),
                            ),)
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28
                        ),
                      ),
                    ),
                  const SizedBox(height: 8.0),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(fromTheRight(ProfilePage(user: user.data!)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget> [
                            user.hasData? ProfileCircle(user: user.data!, radius: 32.0) : const CircleAvatar(
                              radius: 24.0,
                              foregroundColor: Colors.blueAccent,
                            ),
                            const SizedBox(width: 8.0),
                            Text(user.hasData? user.data!.username! : "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                          ],
                        )
                      
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children:[
                        Row(
                          children: <Widget> [
                          const Icon(Icons.place, size: 20.0,),
                          TextButton(
                            onPressed:()=> _googleServices.launchMapsUrl("${widget.event.address} ${widget.event.city}"),
                            child: Text(widget.event.address))
                            ],
                          ),
                        const SizedBox(height: 12.0),
                        Row(
                          children: <Widget> [
                          const Icon(Icons.calendar_month, size: 20.0,),
                          const SizedBox(width: 4.0),
                          Text(DateFormat('dd/MM/yyyy HH:mm').format(widget.event.startAt.toDate()), textScaler: const TextScaler.linear(1.2))
                            ],
                        ),
                        const SizedBox(height: 8.0,),
                        widget.event.endAt == null? SizedBox.shrink() :
                        Row(
                          children: <Widget> [
                          const Icon(Icons.calendar_month, size: 20.0,),
                          const SizedBox(width: 4.0),
                          Text(DateFormat('dd/MM/yyyy HH:mm').format(widget.event.endAt!.toDate()), textScaler: const TextScaler.linear(1.2))
                            ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 60.0),
                          child: Column(
                            children: [
                              Text(widget.event.description == null ? "":widget.event.description!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),   
                ]
              )
            ],
          ),
          
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton:
            widget.event.startAt.toDate().isAfter(DateTime.now())?
            
            FutureBuilder<dynamic>(
              future: _attendees,
              builder: (context, attendees) {
                return !attendees.hasData ? 
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.purple[50],
                  child: InTouchLongButton(
                    context, "Connectivity issues", null, false, (){}),
                ) :
                  Container(
                  padding:const EdgeInsets.all(8.0),
                  color: Colors.purple[50],
                  child: InTouchLongButton(
                    context, 
                    !attendees.data!.contains(FirebaseAuth.instance.currentUser!.uid)? "I'll pass" : "I'll be there",
                    null, 
                    !attendees.data!.contains(FirebaseAuth.instance.currentUser!.uid) ? false: true, 
                    ()async{
                        {
                        bool confirm = attendees.data!.contains(FirebaseAuth.instance.currentUser!.uid);
                        var data = <String, dynamic> {
                          'join' : confirm,
                          'eventId' : widget.event.id,
                          //'userId' : FirebaseAuth.instance.currentUser!.uid,
                        };
                        await FirebaseFunctions.instance.httpsCallable('events-join').call(data).then(
                          (value){
                            setState(() {
                              _attendees = FirebaseFirestore.instance.collection('events').doc(widget.event.id).collection('attendees').snapshots().first.then((value) => value.docs.first.get('users'));
                            });
                          }
                        );}
                            
                         
                      }),
                );
              }
            ) : 
            Container(
              padding:const EdgeInsets.all(8.0),
              color: Colors.purple[50],
              child: InTouchLongButton(
                context, 
                "Add Post", 
                null, 
                true, 
                () {
                  setState(() {
                    Navigator.of(context).push(fromTheRight(PostForm(event: widget.event)));
                    });
                  }),
            ),
        );
      }
    );
  }
}