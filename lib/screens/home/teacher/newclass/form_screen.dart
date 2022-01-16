// All right reserved by EasyClass
// Auther Information:- Kamith Yudara Tennakooon(kamithyudarathennakoon@gmail.com)
// Updated by:- Navodika Karunasingha(eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easyclass/screens/home/teacher/newclass/form_timeSlot.dart';
import 'package:easyclass/screens/home/teacher/newclass/timeSlotList.dart';
import 'package:easyclass/services/provider/list_provider.dart';
import 'package:easyclass/models/model.dart';
import "package:easyclass/services/database.dart"; // import database package
import "package:easyclass/services/auth.dart"; // import auth package
import "package:easyclass/models/user.dart"; // import user model for MyUser class
import "package:easyclass/shared/loading.dart"; // import loading page

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() {
    return _FormScreenState();
  }
}

class _FormScreenState extends State<FormScreen> {
  String _className = "";
  String _subject = "";
  bool isButtonActive = true;
  List<String> _timeSlotlist = [];
  bool loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseService _database = DatabaseService(); // instantiating database services
  final AuthService _auth = AuthService(); // instantiating auth services

  Widget _setClassName() {
    return TextFormField(
      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'පන්තියේ නම'),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'කරුණාකර පන්තියේ නම ඇතුලත් කරන්න';
        } else {
          // set textfield value variable
          setState(() => _className = value);
        }

        return null;
      },
      onSaved: (String value) {
        _className = value;
      },
    );
  }

  Widget _setSubject() {
    return TextFormField(
      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'විෂය'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'කරුණාකර විෂය ඇතුලත් කරන්න';
        } else {
          // set textfield value variable
          setState(() => _subject = value);
        }

        return null;
      },
      onSaved: (String value) {
        _subject = value;
      },
    );
  }

  _addTimeSlotPanel(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: TimeSlotForm(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    int index = context.watch<ListProvider>().list.length;
    if (index == 3) {
      setState(() => isButtonActive = false);
    } else {
      setState(() => isButtonActive = true);
    }
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("පන්ති සැකසුම"),
              flexibleSpace: Image.asset(
                "assets/appbar_image.png",
                fit: BoxFit.cover,
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _setClassName(),
                    _setSubject(),
                    SizedBox(height: 20),
                    Text(
                      'පන්ති සඳහා ඔබේ කාල පරාසයන් සකසන්න',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    TimeSlotList(),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        onPressed: isButtonActive
                            ? () {
                                _addTimeSlotPanel(context);
                              }
                            : null,
                        color: Colors.purple[200],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Text(
                          "+",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                      child: Text(
                        'ඉදිරිපත් කරන්න',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                      color: Colors.purple[400],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      onPressed: () async {
                        print(context.read<ListProvider>().getAllItems(index));
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        // get current user
                        setState(() => loading = true);
                        dynamic user = await _auth.getCurrentUser();
                        if (user != null) {
                          print(user.uid.toString());
                          // add a new online class to database
                          dynamic result = await _database.addNewOnlineClass(_className, _subject, user.uid.toString(), context.read<ListProvider>().getAllItems(index));
                          if (result == null) {
                            setState(() => loading = false);
                            _formKey.currentState.save();
                            // print('');
                            print('submitted!');
                          } else {
                            //setState(() => loading = false);
                            print('not submitted!');
                          }
                        } else {
                          //setState(() => loading = false);
                          print('User not logged!');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
