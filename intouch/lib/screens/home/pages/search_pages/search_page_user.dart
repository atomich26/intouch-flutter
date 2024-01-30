import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/search_tile_user.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/services/cloud_functions.dart';
import 'package:intouch/services/database.dart';

class SearchPageUser extends StatelessWidget {
  
  
  SearchPageUser({
      super.key,
      required this.query
      });
  
  final String query;
  final UserDatabaseService _userDatabaseService = UserDatabaseService();

  @override
  Widget build(BuildContext context) {
    Future<List<String>>? userByName = searchUserByName(query);
    return FutureBuilder(
      future: userByName, 
      builder: (context, users){
        if(users.hasData){
          if(users.data!.isEmpty){
            return const Center(
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
                Future<AppUserData>? userById = _userDatabaseService.getUserById(users.data![i]);
                return FutureBuilder(
                  future: userById,
                  builder: (context, users){
                  if(users.hasData)
                    {
                      return UserSearchTile(
                        context: context,
                        id: users.data?.id,
                        name: users.data?.name,
                        img: users.data?.img,
                        username: users.data?.username,
                        );
                    } else {
                      return const Text("");
                    }
                  } 
                );
              }),
            );
          }
        } else {
          return const Center(
          child: Column(children: [
            Text("Loading...")
          ]),
        );
      }

      });
  }
}