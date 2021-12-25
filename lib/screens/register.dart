import 'package:flutter/material.dart';
import "package:easyclass/services/auth.dart";
import "package:easyclass/shared/constant.dart";
import "package:easyclass/shared/loading.dart";

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
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
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('ලියාපදිංචි වන්න',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
              flexibleSpace: Image.asset(
                "assets/eassyclass_icon.png",
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
                      'පුරන්න',
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
                        scale: 3.5,
                        child: IconButton(
                          onPressed: () {},
                          icon: new Image.asset("assets/school_icon.png"),
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
                          'ලියාපදිංචි කරන්න',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                            if (result[0] == null) {
                              setState(() => loading = false);
                              setState(() => error = result[1]);
                            }
                          }
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
