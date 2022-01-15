// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/services/database.dart";
import "package:easyclass/models/record.dart";
import 'package:provider/provider.dart';
import "package:easyclass/models/user.dart";
import "package:easyclass/screens/home/teacher/timeslot.dart";

class LessonList extends StatefulWidget {
  @override
  _LessonList createState() => _LessonList();
}

class _LessonList extends State<LessonList> {
  final DatabaseService databaseService = DatabaseService();
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
                        child: _buildButton(context, "අරඹන්න", () {}),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: _buildButton(context, "එක්වන්න", () {}),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildButton(BuildContext context, String label, VoidCallback onClicked) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple[600],
          onPrimary: Colors.white,
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        child: Text(label),
        onPressed: onClicked,
      );
}
