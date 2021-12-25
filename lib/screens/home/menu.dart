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
        ListTile(
          color: Colors.pink,
          title: Text(
            'නව පන්තිය',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          leading: Icon(
            Icons.add_circle_outline_sharp,
            size: 40.0,
          ),
        ),
      ],
    );
  }
}
