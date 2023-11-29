import 'package:flutter/material.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/services/firebase_storage.dart';

class ProfileCircle extends StatelessWidget  {
  
  AppUserData? user;

  ProfileCircle({
    super.key,
    this.user
    });

  final StorageService _storage = StorageService();
  

  @override
  Widget build(BuildContext context) {
    if(user!.img!.isEmpty){
      return CircleAvatar(
        foregroundImage: AssetImage("assets/images/intouch-default.png"),
        radius: 64,
      );

    }else{
      Future<String>? imageUrl = _storage.getUserImageUrl(user!.img!);
        return FutureBuilder<String>(
          future: imageUrl,
          builder: (context, imageUrl){
            return CircleAvatar(
              foregroundImage: imageUrl.hasData? NetworkImage(imageUrl.data!): AssetImage("assets/images/intouch-default.png") as ImageProvider,
              radius: 64,
            );
         
        
      });}
    
    
  }
}