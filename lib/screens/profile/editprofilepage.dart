// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import "package:easyclass/models/profileuser.dart";
import "package:easyclass/screens/profile/userpreferences.dart";
import "package:easyclass/screens/profile/profileappbar.dart";
import "package:easyclass/screens/profile/profilewidget.dart";
import "package:easyclass/screens/profile/textfieldwidget.dart";
import "package:easyclass/screens/profile/profilepage.dart";
import "package:easyclass/shared/loading.dart";
import "package:easyclass/models/profileuser.dart";
import "package:easyclass/services/auth.dart";
import "package:easyclass/services/database.dart";
import "package:easyclass/services/storage.dart";
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  ProUser user;
  String name;
  String email;
  String about;
  EditProfilePage(ProUser user) {
    this.user = user;
    this.name = user.name;
    this.email = user.email;
    this.about = user.about;
  }
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  //ProUser user = UserPreferences().myUser;
  String imageURL = null;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final StorageService _storage = StorageService();
  bool loading = false;
  bool isEditProfile = true;
  @override
  Widget build(BuildContext context) =>
      //String imageURL;
      loading
          ? Loading()
          : Scaffold(
              appBar: buildAppBar(context, isEditProfile, widget.user),
              body: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  physics: BouncingScrollPhysics(),
                  children: [
                    ProfileWidget(
                      isEdit: true,
                      imagePath: imageURL == null ? widget.user.imagePath : "https://ichef.bbci.co.uk/news/976/cpsprodpb/162E0/production/_117584809_imagetools0.jpg",
                      onClicked: () async {
                        var downloadURL = _storage.uploadImage();
                        //setState(() => widget.user.imagePath = downloadURL);
                        /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("මෙම විශේෂාංගය තවමත් සංවර්ධනය කර නොමැත."),
                    ));*/
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFieldWidget(
                      label: 'Full Name',
                      hint: 'සම්පූර්ණ නම',
                      invaliderror: 'සම්පූර්ණ නම ඇතුලත් කරන්න',
                      text: widget.user.name,
                      onChanged: (name_val) {
                        setState(() => widget.name = name_val);
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFieldWidget(
                      label: 'Email',
                      hint: 'විද්යුත් තැපැල් ලිපිනය',
                      invaliderror: 'ඊමේල් ලිපිනය ඇතුලත් කරන්න',
                      text: widget.user.email,
                      onChanged: (email_val) {
                        setState(() => widget.email = email_val);
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFieldWidget(
                      label: 'About',
                      hint: 'ඔබ ගැන සඳහන් කරන්න',
                      invaliderror: 'ඔබ ගැන තොරතුරු ඇතුළත් කිරීමට වග බලා ගන්න',
                      text: widget.user.about,
                      maxLines: 5,
                      onChanged: (about_val) {
                        setState(() => widget.about = about_val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.purple[600],
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                        child: Text(
                          'සුරකින්න',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            print('validated');
                            //print(name);
                            dynamic currentUserId = await _auth.getCurrentUser();
                            dynamic result = await DatabaseService().updateUserProfileData(currentUserId.uid, widget.name, widget.email, widget.about);
                            print(currentUserId.uid);
                            print(result);
                            if (result == null) {
                              Navigator.pop(context);
                              setState(() => loading = false);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ), //ListView
              ),
            );
}
