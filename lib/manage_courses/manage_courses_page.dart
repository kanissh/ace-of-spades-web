import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants/course_status.dart';
import 'package:ace_of_spades/constants/credit_limit.dart';
import 'package:ace_of_spades/grades/student_course.dart';
import 'package:ace_of_spades/manage_courses/add_courses_page.dart';
import 'package:ace_of_spades/manage_courses/manage_course_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class ManageCoursesPage extends StatefulWidget {
  @override
  _ManageCoursesPageState createState() => _ManageCoursesPageState();
}

class _ManageCoursesPageState extends State<ManageCoursesPage> {
  var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfigPath.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());

  DocumentReference configRegistrationDocument =
      FirebaseFirestore.instance.collection(DbConfigPath.CONFIG).doc(DbConfigPath.COURSE_REGISTRATION_CONFIG_DOC);

  bool isRegistrationOpenRemove = false;
  bool isRegistrationOpenAdd = false; //FIXME: default value, and is set dynamically
  String semester = '';
  String year = '';

  bool showMinBanner = true;

  void initState() {
    super.initState();
    setConfigParams();
  }

  Future<void> _showInfoDialog() async {
    //Info dialog
    var studentDocumentSnapshot = await studentDocument.get();
    num currentCredits = studentDocumentSnapshot.data()['current_credits'];

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Credit Information',
            style: bodyText18b,
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      '${currentCredits} / ${CreditLimit.creditSemMax}',
                      style: TextStyle(fontSize: 36),
                    ),
                    Spacer(),
                    Text('credits enrolled'),
                  ],
                ),
                Text(
                    '\nTotal number of credits enrolled in a semester should not be less than ${CreditLimit.creditSemMin} and should not be more than ${CreditLimit.creditSemMax}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  getEnrolledCourses() {
    return StreamBuilder(
        stream: studentDocument.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          List<ManageCourseTileRemove> widgetList = [];
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
            List courseList = snapshot.data['courses'];
            List enrolledCourseList = courseList.where((course) {
              return course['status'] == CourseStatus.ENROLLED;
            }).toList();

            enrolledCourseList.forEach((courseMap) {
              widgetList.add(
                ManageCourseTileRemove(
                  studentCourse: StudentCourse.convertToObject(courseMap),
                  isRegistrationOpenRemove: isRegistrationOpenRemove,
                ),
              );
            });

            return widgetList.isEmpty
                ? Center(
                    child: Text(
                      'You have no enrolled courses to review!',
                      style: bodyText18,
                    ),
                  )
                : ListView(children: widgetList);
          }

          return Text('Could not load data');
        });
  }

  void setConfigParams() async {
    //get params from database
    bool add = await configRegistrationDocument.get().then((value) => value['registration_add']);
    bool remove = await configRegistrationDocument.get().then((value) => value['registration_remove']);
    String sem = await configRegistrationDocument.get().then((value) => value['semester']);
    String yr = await configRegistrationDocument.get().then((value) => value['year']);

    setState(() {
      isRegistrationOpenAdd = add;
      isRegistrationOpenRemove = remove;
      semester = sem;
      year = yr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: Visibility(
          visible: (isRegistrationOpenAdd && !isRegistrationOpenRemove) ||
              (!isRegistrationOpenAdd && !isRegistrationOpenRemove) ||
              (!isRegistrationOpenAdd && isRegistrationOpenRemove),
          child: BottomSheet(
            elevation: 5,
            builder: (context) => Container(
              color: Colors.black87,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: (isRegistrationOpenAdd && !isRegistrationOpenRemove)
                    ? Text(
                        'Oops! you cannot remove courses but course enrollment is open...', //TODO: clip below floation action button
                        style: TextStyle(color: Colors.white))
                    : ((!isRegistrationOpenAdd && !isRegistrationOpenRemove)
                        ? Text('Course Registration is CLOSED!', style: TextStyle(color: Colors.white))
                        : Text('Oops, course registration period is over but course removal is possible.',
                            style: TextStyle(color: Colors.white))),
              ),
            ),
            onClosing: () {},
          ),
        ),
        floatingActionButton: Visibility(
          visible: isRegistrationOpenAdd,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.add),
            onPressed: isRegistrationOpenAdd
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCoursePage(
                          isRegistrationOpenAdd: isRegistrationOpenAdd,
                          semester: semester,
                          year: year,
                        ),
                      ),
                    );
                  }
                : null,
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.info_outline_rounded),
                onPressed: () {
                  _showInfoDialog();
                })
          ],
          centerTitle: true,
          title: Text('Enrolled Courses'),
        ),
        body: StreamBuilder(
          stream: studentDocument.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {} //TODO: complete this

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(redColor),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.active) {
              return Column(
                children: [
                  if (snapshot.data['current_credits'] > CreditLimit.creditSemMax) //red banner when credit > 33
                    MaterialBanner(
                        backgroundColor: Colors.red,
                        leading: FaIcon(
                          FontAwesomeIcons.exclamationCircle,
                          color: Colors.white,
                        ),
                        content: Padding(
                          child: Text(
                            'Credit limit exceeded',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _showInfoDialog();
                            },
                            child: Text('More Info'),
                          ),
                        ]),
                  if (snapshot.data['current_credits'] >= CreditLimit.creditSemMin &&
                      snapshot.data['current_credits'] <= CreditLimit.creditSemMax &&
                      showMinBanner) //green banner to show when 27 reached
                    MaterialBanner(
                        backgroundColor: Colors.green,
                        leading: FaIcon(
                          FontAwesomeIcons.checkCircle,
                          color: Colors.white,
                        ),
                        content: Padding(
                          child: Text(
                            'Reached minimum credit limit',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              _dismissMinBanner();
                            },
                            child: Text('Dismiss'),
                          ),
                        ]),
                  Flexible(child: getEnrolledCourses()),
                ],
              );
            }

            return Center(child: Text('Oops! Something went wrong.'));
          },
        ),
      ),
    );
  }

  void _dismissMinBanner() {
    setState(() {
      showMinBanner = false;
    });
  }
}
