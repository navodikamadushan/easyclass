// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:easyclass/screens/home/teacher/onlineclasspage.dart';
import 'package:easyclass/screens/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:easyclass/models/user.dart';
import 'package:easyclass/screens/emailverify.dart';
import 'package:easyclass/screens/authlevelwrapper.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    print(user);
    // return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return AuthLevelWrapper();
      //return OnlineClassTeacherPage();
      //return EmailVerify();
    }
    //return SignInPage();
  }
}
