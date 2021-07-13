import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/course_status.dart';
import 'package:ace_of_spades/schedules/exam_schedule_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ExamSchedulePage extends StatefulWidget {
  @override
  _ExamScheduleState createState() => _ExamScheduleState();
}

class _ExamScheduleState extends State<ExamSchedulePage> {
  CollectionReference examScheduleRef = FirebaseFirestore.instance.collection(DbConfigPath.EXAM_SCHEDULE);
  var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfigPath.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());

  //var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Exam Schedule',
          ),
        ),
        body: FutureBuilder(
          future: studentDocument.get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              List courseList = data['courses'];

              // get courses where result is pending
              List courseListPending = courseList.where((e) {
                return e['status'].toString().contains(CourseStatus.ONGOING);
              }).toList();

              return ExamScheduleList(
                pendingCourseList: courseListPending, //courseListPending,
              );
            }
            return Text('Could not load data');
          },
        ),
      ),
    );
  }
}
