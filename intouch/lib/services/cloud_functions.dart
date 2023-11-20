import 'dart:collection';
import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intouch/models/user.dart';
import '../models/category.dart';

    Future<List<Category>> getCategories() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('categories-list');
    final result = await callable.call();
    var casted = result.data as List;
    //PORCO DIEGO 
    return casted.map(
      (e) => Category(id: e!["id"].toString(), name: e!["name"].toString(), cover: e!["cover"].toString())
    ).toList();
    /*List<String> dummyList =["concert", "countryside", "library", "mountain","rpg-meeting"];
    await Duration(seconds: 2);
    return dummyList.map((e) => Category(id: e, name: e, cover: e),).toList();*/
}

  Future<List<AppUserData>>? searchUserByName(String query) async{
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('users-search');
    final result = await callable.call({"query": "${query}"});
    var casted = result.data as List;
    return casted.map(
      (e) => AppUserData(uid: e["id"].toString(), name: e["name"].toString(), img: e["img"], username: e["username"])).toList();
  }

  class ErrorRegisterParser{
    late String field;
    late String message;

    ErrorRegisterParser({
      required this.field,
      required this.message
    });

    String get getField => field;
    String get getMessage => message;


  }

