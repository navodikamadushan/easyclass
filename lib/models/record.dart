// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String class_name;
  final String subject;
  final String teacher_id;
  final int no_student;
  final List<dynamic> timeslot;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['class_name'] != null),
        assert(map['subject'] != null),
        assert(map['teacher_id'] != null),
        assert(map['no_student'] != null),
        assert(map['timeslot'] != null),
        class_name = map['class_name'],
        subject = map['subject'],
        no_student = map['no_student'],
        teacher_id = map['teacher_id'],
        timeslot = map['timeslot'];
  Record.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);
  @override
  String toString() => "Record<$class_name:$subject:$no_student:$teacher_id:$timeslot>";
}
