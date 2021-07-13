import 'package:ace_of_spades/constants/course_remarks.dart';
import 'package:ace_of_spades/courses/course.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/manage_courses/enrolment_service.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ManageCourseTileAdd extends StatefulWidget {
  final Course course;
  final bool isRegistrationOpenAdd;
  final String semester;
  final String year;

  ManageCourseTileAdd(
      {@required this.course, @required this.isRegistrationOpenAdd, @required this.semester, @required this.year});

  @override
  _ManageCourseTileAddState createState() => _ManageCourseTileAddState();
}

class _ManageCourseTileAddState extends State<ManageCourseTileAdd> {
  String courseRemarks = 'proper';

  Future<List> _showDialogBox(BuildContext context, Course course) async {
    return showDialog<List>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enroll'),
          content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Select Enrolment Status'),
                  RadioListTile(
                    title: Text(
                      'Proper',
                      style: bodyText18,
                    ),
                    groupValue: courseRemarks,
                    value: CourseRemarks.PROPER,
                    onChanged: (value) {
                      setState(() {
                        courseRemarks = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      'Medical Proper',
                      style: bodyText18,
                    ),
                    groupValue: courseRemarks,
                    value: CourseRemarks.MEDICAL_PROPER,
                    onChanged: (value) {
                      setState(() {
                        courseRemarks = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      'Special',
                      style: bodyText18,
                    ),
                    groupValue: courseRemarks,
                    value: CourseRemarks.SPECIAL,
                    onChanged: (value) {
                      setState(() {
                        courseRemarks = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      'Repeat',
                      style: bodyText18,
                    ),
                    groupValue: courseRemarks,
                    value: CourseRemarks.REPEAT,
                    onChanged: (value) {
                      setState(() {
                        courseRemarks = value;
                      });
                    },
                  ),
                  Text('Confirm enrolment into ${course.code} ${course.name}')
                ],
              ),
            );
          }),
          actions: <Widget>[
            RaisedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop([false, courseRemarks]);
              },
            ),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              color: Colors.green,
              child: Text('Enrol'),
              onPressed: () {
                Navigator.of(context).pop([true, courseRemarks]);
              },
            ),
          ],
        );
      },
    );
  }

  _showEnrolSuccessAlert(Object object) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.greenAccent,
        elevation: 10,
        content: Text(
          object.toString(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Future<void> _showEnrolFailAlert(exceptionObject) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Oops!!',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(exceptionObject.toString().replaceFirst('Exception: ', '')),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: borderColor, width: 0.5)),
      child: ListTile(
        isThreeLine: true,
        title: Text(
          widget.course.code,
          style: bodyText18,
        ),
        subtitle: Text(
          '${widget.course.credits.values.first.toString()} Credit\n${widget.course.name}',
          style: subtitle16,
        ),
        leading: IconButton(
          color: Colors.green,
          icon: Icon(Icons.add_circle),
          onPressed: widget.isRegistrationOpenAdd
              ? () async {
                  List addParam = await _showDialogBox(context, widget.course);
                  print(addParam);
                  if (addParam[0]) {
                    try {
                      await EnrolmentService.addCourse(widget.course, addParam[1], widget.semester, widget.year);
                    } on Exception catch (exception) {
                      await _showEnrolFailAlert(exception);
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } on Object catch (object) {
                      _showEnrolSuccessAlert(object);
                    }
                  }
                }
              : null,
        ),
      ),
    );
  }
}

class ManageCourseTileRemove extends StatelessWidget {
  final StudentCourse studentCourse;
  final bool isRegistrationOpenRemove;

  ManageCourseTileRemove({this.studentCourse, this.isRegistrationOpenRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: borderColor, width: 0.5)),
      child: ListTile(
        isThreeLine: true,
        title: Text(
          studentCourse.code,
          style: bodyText18,
        ),
        subtitle: Text(
          '${studentCourse.credits} Credit\n${studentCourse.name}',
          style: subtitle16,
        ),
        leading: IconButton(
          color: redColor,
          icon: Icon(Icons.remove_circle),
          onPressed: isRegistrationOpenRemove
              ? () async {
                  bool delete = await _showDialogBox(context, studentCourse);
                  print(delete);
                  if (delete) {
                    EnrolmentService.removeCourse(studentCourse);
                  }
                }
              : null,
        ),
      ),
    );
  }

  Future<bool> _showDialogBox(BuildContext context, StudentCourse studentCourse) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unenroll'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to unenroll from ${studentCourse.code.toUpperCase()} - ${studentCourse.name}?'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            SizedBox(
              width: 10,
            ),
            RaisedButton(
              color: Colors.red,
              child: Text('Remove'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
