import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/manage_courses/add_course_search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'manage_course_tile.dart';

class AddCoursePage extends StatefulWidget {
  final bool isRegistrationOpenAdd;
  final String semester;
  final String year;

  AddCoursePage({@required this.isRegistrationOpenAdd, @required this.semester, @required this.year});

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  CollectionReference _coursesCollectionReference = FirebaseFirestore.instance.collection(DbConfigPath.COURSE);

  getAvailableCourses() {
    return StreamBuilder(
      stream: _coursesCollectionReference.where('avail', isEqualTo: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Data error occurred'); //TODO: handle
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(redColor),
            ),
          ); //Text('waiting');

        }

        if (snapshot.connectionState == ConnectionState.active) {
          // print(snapshot.data.toString());
          List<ManageCourseTileAdd> list =
              snapshot.data.docs.map<ManageCourseTileAdd>((DocumentSnapshot documentSnapshot) {
            return ManageCourseTileAdd(
              course: Course.convertCourseDocToObject(documentSnapshot),
              isRegistrationOpenAdd: widget.isRegistrationOpenAdd,
              semester: widget.semester,
              year: widget.year,
            );
          }).toList();

          return ListView(
            children: list,
          );
        }

        return Text('Could not load data');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: redColor,
          child: Icon(Icons.search),
          onPressed: () {
            showSearch(
              context: context,
              delegate: AddCourseSearch(
                addCourseList: _coursesCollectionReference.where('avail', isEqualTo: true).get(),
                isRegistrationOpenAdd: widget.isRegistrationOpenAdd,
                semester: widget.semester,
                year: widget.year,
              ),
            );
          },
        ),
        appBar: AppBar(
          title: Text('Add Courses'),
          centerTitle: true,
        ),
        body: getAvailableCourses(),
      ),
    );
  }
}
