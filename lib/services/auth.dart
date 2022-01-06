// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:firebase_auth/firebase_auth.dart';
import "package:translator/translator.dart";
import 'package:easyclass/models/user.dart';
import "package:easyclass/services/database.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on FirebaseUser
  MyUser _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // return exact firebase User
  User returnExactFirebaseUser() {
    return _auth.currentUser;
  }

  // auth change user stream
  Stream<MyUser> get user {
    return _auth
        .authStateChanges()
        //.map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return [
        _userFromFirebaseUser(user),
        null
      ];
    } catch (e) {
      GoogleTranslator translator = GoogleTranslator();
      var strarr = e.toString().split("] ");
      var s = await translator.translate(strarr[1], from: 'en', to: 'si');
      print(e.toString());
      return [
        null,
        s.toString() // send error message
      ];
    }
  }

  // register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService().addUserProfileData(user.uid, '', email, '', '', 'student');
      return [
        _userFromFirebaseUser(user),
        null
      ];
    } catch (e) {
      GoogleTranslator translator = GoogleTranslator();
      var strarr = e.toString().split("] ");
      var s = await translator.translate(strarr[1], from: 'en', to: 'si');
      print(e.toString());
      return [
        null,
        s.toString()
      ];
    }
  }

  //send password reset to email

  Future<void> sendPasswordResettoEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // get current user
  Future getCurrentUser() async {
    try {
      User user = _auth.currentUser;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
