import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import '../models/category.dart';

    Future<List<Category>> getCategories() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('categories-list');
    var result = await callable.call();
    return result.data;  
}