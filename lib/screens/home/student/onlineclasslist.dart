// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/services/database.dart";
import "package:easyclass/models/record.dart";
import 'package:provider/provider.dart';
import "package:easyclass/models/user.dart";
import "package:easyclass/screens/home/student/timeslot.dart";

class LessonList extends StatefulWidget {
  var subscribed_classes;
  LessonList(var subscribed_classes) {
    this.subscribed_classes = subscribed_classes;
  }
  @override
  _LessonList createState() => _LessonList();
}

class _LessonList extends State<LessonList> {
  final DatabaseService databaseService = DatabaseService();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final userforid = Provider.of<MyUser>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: databaseService.onlineclass.where('online_class_id', whereIn: widget.subscribed_classes).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        // print(snapshot.data.docs[11].id); // snapshot.data.docs[11].id
        return snapshot.data.docs.toString() == "[]"
            ? Scaffold(
                body: Center(
                  child: Text('ඔබ කිසිදු පන්තියකට දායක වී නැත.'),
                ),
              )
            : _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      // ExpansionPanelList.radio(
      physics: const AlwaysScrollableScrollPhysics(),
      //controller: _controller,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 5.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final GlobalKey expansionTileKey = GlobalKey();
    final record = Record.fromSnapshot(data);
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
            ],
          ),
        ));
  }
}
