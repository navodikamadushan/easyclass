// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
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
                print('hi');
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
