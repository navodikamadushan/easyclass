// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final CollectionReference deviceInfo = FirebaseFirestore.instance.collection('deviceInfo');
  final CollectionReference onlineclass = FirebaseFirestore.instance.collection('online_class');

  Future updateUserData(String email, String language) async {
    return await users.doc(uid).set({
      'email': email,
      'language': language,
    });
  }

  Future updateDeviceInfo(String deviceId, String language) async {
    return await deviceInfo.doc(deviceId).set({
      'language': language,
    });
  }

  // add user details to user document
  Future addUserProfileData(String currentUserId, String name, String email, String phoneno, String about, String role, var subscribedclass) async {
    return await users.doc(currentUserId).set({
      'name': name,
      'email': email,
      'phoneno': phoneno,
      'about': about,
      'role': role,
      'subscribed_class': subscribedclass,
    });
  }

  // update to user document
  Future updateUserProfileData(String currentUserId, String name, String email, String about) async {
    return await users.doc(currentUserId).update({
      'name': name,
      'email': email,
      'about': about,
    });
  }

  // store phone number to user document
  Future updatePhoneNumbertoUserProfile(String currentUserId, String phonenumber) async {
    return await users.doc(currentUserId).update({
      'phoneno': phonenumber,
    });
  }

  // update online classes
  Future addNewOnlineClass(String class_name, String subject, String teacherid, var timeslot) async {
    var onlineclassRef = onlineclass.doc();
    return await onlineclassRef.set({
      'class_name': class_name,
      'subject': subject,
      'teacher_id': teacherid,
      'no_student': 0,
      'isstart': false,
      'timeslot': timeslot,
      'online_class_id': onlineclassRef.id,
    });
  }
}


  // subscribe a class : add subscribed_id to user document
  Future updateSubscribedClassIDtoUserProfile(String currentUserId, String subscribed_id) async {
    return await users.doc(currentUserId).update({
      'subscribed_class': FieldValue.arrayUnion([
        subscribed_id
      ]),
    });
  }

  //update for online class starting
  Future updateIsStart(String onlineClassId, bool isstart) async {
    return await onlineclass.doc(onlineClassId).update({
      'isstart': isstart,
    });
  }

  // get tf_categories stream
  /*Stream<QuerySnapshot> get lessons {
    return tf_categories.snapshots();
  }*/
}
