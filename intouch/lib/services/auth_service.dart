import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //mapping user in costum obj
  AppUser? _userFromFirebaseUser (User? user){
    return user != null ? AppUser(id: user.uid) : null;
  }

  //auth change stream
  Stream<AppUser?> get user{
    return _auth.authStateChanges()
            .map(_userFromFirebaseUser);
  }

  //sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e){
      print(e.toString());
      return e;
    } 
  }

  //register
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException {
      return null;
    }
  }
  

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

}