import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/profile_circle.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/category.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/screens/home/pages/profile_page.dart';
import 'package:intouch/services/database.dart';
import 'package:intouch/services/google_services.dart';



class EventSliver extends StatefulWidget {
  
  Event event;
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
  final UserDatabaseService _userDatabaseService = UserDatabaseService();
  final GoogleServices _googleServices = GoogleServices();

  @override
  Widget build(BuildContext context) {
    Future<AppUserData>? _user= _userDatabaseService.getUserById(widget.event.userId);
    return FutureBuilder<AppUserData>(
      future: _user,
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
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.purple[50],
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(50),
                                ),
                              ),
                            ),
                            bottom: -1,
                            left: 0,
                            right: 0,)
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
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(fromTheRight(ProfilePage(user: user.data!)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget> [
                            user.hasData? ProfileCircle(user: user.data!, radius: 32.0) : CircleAvatar(
                              radius: 24.0,
                              foregroundColor: Colors.blueAccent,
                            ),
                            SizedBox(width: 8.0),
                            Text(user.hasData? user.data!.username! : "", textScaler: TextScaler.linear(1.4),)
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
                          Icon(Icons.place, size: 20.0,),
                          TextButton(
                            onPressed:()=> _googleServices.launchMapsUrl(widget.event.address + " " + widget.event.city),
                            child: Text(widget.event.address))
                            ],
                          ),
                        SizedBox(height: 12.0),
                        Row(
                          children: <Widget> [
                          Icon(Icons.calendar_month, size: 20.0,),
                          SizedBox(width: 4.0),
                          Text(DateFormat('dd/MM/yyyy HH:mm').format(widget.event.startAt.toDate()), textScaler: TextScaler.linear(1.2))
                            ],
                        ),
                        SizedBox(height: 8.0,),
                        Row(
                          children: <Widget> [
                          Icon(Icons.calendar_month, size: 20.0,),
                          SizedBox(width: 4.0),
                          Text(DateFormat('dd/MM/yyyy HH:mm').format(widget.event.endAt.toDate()), textScaler: TextScaler.linear(1.2))
                            ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Text(widget.event.description == null ? "":widget.event.description!)
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
            floatingActionButton: Container(
              padding:EdgeInsets.all(8.0),
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
    );
  }
}