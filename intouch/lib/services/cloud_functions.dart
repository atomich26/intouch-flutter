

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/services/database.dart';

import '../models/category.dart';


    PostDatabaseService _postDatabaseService = PostDatabaseService();

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

  Future<List<Future<Post>?>?>? feedPost() async{

    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('posts-feed');
    try {
      final result = await callable.call();
      final casted = result.data as List;
      return casted.map(
        (e) => _postDatabaseService.getPostById(e['id'])
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
        (e) => Post(id: e["id"].toString(), userId:e["userId"].toString(), createdAt: e["createdAt"])
        ).toList();
        } on PlatformException catch (e){
          return Future.error(e);
        }
  }

  Future<AppUserData>? getProfileData(String id) async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('users-profile');
    final result = await callable.call({"userId": id});
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

  class ErrorEventParser{
    late String field;
    late String message;

    ErrorEventParser({
      required this.field,
      required this.message
    });

  }

  final class ErrorEventUtil{
    Map<String, String> errorMap = <String, String>{
      "EVENT_NOT_EXISTS_ERROR" : "L'evento cercato non esiste",
      "EVENT_NOT_AUTHOR" : "Non hai i permessi per modificare l'evento",
      "EVENT_CLOSED_ERROR" : "L'evento non è più modificabile.",
      "EVENT_NAME_INVALID" : "Il nome dell'evento deve contenere almeno 10 caratteri.",
      "EVENT_NAME_EMPTY" : "Il nome non può essere vuoto.",
      "EVENT_DESCRIPTION_INVALID" : "La descrizione deve contenere almeno 15 caratteri.",
      "EVENT_DESCRIPTION_EMPTY" : "La descrizione non può essere vuota.",
      "EVENT_CITY_INVALID" : "Il nome della città non può essere vuoto.",
      "EVENT_CITY_EMPTY" : "Inserisci una città per l'evento.",
      "EVENT_ADDRESS_INVALID" : "L'indirizzo non può essere vuoto.",
      "EVENT_ADDRESS_EMPTY" : "Inserisci un indirizzo per il luogo in cui si terrà l'evento.",
      "EVENT_COVER_EMPTY" : "L'evento deve contenere almeno un'immagine.",
      "EVENT_COVER_INVALID" : "L'immagine inserita non è valida.",
      "EVENT_RESTRICTED_INVALID" : "Il campo restricted deve avere un valore booleano.",
      "EVENT_RESTRICTED_EMPTY" : "Il campo restricted è mancante.",
      "EVENT_START_AT_INVALID" : "Il campo StartAt deve essere una data",
      "EVENT_START_AT_BEFORE_NOW" : "La data non può essere precedente a quella corrente.",
      "EVENT_START_AT_EMPTY" : "La data d'inizio non può essere vuota.",
      "EVENT_END_AT_INVALID" : "La data di fine non è valida",
      "EVENT_END_BEFORE_START" : "La data di fine non può essere antecedente a quella d'inizio",
      "EVENT_END_BEFORE_NOW" : "La data di fine non può essere antecedente a quella attuale.",
      "EVENT_CATEGORY_INVALID" : "Categoria non valida.",
      "EVENT_CATEGORY_EMPTY" : "Inserisci una categoria.",
      "EVENT_CATEGORY_NOT_EXISTS" : "La categoria inserita non esiste",
      "EVENT_AVAILABLE_INVALID" : "Il valore massimo della capienza è di 10000 utenti",
      "EVENT_AVAILABLE_EMPTY" : "Inserisci la capienza massima per l'evento",
      "EVENT_GEO_INVALID" : "Le coordinate non sono valide",
      "EVENT_GEO_EMPTY" : "Inserisci le coordinate del luogo in cui si terrà l'evento."
    };
    String getError(String key){
      return errorMap[key] ?? "Errore interno";
    }
    
  }
  