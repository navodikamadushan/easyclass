import 'package:flutter/material.dart';

class TimeSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink,
      child: Padding(
        padding: EdgeInsets.only(left: 0.0),
        child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Container(
                  //width: 40,
                  child: Text("Date"),
                ),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "Display date of class",
              ),
              DataColumn(
                label: Container(
                  child: Text("Time"),
                ),
                numeric: false,
                onSort: (i, b) {},
                tooltip: "Display time of class",
              ),
              DataColumn(
                label: Container(
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
    );
  }
}
