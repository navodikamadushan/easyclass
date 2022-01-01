import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:easyclass/services/database.dart";
import "package:easyclass/models/record.dart";
import 'package:provider/provider.dart';
import "package:easyclass/models/user.dart";

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
        return _buildList(context, snapshot.data.docs);
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
              Container(
                color: Colors.pink,
                child: Padding(
                  padding: EdgeInsets.only(right: 40.0),
                  child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Container(
                            color: Colors.pink,
                            //width: 40,
                            child: Text("Date"),
                          ),
                          numeric: false,
                          onSort: (i, b) {},
                          tooltip: "Display date of class",
                        ),
                        DataColumn(
                          label: Text("Time"),
                          numeric: false,
                          onSort: (i, b) {},
                          tooltip: "Display time of class",
                        ),
                        DataColumn(
                          label: Container(
                            color: Colors.pink,
                            width: 95,
                            child: Text("AM/PM"),
                          ),
                          numeric: false,
                          onSort: (i, b) {},
                          tooltip: "Display time of class",
                        ),
                      ],
                      rows: record.timeslot
                          .map((time) => DataRow(cells: [
                                DataCell(Container(
                                  width: 30,
                                  child: Text(time.split(' ')[0]),
                                )),
                                DataCell(Container(
                                  width: 90,
                                  child: Text(time.split(' ')[1] + ' - ' + time.split(' ')[3]),
                                )),
                                DataCell(Text(time.split(' ')[4])),
                              ]))
                          .toList()),
                ),
              ),
            ],
          ),
        ));
  }
}
