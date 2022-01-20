// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/services/database.dart";
import "package:easyclass/models/record.dart";
import 'package:provider/provider.dart';
import "package:easyclass/models/user.dart";
import "package:easyclass/screens/home/student/timeslot.dart";
//import "package:easyclass/screens/home/student/zoom/zoomscreen.dart";
import "package:easyclass/screens/home/student/jitsi/jitsimeeting.dart";
import "package:easyclass/services/jitsiservice.dart";
import "package:easyclass/services/alert.dart";

class LessonList extends StatefulWidget {
  var subscribed_classes;
  DocumentSnapshot userInfo;
  LessonList(DocumentSnapshot userInfo) {
    this.subscribed_classes = userInfo['subscribed_class'];
    this.userInfo = userInfo;
  }
  @override
  _LessonList createState() => _LessonList();
}

class _LessonList extends State<LessonList> {
  final DatabaseService databaseService = DatabaseService();
  final JistiVideoConference jitsi = JistiVideoConference();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.subscribed_classes);
    final userforid = Provider.of<MyUser>(context);
    return widget.subscribed_classes.toString() == '[]'
        ? Scaffold(
            body: Center(
              child: Text('ඔබ කිසිදු පන්තියකට දායක වී නැත.'),
            ),
          )
        : StreamBuilder<QuerySnapshot>(
            stream: databaseService.onlineclass.where('online_class_id', whereIn: widget.subscribed_classes).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              //print(snapshot.data.docs); // snapshot.data.docs[11].id
              return snapshot.data.docs.toString() == "[]"
                  ? Scaffold(
                      body: Center(
                        child: Text('ඔබ දායක වූ සියලුම පන්ති මකා ඇත.'),
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
            trailing: _buildButton('Join', () async {
              print(record.online_class_id);
              _alertService.joinToExistingClass(context, record.class_name).then((onValue) async {
                if (onValue) {
                  print("Accept!");
                  jitsi.joinMeeting(record.online_class_id, record.subject, userInfo['name'], userInfo['email']);
                } else {
                  print("Discard!");
                }
              });

              /*Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyApp()), //'1', '79482849584', '6VrFfY'
              );*/
            }, record.isstart),
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
            ],
          ),
        ));
  }

  Widget _buildButton(String text, VoidCallback onClicked, bool isStart) {
    final AlertService _alertService = AlertService();
    return isStart
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(text),
            onPressed: onClicked,
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blue[200],
              onPrimary: Colors.white,
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
            child: Text(text),
            onPressed: () {
              _alertService.singleButtonAlert(context, 'පන්ති සැකසුම', 'මෙම පන්තිය තවම ආරම්භ කර නැත. කරුණාකර ඔබේ ගුරුවරයා අමතන්න.');
            },
          );
  }
}
