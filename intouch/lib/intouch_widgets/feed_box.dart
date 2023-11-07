import 'package:flutter/material.dart';
import 'package:intouch/models/event.dart';
import '../models/category.dart';
import '../screens/home/pages/event_page.dart';
import '../services/firebase_storage.dart';

class FeedBox extends StatefulWidget {
  
  BuildContext context;
  Category category;

  FeedBox({
    super.key,
    required this.context,
    required this.category});

  @override
  State<FeedBox> createState() => _FeedBoxState();
}

class _FeedBoxState extends State<FeedBox> with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final StorageService _storageRef = StorageService();


  @override
  Widget build(BuildContext context) {
    String city = "Civitanova Marche";
    super.build(context);
    Future<String>? imageUrl = _storageRef.getImageUrl(widget.category.cover);
    return FutureBuilder(
      future: imageUrl,
      builder: (context, imageUrl){
        
        return GestureDetector(
          onTap:() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => EventPage(event: widget.category, image: imageUrl.data! )));
            
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical:6.0, horizontal: 12.0),
              child: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.purple[50],
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                Expanded(
                  flex: 3,
                  child:Hero(
                    tag: 'eventImage${widget.category.name}',
                    child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: imageUrl.hasData? NetworkImage(imageUrl.data!) : const AssetImage("assets/images/intouch-default.png") as ImageProvider,
                                  fit: BoxFit.cover,)
                        )
                      ),
                  )
                  ),
                Expanded(
                  flex:1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.category.name,
                          textScaleFactor: 1.7, 
                          style:TextStyle(fontWeight: FontWeight.bold)),
                        Text("By some random"),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            Row(
                              children: <Widget> [
                                Icon(Icons.place, size: 18.0,),
                                Text(city.length>= 25 ? city.substring(0,23)+"..." : city)
                              ], 
                            ),
                            //PORCO DIEGO
                            Row(
                              children: <Widget> [
                                Icon(Icons.calendar_month, size: 18.0,),
                                Text("01/01/00 20:30")
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