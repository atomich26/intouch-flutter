import 'package:flutter/material.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/services/firebase_storage.dart';

class ProfileCircle extends StatelessWidget  {
  
  AppUserData? user;
  double radius;

  ProfileCircle({
    super.key,
    this.user,
    required this.radius,
    });

  final StorageService _storage = StorageService();
  

  @override
  Widget build(BuildContext context) {
    if(user!.img!.isEmpty){
      return CircleAvatar(
        foregroundImage: const AssetImage("assets/images/intouch-default-user.png"),
        radius: radius,
      );

    }else{
      Future<String>? imageUrl = _storage.getUserImageUrl(user!.img!);
        return FutureBuilder<String>(
          future: imageUrl,
          builder: (context, imageUrl){
            return CircleAvatar(
              foregroundImage: imageUrl.hasData? NetworkImage(imageUrl.data!): const AssetImage("assets/images/intouch-default.png") as ImageProvider,
              radius: radius,
            );
         
        
      });}
    
    
  }
}