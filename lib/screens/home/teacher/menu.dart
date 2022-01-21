// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:easyclass/screens/home/teacher/newclass/form_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              image: AssetImage('assets/drawer_image.jpg'),
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
                'නව පන්තිය',
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
                Navigator.pop(context);
                if (this.precontext == null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FormScreen(userInfo)),
                  );
                }
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
                Icons.add_circle_outline_sharp,
                size: 30.0,
              ),
              onTap: () {
                print('hi');
              },
            ),
          ),
        ),
      ],
    );
  }
}
