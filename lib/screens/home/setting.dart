// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import "package:easyclass/services/auth.dart";
import "package:easyclass/services/email.dart";
import "package:easyclass/models/user.dart";
////import "package:easyclass/services/smsservice.dart";
import "package:easyclass/services/alert.dart";
import "package:easyclass/services/database.dart";
import "package:easyclass/shared/constant.dart";
import "package:easyclass/shared/loading.dart";
import "package:easyclass/screens/authenticate.dart";
import 'package:easyclass/screens/signinpage.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import "package:easyclass/models/profileuser.dart";

class SettingPage extends StatefulWidget {
  BuildContext profile_context;
  ProUser myuser;
  //SettingPage({this.context});
  SettingPage(BuildContext context, ProUser myuser) {
    this.profile_context = context;
    this.myuser = myuser;
  }
  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  bool loading = false;
  bool isPhoneNoChanged = false;
  String phoneno = '';
  final AuthService _auth = AuthService();
  final EmailService _email = EmailService();
  final DatabaseService _database = DatabaseService();
  ////final SmsService _sms = SmsService();
  Timer timer;
  User user;
  bool isEmailVerified;

  @override
  void initState() {
    isEmailVerified = _auth.returnExactFirebaseUser().emailVerified;
    user = _auth.returnExactFirebaseUser();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AlertService _alertService = AlertService();
    phoneno = isPhoneNoChanged ? phoneno : widget.myuser.phoneno;
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('සැකසීම'),
              flexibleSpace: Image.asset(
                "assets/appbar_image.png",
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.transparent,
              elevation: 10,
            ),
            body: ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text('Account'),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.local_phone),
                    title: Text('දුරකතන අංකය'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            phoneno,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    onTap: () {
                      _alertService.addMobileNumberAlert(context).then((onValue) async {
                        print(onValue);
                        if (onValue != null) {
                          setState(() => phoneno = onValue);
                          setState(() => isPhoneNoChanged = true);
                          print(widget.myuser.phoneno);
                          setState(() => loading = true);
                          dynamic currentUserId = await _auth.getCurrentUser();
                          dynamic result = await _database.updatePhoneNumbertoUserProfile(currentUserId.uid, onValue);
                          if (result == null) {
                            setState(() => loading = false);
                            print('null');
                          } else {
                            print('not null');
                          }
                        }
                      });
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: isEmailVerified
                        ? Text(
                            'ඊමේල් ලිපිනය තහවුරු කර ඇත',
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          )
                        : Text(
                            'ඊමේල් ලිපිනය තහවුරු කරන්න',
                          ),
                    onTap: () async {
                      _email.sendEmailVerification();
                      if (isEmailVerified) {
                        print('Already Verified');
                        _alertService.singleButtonAlert(context, 'සැකසීම සඳහා ඇඟවීම', 'ඔබ දැනටමත් ඊමේල් ලිපිනය සත්‍යාපනය කර ඇත.');
                      } else {
                        _alertService.singleButtonAlert(context, 'සැකසීම සඳහා ඇඟවීම', '${_auth.returnExactFirebaseUser().email} වෙත විද්‍යුත් තැපෑලක් යවා ඇත. කරුණාකර එය තහවුරු කරන්න.');
                      }
                    },
                    trailing: isEmailVerified
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )
                        : null,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('වරන්න'),
                    onTap: () {
                      _alertService.signOutAlert(context).then((onValue) async {
                        if (onValue) {
                          print('true!');
                          setState(() => loading = true);
                          dynamic signoutresult = await _auth.signOut();
                          // print(signoutresult.toString());
                          if (signoutresult == null) {
                            Navigator.pop(widget.profile_context);
                            Navigator.pop(context);
                            setState(() => loading = false);
                            print('signing out!');
                          }
                        } else {
                          print('false!');
                        }
                      });

                      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => SignInPage()), (Route<dynamic> route) => false);
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text(
                      'ගිණුම මකන්න',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(prof_context).showSnackBar(SnackBar(
                        content: Text("මෙම විශේෂාංගය තවමත් සංවර්ධනය කර නොමැත."),
                      ));
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Security'),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('මුරපදය වෙනස් කරන්න'),
                    onTap: () async {
                      print(_auth.returnExactFirebaseUser().email);
                      _auth.sendPasswordResettoEmail(_auth.returnExactFirebaseUser().email);
                      _alertService.singleButtonAlert(context, 'සැකසීම සඳහා ඇඟවීම', 'ඔබගේ මුරපදය යළි පිහිටුවීම සඳහා ${_auth.returnExactFirebaseUser().email} වෙත විද්‍යුත් තැපෑලක් යවන ලදී');
                      /*_alertService.forgotPassWord(context).then((onValue) {
                        print(onValue);
                        if (onValue != null) {
                          _auth.sendPasswordResettoEmail(onValue);
                          _alertService.singleButtonAlert(context, 'පුරනය සඳහා ඇඟවීම', 'ඔබගේ මුරපදය යළි පිහිටුවීම සඳහා ${onValue} වෙත විද්‍යුත් තැපෑලක් යවන ලදී');
                        }
                      });*/
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Common'),
                    onTap: () {},
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.update),
                    title: Text('යාවත්කාලීන කරන්න'),
                    onTap: () {
                      ScaffoldMessenger.of(prof_context).showSnackBar(SnackBar(
                        content: Text("මෙම විශේෂාංගය තවමත් සංවර්ධනය කර නොමැත."),
                      ));
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: Icon(Icons.language),
                    title: Text('භාෂාව'),
                    subtitle: Text('සිංහල'),
                    onTap: () {
                      ScaffoldMessenger.of(prof_context).showSnackBar(SnackBar(
                        content: Text("මෙම විශේෂාංගය තවමත් සංවර්ධනය කර නොමැත."),
                      ));
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> checkEmailVerified() async {
    user = _auth.returnExactFirebaseUser();
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      setState(() => isEmailVerified = true);
      print('verified');
    }
  }
}
