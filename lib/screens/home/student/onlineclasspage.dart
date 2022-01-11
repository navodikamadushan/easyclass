// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import "package:easyclass/services/auth.dart";
import "package:easyclass/services/database.dart";
import 'package:provider/provider.dart';
import "package:easyclass/screens/home/student/onlineclasslist.dart";
import "package:easyclass/screens/home/setting.dart";
//import "package:easyclass/screens/home/teacher/addclassbuttonwidget.dart";
import "package:easyclass/screens/profile/profilepage.dart";
import "package:easyclass/screens/profile/editprofilepage.dart";
import "package:easyclass/screens/home/profileimagewidget.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import "package:easyclass/screens/home/student/menu.dart";
import "package:easyclass/screens/home/student/onlinefullclasspage.dart";
//import 'package:easyclass/shared/custom_page_route.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnlineClassStudentPage extends StatelessWidget {
  DocumentSnapshot userInfo;
  OnlineClassStudentPage(DocumentSnapshot userInfo) {
    this.userInfo = userInfo;
  }
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('මගේ පන්ති'),
        centerTitle: true,
        actions: <Widget>[
          ProfileImageWidget(
            imagePath: 'https://media.istockphoto.com/photos/portrait-of-a-happy-latin-american-boy-smiling-picture-id1271410473',
            onClicked: () async {
              //_showUserPannel();
              //Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
        flexibleSpace: Image.asset(
          "assets/appbar_image.png",
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        elevation: 10,
      ),
      drawer: Drawer(
        child: MenuPage(this.userInfo),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('New Classes');
          Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed(
            MaterialPageRoute(builder: (context) => OnlineFullClassStudentPage(userInfo)),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: LessonList(userInfo['subscribed_class']),
    );
  }

  /*Widget buildAddNewClassButton() => ButtonWidget(
        text: 'නව පන්තිය',
        onClicked: () {
          print('clicked new class button');
        },
      );*/
}
