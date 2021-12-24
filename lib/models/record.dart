//import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String class_name;
  final String subject;
  final String teacher;
  final List<dynamic> timeslot;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['class_name'] != null),
        assert(map['subject'] != null),
        assert(map['teacher'] != null),
        assert(map['timeslot'] != null),
        class_name = map['class_name'],
        subject = map['subject'],
        teacher = map['teacher'],
        timeslot = map['timeslot'];
  Record.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);
  @override
  String toString() => "Record<$class_name:$subject:$teacher:$timeslot>";
}
