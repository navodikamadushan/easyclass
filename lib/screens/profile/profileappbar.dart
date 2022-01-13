// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easyclass/screens/home/setting.dart';
import "package:easyclass/models/profileuser.dart";
//import 'package:easyclass/screens/emailverify.dart';

AppBar buildAppBar(BuildContext prof_context, bool isEditProfile, ProUser myuser) {
  final icon = Icons.nights_stay_sharp;
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      isEditProfile
          ? Container()
          : IconButton(
              icon: Icon(Icons.settings, color: Colors.black),
              onPressed: () {
                Navigator.of(prof_context).push(
                  MaterialPageRoute(builder: (context) => SettingPage(prof_context, myuser)),
                  //MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
      IconButton(
        icon: Icon(icon, color: Colors.black),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("මෙම විශේෂාංගය තවමත් සංවර්ධනය කර නොමැත."),
          ));
        },
      ),
    ],
  );
}
