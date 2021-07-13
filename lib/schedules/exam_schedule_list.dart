import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/schedules/exam_schedule_object.dart';
import 'package:ace_of_spades/schedules/exam_schedule_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ExamScheduleList extends StatelessWidget {
  final List pendingCourseList;
  ExamScheduleList({this.pendingCourseList});

  CollectionReference examScheduleRef = FirebaseFirestore.instance.collection(DbConfigPath.EXAM_SCHEDULE);

  List<String> getCourseCode(List list) {
    List<String> results = List();

    for (var item in list) {
      results.add(item['course_code'].toString().toUpperCase());
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return pendingCourseList == null || pendingCourseList.isEmpty
        ? Text('No examination soon')
        : StreamBuilder(
            stream: examScheduleRef
                .where('course_code', whereIn: getCourseCode(pendingCourseList))
                .orderBy('start_time')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Data error occurred'); //TODO: handle
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(redColor),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.active) {
                List<Widget> scheduleList = List();

                snapshot.data.docs.map<Widget>((DocumentSnapshot documentSnapshot) {
                  scheduleList.add(ExamScheduleTile(
                    examScheduleObject: ExamScheduleObject.convertToObject(documentSnapshot: documentSnapshot),
                  ));
                }).toList();
                //FIXME: set method return to schedule list

                return ListView(
                  children: scheduleList,
                );
              }

              return Text('Could not load data');
            },
          );
  }
}
