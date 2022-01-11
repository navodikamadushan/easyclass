// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/screens/home/student/onlinefullclasspage.dart";

class MenuPage extends StatelessWidget {
  DocumentSnapshot userInfo;
  BuildContext precontext;
  MenuPage(DocumentSnapshot userInfo, BuildContext precontext) {
    this.userInfo = userInfo;
    this.precontext = precontext;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/drawer_image_1.1.0.jpeg'),
            ),
          ),
          child: Text(
            'මෙනුව',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: ListTile(
              //tileColor: Colors.red,
              title: Text(
                'නව පන්ති',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              leading: Icon(
                Icons.add_circle_outline_sharp,
                size: 30.0,
              ),
              onTap: () {
                print('New Classes');
                /*Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OnlineFullClassStudentPage(this.userInfo)),
                );*/
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: ListTile(
              //tileColor: Colors.red,
              title: Text(
                'මගේ පන්ති',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              leading: Icon(
                Icons.watch_later,
                size: 30.0,
              ),
              onTap: () {
                print('My Classes');
                Navigator.pop(context);
                if (this.precontext != null) {
                  this.precontextNavigator.pop(this.precontext);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
