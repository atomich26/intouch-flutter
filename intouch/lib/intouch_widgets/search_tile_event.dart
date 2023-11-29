import 'package:flutter/material.dart';
import 'package:intouch/services/firebase_storage.dart';

class EventSearchTile extends StatelessWidget {
  EventSearchTile({
    super.key,
    this.id,
    this.address,
    this.city,
    this.cover,
    this.name,
    this.date
    });

  String? id;
  String? address;
  String? city;
  String? cover;
  String? name;
  double? date;

  StorageService _storageService = new StorageService();

  @override
  Widget build(BuildContext context) {
    if(cover != null){
      Future<String>? imageUrl = _storageService.getEventImageUrl(cover!);
      return FutureBuilder(
        future: imageUrl, 
        builder: (context, imageUrl){
          return InkWell(
            splashColor: Colors.purple[500]!.withOpacity(0.1),
            onTap:() {
          
              },
            child: Card(
              elevation: 0.0,
              borderOnForeground: true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, 
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image:DecorationImage(image: imageUrl.hasData? NetworkImage(imageUrl.data!): AssetImage("assets/images/intouch-default.png") as ImageProvider )
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Text(name ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                        Column(
                          children:<Widget>[
                            Text(date.toString()),
                            Text(address! + " " + city!),
                          ],
                        )
                      ],
                    )
                  ]
                ),
              )
            ),
          );
        }
      );
    } else {
      return InkWell(
        child: Card(
              elevation: 0.0,
              borderOnForeground: true,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, 
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image:DecorationImage(image: AssetImage("assets/images/intouch-default.png") as ImageProvider )
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:<Widget> [
                        Text(name ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
                        Column(
                          children:<Widget>[
                            Text(date.toString()),
                            Text(address! + " " + city!),
                          ],
                        )
                      ],
                    )
                  ]
                ),
              )
            )
      );
    }
  }
}