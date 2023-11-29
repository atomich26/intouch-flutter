import 'package:flutter/material.dart';
import 'package:intouch/services/firebase_storage.dart';

class UserSearchTile extends StatelessWidget {
  UserSearchTile({
    super.key,
    this.context,
    this.id,
    this.name,
    this.img,
    this.username});

  BuildContext? context;
  String? id;
  String? name;
  String? img;
  String? username;

  StorageService _storageService = new StorageService();


  @override
  Widget build(context) {
    
  if(img != null){
    Future<String>? imageUrl = _storageService.getUserImageUrl(img!);
    return FutureBuilder(
      future: imageUrl, 
      builder: (context, imageUrl){
      return InkWell(
        splashColor: Colors.purple[500]!.withOpacity(0.1),
        onTap:() {
          
        },
        child: Card(
          elevation: 0.0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 36,
                    foregroundImage: imageUrl.hasData? NetworkImage(imageUrl.data!) : AssetImage("assets/images/intouch-default.png") as ImageProvider,
                  ),
                ),
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                      username ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),
                      ),
                  Text(
                      name ?? ""
                    )
                  ],
                )
              ]),
          ) ,
          ),
      );
      }
    );}
    else {
      return InkWell(
        splashColor: Colors.purple[500]!.withOpacity(0.1),
        onTap:(){},
        child: Card(
        elevation: 0.0,
        borderOnForeground: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 36,
                  foregroundImage: AssetImage("assets/images/intouch-default.png") as ImageProvider,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                      username ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0),
                      ),
                  Text(
                      name ?? ""
                    )
                  ],
                )
              ]
            ),
          ),
        ),
      );
      }
  }
}