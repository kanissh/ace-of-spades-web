import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExamScheduleObject {
  final String courseCode; //course_code
  final DateTime startTime; //start_time
  final DateTime endTime; //end_time
  final String desc;

  ExamScheduleObject({@required this.courseCode, @required this.startTime, @required this.endTime, this.desc});

  static ExamScheduleObject convertToObject({DocumentSnapshot documentSnapshot}) {
    return ExamScheduleObject(
        courseCode: documentSnapshot['course_code'],
        startTime: documentSnapshot['start_time'].toDate(),
        endTime: documentSnapshot['end_time'].toDate(),
        desc: documentSnapshot['desc']);
  }
}
