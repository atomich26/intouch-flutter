import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/search_tile_user.dart';
import 'package:intouch/models/user.dart';

import 'package:intouch/services/database.dart';

class FriendsListPage extends StatelessWidget {
  
  List<dynamic> friendId;
  final UserDatabaseService _userDatabaseService = UserDatabaseService();
  
  FriendsListPage({
    super.key,
    required this.friendId});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(),
      body: Center(
      child: ListView.builder(
        itemBuilder:(context, i){
          Future<AppUserData>? userById = _userDatabaseService.getUserById(friendId[i].toString());
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
                        return const SizedBox.shrink();
                      }
                    } 
                  );
          },
        itemCount: friendId.length,),
      )
    );
  }
}