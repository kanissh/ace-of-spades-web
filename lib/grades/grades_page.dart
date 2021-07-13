import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/grades.dart';
import 'package:ace_of_spades/grades/calculate_gpa.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/grades/student_course_tile.dart';
import 'package:ace_of_spades/ui_components/subheading_red.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class GradesPage extends StatefulWidget {
  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  final String _userEmail = FirebaseAuth.instance.currentUser.email;

  var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfigPath.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());

  //var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');

  void addToWidgetList(List dataList, List<Widget> widgetList) {
    for (var item in dataList) {
      widgetList.add(
        StudentCourseTile(
          studentCourse: StudentCourse.convertToObject(item),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Grades'), centerTitle: true),
        body: FutureBuilder(
          future: studentDocument.get(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Cannot load connection'),
              );
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
                return e['grade'].toString().contains(Grades.O);
              }).toList();

              // get completed courses
              List courseListCompleted = courseList.where((e) {
                return !e['grade'].toString().contains(Grades.O);
              }).toList();

              //TODO: use the status tag and rewrite

              //create new widget list to display
              List<Widget> _courseTileList = List();

              //add initial heading
              _courseTileList.addAll([
                blockDivider,
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: SubHeadingRed(title: 'on going courses'),
                ),
                SizedBox(
                  height: 5,
                )
              ]);

              //add pending courses
              addToWidgetList(courseListPending, _courseTileList);

              //add completed heading
              _courseTileList.addAll([
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: SubHeadingRed(title: 'completed courses'),
                ),
                SizedBox(
                  height: 5,
                )
              ]);

              //add completed list
              addToWidgetList(courseListCompleted, _courseTileList);

              return Column(
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CurrentGPA(),
                        Text(
                          CalculateGpa.calculateGpa(courseList: courseListCompleted).toStringAsFixed(2),
                          style: gpaDisplayStyle,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: _courseTileList,
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: Text('Could not load data'),
            );
          },
        ),
      ),
    );
  }
}

class CurrentGPA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Current',
            style: TextStyle(fontSize: 18, fontFamily: 'Montserrat'),
          ),
          Text(
            'GPA',
            style: TextStyle(fontSize: 32, fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
