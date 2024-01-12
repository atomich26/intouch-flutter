
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:intouch/models/post.dart';
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
    
}

  Future<List<String>>? searchUserByName(String query) async{
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('users-search');
    try {
      final result = await callable.call({"query" : query});
      var casted = result.data as List;
      return casted.map((e) => e.toString()).toList();
    } on PlatformException catch (e){
      return Future.error(e);
    }
  }

  Future<List<String>>? searchEventByName(String query) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('events-search');
    try {
      final result = await callable.call({"query" : query});
      var casted = result.data as List;
      return casted.map((e) => e.toString()).toList();
    } on PlatformException catch (e){
      return Future.error(e);
    }
  }

  Future<List<Post>?>? feedPost() async{
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('posts-feed');
    try {final result = await callable.call();
      var casted = result.data as List;
      return casted.map(
        (e) => Post.fromFirestore(e, null)
        ).toList();} on PlatformException catch (e){
          return Future.error(e);
        }
  }

  Future<List<Post>?>? getPostByAuthor(String authorId) async{
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('posts-getAllByAuthor');
    try {
      final result = await callable.call({"authorId": authorId});
      var casted = result.data as List;
      return casted.map(
        (e) => Post(id: e["id"].toString(), createdAt: e["createdAt"])
        ).toList();
        } on PlatformException catch (e){
          return Future.error(e);
        }
  }

  


  



  Future<AppUserData>? getProfileData(String id) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('users-profile');
    final result = await callable.call({"userId": id});
    print(result.data);
    AppUserData casted = AppUserData.fromJson(result.data);
    return casted;
  }

  








  class ErrorRegisterParser{
    late String field;
    late String message;

    ErrorRegisterParser({
      required this.field,
      required this.message
    });

  }
  final class ErrorRegisterUtil{
    Map<String, String> errorMap = <String,String> {
    "INVALID_ARGUMENT" : "I valori inseriti non sono validi",
    "PERMISSION_DENIED" : "Non hai i permessi per effettuare questa operazione",
    "USER_NOT_EXISTS" : "Utente non valido o non più esistente",

    "INVALID_USERNAME" : "Il nome utente deve contenere almeno 3 caratteri e sono ammessi solo lettere minuscole, numeri e . _",
    "USERNAME_ALREADY_EXISTS" : "Nome utente non disponibile",
    "EMPTY_USERNAME" : "Il nome utente non può essere vuoto",	

    "INVALID_NAME" : "La lunghezza del nome deve essere compresa fra i 3 e i 40 caratteri",
    "INVALID_SPECIAL_CHARS_NAME" : "Il nome non può contenere caratteri speciali",
    "EMPTY_NAME" : "Il nome non può esser vuoto",

    "INVALID_EMAIL_LENGTH" : "L'indirizzo email può contenere massimo 90 caratteri",
    "INVALID_EMAIL" : "Indirizzo email non valido",
    "EMAIL_ALREADY_EXISTS" : "Indirizzo email già in uso",
    "EMPTY_EMAIL" : "L'email non può essere vuota",

    "INVALID_PASSWORD" : "La password deve contenere almeno 8 caratteri, un numero e un carattere speciale tra questi: @ \$ ! % * # ?",
    "EMPTY_PASSWORD" : "La password non puo essere vuota",

    "INVALID_DATE" : "Data non valida",
    "DATE_AFTER_NOW" : "Data successiva a quella corrente",
    "EMPTY_BIRTHDATE" : "La data di nascita non può essere vuota",

    };

    String getError(String key){
      return errorMap[key] ?? "Errore interno";
    }
  }
  