// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import "package:easyclass/screens/profile/profileappbar.dart";
import "package:easyclass/screens/profile/userpreferences.dart";
import "package:easyclass/screens/profile/profilewidget.dart";
import "package:easyclass/screens/profile/buttonwidget.dart";
import "package:easyclass/screens/profile/numberswidget.dart";
import "package:easyclass/screens/profile/editprofilepage.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/models/profileuser.dart";
import "package:easyclass/models/user.dart";
import "package:easyclass/services/database.dart";
import "package:easyclass/services/auth.dart";
import 'package:provider/provider.dart';
import "package:easyclass/shared/loading.dart";

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userforid = Provider.of<MyUser>(context);
    final DatabaseService databaseService = DatabaseService();
    final AuthService _auth = AuthService();
    final user = UserPreferences().myUser;
    bool isEditProfile = false;
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(userforid.uid).snapshots(),
        builder: (context, snapshot) {
          // final docs = snapshot.data.data(userforid.uid);

          if (!snapshot.hasData) return Loading();

          final myuser = ProUser(
            imagePath: snapshot.data['profileimg'] == "" ? 'https://firebasestorage.googleapis.com/v0/b/easyclass-4306f.appspot.com/o/profile_picture%2Fdefault.png?alt=media&token=1f96742e-9e8c-4203-b0e7-bfb8872f11b7' : snapshot.data['profileimg'],
            name: snapshot.data['name'],
            email: snapshot.data['email'],
            about: snapshot.data['about'],
            phoneno: snapshot.data['phoneno'],
            role: snapshot.data['role'],
            isDarkMode: false,
          );
          return Scaffold(
            appBar: buildAppBar(context, isEditProfile, myuser),
            backgroundColor: Colors.white,
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: myuser.imagePath,
                  onClicked: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfilePage(myuser)),
                    );
                  },
                ),
                const SizedBox(height: 24),
                buildName(myuser),
                const SizedBox(height: 24),
                Center(child: buildUpgradeButton(myuser)),
                const SizedBox(height: 24),
                NumbersWidget(),
                const SizedBox(height: 24),
                buildAbout(myuser),
              ],
            ),
          );
        });
  }

  Widget buildAbout(ProUser user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            user.about == ''
                ? Container()
                : Text(
                    'About',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 16),
            user.about == null
                ? Container()
                : Text(
                    user.about,
                    style: TextStyle(fontSize: 16, height: 1.4),
                  ),
          ],
        ),
      );

  Widget buildName(ProUser user) => Column(
        children: [
          user.name == null
              ? Container()
              : Text(
                  user.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
          user.email == null
              ? Container()
              : Text(
                  user.email,
                  style: TextStyle(color: Colors.grey),
                ),
        ],
      );
  Widget buildUpgradeButton(ProUser user) => ButtonWidget(
        text: user.role.toString(),
        onClicked: () {
          print(user.role);
          String roleSinhala;
          roleSinhala = user.role == 'student' ? 'ශිෂ්‍යයයෙක්' : 'ගුරුවරයෙක්';
          /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("ඔබ ${roleSinhala}. ඔබගේ ගිණුම ප්‍රවර්ධනය කිරීමට හෝ පහත් කිරීමට කරුණාකර පරිපාලක අමතන්න."),
          ));*/
        },
      );
}
