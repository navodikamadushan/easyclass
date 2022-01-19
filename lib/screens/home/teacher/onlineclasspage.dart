// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import "package:easyclass/services/auth.dart";
import "package:easyclass/services/database.dart";
import 'package:provider/provider.dart';
import "package:easyclass/screens/home/teacher/onlineclasslist.dart";
import "package:easyclass/screens/home/setting.dart";
import "package:easyclass/screens/home/teacher/addclassbuttonwidget.dart";
import "package:easyclass/screens/profile/profilepage.dart";
import "package:easyclass/screens/profile/editprofilepage.dart";
import "package:easyclass/screens/home/profileimagewidget.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import "package:easyclass/screens/home/teacher/menu.dart";
//import 'package:easyclass/shared/custom_page_route.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:easyclass/screens/home/teacher/newclass/form_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OnlineClassTeacherPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  DocumentSnapshot userInfo;
  OnlineClassTeacherPage(DocumentSnapshot userInfo) {
    this.userInfo = userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('පන්ති'),
        centerTitle: true,
        actions: <Widget>[
          ProfileImageWidget(
            imagePath: 'https://firebasestorage.googleapis.com/v0/b/easyclass-4306f.appspot.com/o/profile_picture%2Fdefault.png?alt=media&token=1f96742e-9e8c-4203-b0e7-bfb8872f11b7',
            onClicked: () async {
              //_showUserPannel();
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
        child: MenuPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => FormScreen()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      body: LessonList(userInfo),
    );
  }

  Widget buildAddNewClassButton() => ButtonWidget(
        text: 'නව පන්තිය',
        onClicked: () {
          print('clicked new class button');
        },
      );
}
