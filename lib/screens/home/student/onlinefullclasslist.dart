// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/services/database.dart";
import "package:easyclass/models/record.dart";
import 'package:provider/provider.dart';
import "package:easyclass/models/user.dart";
import "package:easyclass/screens/home/student/timeslot.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/shared/loading.dart";
import "package:easyclass/services/alert.dart";

class FullLessonList extends StatefulWidget {
  DocumentSnapshot userInfo;
  BuildContext precontext;
  FullLessonList(DocumentSnapshot userInfo, BuildContext precontext) {
    this.userInfo = userInfo;
    this.precontext = precontext;
  }
  @override
  _FullLessonList createState() => _FullLessonList();
}

class _FullLessonList extends State<FullLessonList> {
  final DatabaseService databaseService = DatabaseService();
  bool loading = false;
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final userforid = Provider.of<MyUser>(context);
    return loading
        ? Loading()
        : StreamBuilder<QuerySnapshot>(
            stream: databaseService.onlineclass.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return snapshot.data.docs.toString() == "[]"
                  ? Scaffold(
                      body: Center(
                        child: Text('ඔබ දායක වූ සියලුම පන්ති මකා ඇත.'),
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
    final userforid = Provider.of<MyUser>(context);
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
          child: ListTile(
            key: expansionTileKey,
            //initiallyExpanded: selected == expansionTileKey.hashCode,
            leading: FlutterLogo(),
            title: Text(
              record.class_name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("විෂය: " + record.subject),
                Text("විෂය: kljkjljlkjkjlkjkjjlkjkkjkjlklkl;kllklklkklklllklkl"),
              ],
            ),
            enabled: widget.userInfo['subscribed_class'].contains(record.online_class_id) ? false : true,
            onTap: () async {
              _alertService.subscribeToNewClass(context).then((onValue) async {
                if (onValue) {
                  print('true!');
                  setState(() => loading = true);
                  dynamic result = await databaseService.updateSubscribedClassIDtoUserProfile(userforid.uid, record.online_class_id);
                  //dynamic result = await databaseService.incrementNoStudentOnlineClass(record.online_class_id);
                  if (result == null) {
                    setState(() => loading = false);
                    Navigator.pop(widget.precontext);
                  }
                } else {
                  print('false!');
                }
              });
            },
          ),
        ));
  }
}
