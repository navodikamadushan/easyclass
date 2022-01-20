// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String class_name;
  final String subject;
  final String teacher_id;
  final String online_class_id;
  final String teachername;
  final int no_student;
  final bool isstart;
  final List<dynamic> timeslot;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['class_name'] != null),
        assert(map['subject'] != null),
        assert(map['teacher_id'] != null),
        assert(map['online_class_id'] != null),
        assert(map['teachername'] != null),
        assert(map['no_student'] != null),
        assert(map['isstart'] != null),
        assert(map['timeslot'] != null),
        class_name = map['class_name'],
        subject = map['subject'],
        no_student = map['no_student'],
        teacher_id = map['teacher_id'],
        teachername = map['teachername'],
        isstart = map['isstart'],
        online_class_id = map['online_class_id'],
        timeslot = map['timeslot'];
  Record.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);
  @override
  String toString() => "Record<$class_name:$subject:$no_student:$teacher_id:$isstart:$teachername:$online_class_id:$timeslot>";
}
