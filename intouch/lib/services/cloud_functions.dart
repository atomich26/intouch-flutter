import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/category.dart';

    Future<List<Category>> getCategories() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('categories-list');
    final result = await callable.call();
    var casted = result.data as List;
    //PORCO DIEGO 
    return casted.map(
      (e) => Category(id: e!["id"].toString(), name: e!["name"].toString(), cover: e!["cover"].toString())
    ).toList();
}