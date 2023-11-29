import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/search_tile_user.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/services/cloud_functions.dart';

class SearchPageUser extends StatelessWidget {
  
  
  SearchPageUser({
      super.key,
      required this.query
      });
  
  String query;

  @override
  Widget build(BuildContext context) {
    Future<List<AppUserData>>? userByName = searchUserByName(query);
    return FutureBuilder(
      future: userByName, 
      builder: (context, users){
        if(users.hasData){
          if(users.data!.isEmpty){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start ,
                children: <Widget> [
                  Text("Nothing here to see, sorry"),
                    ]
                  ),
                );
          } else {
            return ListView.builder(
              itemCount: users.data!.length,
              itemBuilder: ((context, i){
                return UserSearchTile(
                  context: context,
                  id: users.data?[i].id,
                  name: users.data?[i].name,
                  img: users.data?[i].img,
                  username: users.data?[i].username,
                );
              }),
            );
          }
        } else {
          return Center(
          child: Column(children: [
            Text("Loading...")
          ]),
        );
      }

      });
  }
}