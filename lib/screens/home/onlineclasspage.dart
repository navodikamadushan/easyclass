import 'package:flutter/material.dart';
import "package:easyclass/services/auth.dart";
import "package:easyclass/services/database.dart";
import 'package:provider/provider.dart';
import "package:easyclass/screens/home/onlineclasslist.dart";
import "package:easyclass/screens/home/setting.dart";
import "package:easyclass/screens/home/addclassbuttonwidget.dart";
import "package:easyclass/screens/profile/profilepage.dart";
import "package:easyclass/screens/profile/editprofilepage.dart";
import "package:easyclass/screens/home/profileimagewidget.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import "package:easyclass/screens/home/menu.dart";
import 'package:easyclass/shared/custom_page_route.dart';
//import 'package:top_modal_sheet/top_modal_sheet.dart';

class MyHomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('පන්ති'),
        centerTitle: true,
        actions: <Widget>[
          ProfileImageWidget(
            imagePath: 'https://media.istockphoto.com/photos/portrait-of-a-happy-latin-american-boy-smiling-picture-id1271410473',
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
        child: ListView(
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
              title: Text('නව පන්තිය'),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          /*ListTile(
            trailing: buildAddNewClassButton(),
          ),*/
          LessonList(),
        ],
      ),
    );
  }

  Widget buildAddNewClassButton() => ButtonWidget(
        text: 'නව පන්තිය',
        onClicked: () {
          print('clicked new class button');
        },
      );
}
