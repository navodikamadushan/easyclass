// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import "package:easyclass/services/auth.dart";
import "package:easyclass/shared/constant.dart";
import "package:easyclass/shared/loading.dart";
import "package:easyclass/services/translate.dart";
import "package:easyclass/services/deviceinfo.dart";
import "package:easyclass/services/database.dart";
import 'package:device_info_plus/device_info_plus.dart';
import "package:easyclass/services/alert.dart";

class SignInPage extends StatefulWidget {
  final Function toggleView;
  SignInPage({this.toggleView});
  @override
  _SignInPageState createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TranslateService _trans = TranslateService();
  final DeviceInfoService _deviceInfo = DeviceInfoService();
  final AlertService _alertService = AlertService();

  // text field State
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  var language = [
    'සිංහල',
    'English',
    'தமிழ்'
  ];
  var currentItemSelected = 'සිංහල';
  String reg = 'ලියාපදිංචි වන්න';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('පුරන්න',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              flexibleSpace: Image.asset(
                "assets/appbar_image.png",
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.transparent,
              elevation: 10,
              actions: <Widget>[
                FlatButton.icon(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: Text(
                      reg,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      widget.toggleView();
                    }),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 50.0),
                    Container(
                      child: Transform.scale(
                        scale: 4,
                        child: IconButton(
                          onPressed: () {},
                          icon: new Image.asset("assets/official_easy_class_logo__short__purple.png"),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'විද්‍යුත් තැපෑල',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (val) => val.isEmpty ? 'විද්‍යුත් තැපැල් ගිණුමක් ඇතුලත් කරන්න' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        }),
                    SizedBox(height: 20.0),
                    TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: 'මුර පදය',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        obscureText: true,
                        validator: (val) => val.length < 5 ? 'අක්ෂර 5කට වඩා ඇතුලත් කරන්න' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.purple[400],
                        child: Text(
                          'පුරන්න',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                            if (result[0] == null) {
                              setState(() {
                                //error = 'එම අක්තපත්‍ර සමඟින් පුරනය වීමට නොහැකි විය';
                                error = result[1];
                                setState(() => loading = false);
                              });
                            } else {
                              print(result.toString());
                            }
                          }
                        }),
                    SizedBox(height: 10.0),
                    TextButton(
                      child: Text('මුරපදය අමතක වුණා ද?'),
                      onPressed: () async {
                        print('reset password!');
                        _alertService.forgotPassWord(context).then((onValue) {
                          print(onValue);
                          if (onValue != null) {
                            _auth.sendPasswordResettoEmail(onValue);
                            _alertService.singleButtonAlert(context, 'පුරනය සඳහා ඇඟවීම', 'ඔබගේ මුරපදය යළි පිහිටුවීම සඳහා ${onValue} වෙත විද්‍යුත් තැපෑලක් යවන ලදී');
                          }
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    /*RaisedButton(
                        child: Text(
                          'ආගන්තුකයෙකු ලෙස පුරනය වන්න',
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () async {
                          setState(() => loading = true);
                          dynamic result = await _auth.signInAnon();
                          if (result == null) {
                            setState(() => loading = false);
                            print('error signing in');
                          } else {
                            print('signed in');
                            print(result.uid);
                          }
                        }),*/
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    // SizedBox(height: 12.0),
                    DropdownButton<String>(
                      items: language.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) async {
                        setState(() => loading = true);
                        setState(() {
                          this.currentItemSelected = newValueSelected;
                          print(currentItemSelected.toString());
                        });
                        dynamic deviceInfo = await _deviceInfo.getDeviceId();
                        print(deviceInfo.toString());
                        final convertedDeviceId = deviceInfo.toString().replaceAll(RegExp('[^A-Za-z0-9]'), '');
                        dynamic result = await DatabaseService().updateDeviceInfo(convertedDeviceId, currentItemSelected);
                        if (result == null) {
                          setState(() => loading = false);
                        }
                      },
                      value: currentItemSelected,
                    )
                    /*RaisedButton(
                        child: Text('English'),
                        onPressed: () async {
                          setState(() => loading = true);
                          dynamic str = await _trans.translateSentense(reg);
                          if (str == null) {
                            setState(() => loading = false);
                            print('error signing in');
                          } else {
                            setState(() => reg = str);
                            setState(() => loading = false);
                          }
                        })*/
                  ],
                ),
              ),
              /* RaisedButton(
            child: Text('ආගන්තුකයෙකු ලෙස පුරනය වන්න'),
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              if (result == null) {
                print('error signing in');
              } else {
                print('signed in');
                print(result.uid);
              }
            }),*/
            ),
          );
  }
}
