// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import "package:easyclass/services/auth.dart";
import "package:easyclass/services/database.dart";
import 'package:provider/provider.dart';
import "package:easyclass/screens/home/student/onlinefullclasslist.dart";
import "package:easyclass/screens/home/setting.dart";
//import "package:easyclass/screens/home/teacher/addclassbuttonwidget.dart";
import "package:easyclass/screens/profile/profilepage.dart";
import "package:easyclass/screens/profile/editprofilepage.dart";
import "package:easyclass/screens/home/profileimagewidget.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import "package:easyclass/screens/home/student/menu.dart";
//import 'package:easyclass/shared/custom_page_route.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnlineFullClassStudentPage extends StatelessWidget {
  DocumentSnapshot userInfo;
  BuildContext precontext;
  OnlineFullClassStudentPage(DocumentSnapshot userInfo, BuildContext precontext) {
    this.userInfo = userInfo;
    this.precontext = precontext;
  }
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('නව පන්ති'),
        centerTitle: true,
        actions: <Widget>[
          ProfileImageWidget(
            imagePath: 'https://media.istockphoto.com/photos/portrait-of-a-happy-latin-american-boy-smiling-picture-id1271410473',
            onClicked: () async {
              //_showUserPannel();
              //Navigator.pop(context);
              Navigator.of(this.precontext).push(
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
        child: MenuPage(this.userInfo, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pop(context);
          print('New Classes');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add_reaction_rounded),
      ),
      body: FullLessonList(userInfo, context),
    );
  }
}
