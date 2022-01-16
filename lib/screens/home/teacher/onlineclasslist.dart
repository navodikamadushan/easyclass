// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/services/database.dart";
import "package:easyclass/models/record.dart";
import 'package:provider/provider.dart';
import "package:easyclass/models/user.dart";
import "package:easyclass/screens/home/teacher/timeslot.dart";
import "package:easyclass/services/alert.dart";
import "package:easyclass/services/jitsiservice.dart";

class LessonList extends StatefulWidget {
  DocumentSnapshot userInfo;
  LessonList(DocumentSnapshot userInfo) {
    this.userInfo = userInfo;
  }
  @override
  _LessonList createState() => _LessonList();
}

class _LessonList extends State<LessonList> {
  final DatabaseService databaseService = DatabaseService();
  final JistiVideoConference jitsi = JistiVideoConference();
  int selected = 0;
  //ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    final userforid = Provider.of<MyUser>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: databaseService.onlineclass.where('teacher_id', whereIn: [
        userforid.uid
      ]).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return snapshot.data.docs.toString() == "[]"
            ? Scaffold(
                body: Center(
                  child: Text('ඔබ පන්ති කිසිවක් නිර්මාණය කර නැත.'),
                ),
              )
            : _buildList(context, snapshot.data.docs, widget.userInfo);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot, DocumentSnapshot userInfo) {
    return ListView(
      // ExpansionPanelList.radio(
      physics: const AlwaysScrollableScrollPhysics(),
      //controller: _controller,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 5.0),
      children: snapshot.map((data) => _buildListItem(context, data, userInfo)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data, DocumentSnapshot userInfo) {
    final GlobalKey expansionTileKey = GlobalKey();
    final record = Record.fromSnapshot(data);
    final DatabaseService _databaseService = DatabaseService();
    final AlertService _alertService = AlertService();
    return Padding(
        key: ValueKey(record.class_name),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: ExpansionTile(
            key: expansionTileKey,
            initiallyExpanded: selected == expansionTileKey.hashCode,
            leading: FlutterLogo(),
            title: Text(
              record.class_name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(record.subject),
            onExpansionChanged: (value) {
              //print(expansionTileKey.hashCode.toString());
              selected = expansionTileKey.hashCode;
              print(selected.toString());
              //setState(() => selected = expansionTileKey.hashCode);
            },
            children: <Widget>[
              Card(
                child: TimeSlot(record.timeslot),
              ),
              Card(
                child: Text(
                  'සිසුන් සංඛ්‍යාව: ${record.no_student.toString()}',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: _buildButton(context, "අරඹන්න", Colors.green[600], () async {
                            print("Start!");
                            dynamic result = await _databaseService.updateIsStart(record.online_class_id, true);
                            if (result == null) {
                              print("Null");
                            } else {
                              print("Not null");
                            }
                            print(record.online_class_id);
                          }, record.isstart)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: _buildButton(context, "එක්වන්න", Colors.purple[600], () {
                          _alertService.joinToExistingClass(context, record.class_name).then((onValue) async {
                            if (onValue) {
                              print("Accept!");
                              jitsi.joinMeeting(record.online_class_id, record.subject, userInfo['name'], userInfo['email']);
                            } else {
                              print("Discard!");
                            }
                          });
                        }, !record.isstart),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildButton(BuildContext context, String label, Color buttonColor, VoidCallback onClicked, bool isEnable) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          onPrimary: Colors.white,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          onSurface: buttonColor,
        ),
        child: Text(label),
        onPressed: isEnable ? null : onClicked,
      );
}
