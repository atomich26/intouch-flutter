import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/screens/home/pages/profile.dart';
import 'package:intouch/screens/home/pages/profile_page.dart';
import 'package:intouch/services/database.dart';
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
  UserDatabaseService _userDatabaseService = UserDatabaseService();

  

  @override
  Widget build(context) {
  Future<AppUserData>? user = _userDatabaseService.getUserById(id!);  
  Future<String>? imageUrl = _storageService.getUserImageUrl(img ?? "intouch-default-user.png");
     
    return FutureBuilder(
      future: Future.wait([user, imageUrl]), 
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
      return InkWell(
        splashColor: Colors.purple[500]!.withOpacity(0.1),
        onTap:() {
          snapshot.hasData? Navigator.of(context).push(fromTheRight(ProfilePage(user: snapshot.data![0]))): null;
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
                    foregroundImage: snapshot.hasData? NetworkImage(snapshot.data![1]) : AssetImage("assets/images/intouch-default-user.png") as ImageProvider,
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
              ]
            ),
          ) ,
          ),
      );
      }
    );
  
    
  }
}