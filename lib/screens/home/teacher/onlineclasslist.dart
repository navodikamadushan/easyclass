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
import 'package:animated_text_kit/animated_text_kit.dart';

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
            leading: FlutterLogo(),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //const SizedBox(width: 20.0, height: 50.0),
                const Text(
                  'Be',
                  style: TextStyle(fontSize: 15.0),
                ),
                const SizedBox(width: 5.0, height: 15.0),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Horizon',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('AWESOME'),
                      RotateAnimatedText('OPTIMISTIC'),
                      RotateAnimatedText('DIFFERENT'),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ),
              ],
            ),
            /*Text(
              record.class_name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),*/
            subtitle: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  "විෂය:   ${record.subject}",
                  textStyle: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 4,
              pause: const Duration(milliseconds: 200),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ), //Text("විෂය:   ${record.subject}"),
            trailing: Tooltip(
              message: 'ඔබේ පන්ති විස්තර සංස්කරණය කරන්න.',
              height: 12,
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("මෙම විශේෂාංගය තවමත් සංවර්ධනය කර නොමැත."),
                  ));
                },
                child: const Text('සංස්කරණය'),
              ),
            ),
            onExpansionChanged: (value) {
              //print(expansionTileKey.hashCode.toString());
              selected = expansionTileKey.hashCode;
              print(selected.toString());
              //setState(() => selected = expansionTileKey.hashCode);
            },
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "පන්ති කාලසටහන",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        // fontSize: 20.0,
                      ),
                    ),
                  ),
                  Card(
                    child: TimeSlot(record.timeslot),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'සිසුන් සංඛ්‍යාව: ${record.no_student.toString()}',
                      style: TextStyle(
                          // fontSize: 20.0,
                          ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: !record.isstart
                            ? _buildButton(context, "අරඹන්න", Colors.green[600], () async {
                                print("Start!");
                                dynamic result = await _databaseService.updateIsStart(record.online_class_id, true);
                                if (result == null) {
                                  print("Null");
                                } else {
                                  print("Not null");
                                }
                                print(record.online_class_id);
                              }, record.isstart)
                            : _buildButton(context, "නවතන්න", Colors.red[600], () async {
                                print("Stop!");
                                dynamic result = await _databaseService.updateIsStart(record.online_class_id, false);
                                if (result == null) {
                                  print("Null");
                                } else {
                                  print("Not null");
                                }
                                print(record.online_class_id);
                              }, record.isstart),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: _buildButton(
                            context,
                            "එක්වන්න",
                            Colors.purple[600],
                            record.isstart
                                ? () {
                                    _alertService.joinToExistingClass(context, record.class_name).then((onValue) async {
                                      if (onValue) {
                                        print("Accept!");
                                        jitsi.joinMeeting(record.online_class_id, record.subject, userInfo['name'], userInfo['email']);
                                      } else {
                                        print("Discard!");
                                      }
                                    });
                                  }
                                : null,
                            !record.isstart),
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
        onPressed: onClicked,
      );
}
