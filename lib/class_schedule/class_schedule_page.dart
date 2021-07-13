import 'package:ace_of_spades/config/db.config.dart';
import 'package:ace_of_spades/constants.dart';
import 'package:ace_of_spades/constants/grades.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'course_schedule.dart';
import 'schedule_data_source.dart';

class ClassSchedulePage extends StatefulWidget {
  @override
  _ClassSchedulePageState createState() => _ClassSchedulePageState();
}

class _ClassSchedulePageState extends State<ClassSchedulePage> {
  CalendarController _calendarController;
  List<CourseSchedule> courseScheduleList = <CourseSchedule>[];

  CollectionReference classScheduleRef = FirebaseFirestore.instance.collection(DbConfigPath.CLASS_SCHEDULE);
  var studentDocument = FirebaseFirestore.instance
      .collection('${DbConfigPath.STUDENT}${FirebaseAuth.instance.currentUser.email.substring(0, 3).toLowerCase()}')
      .doc(FirebaseAuth.instance.currentUser.email.substring(3, 6).toString());

  //TODO: Test above
  //var studentDocument = FirebaseFirestore.instance.collection('students16').doc('072');

  @override
  void initState() {
    _calendarController = CalendarController();
    _calendarController.view = CalendarView.week;
    super.initState();
  }

  List<String> getCourseCode(List list) {
    List<String> results = [];

    for (var item in list) {
      results.add(item['course_code'].toString().toUpperCase());
    }

    return results;
  }

  ScheduleDataSource _getCalendarDataSource(
      List<Map<String, dynamic>> scheduleDocMap, List<CourseSchedule> courseSchList) {
    if (scheduleDocMap != null || scheduleDocMap.isNotEmpty) {
      for (var schDoc in scheduleDocMap) {
        courseSchList.add(
          CourseSchedule.createCourseSchedule(
            scheduleDocument: schDoc,
            //backgroundColor: Colors.greenAccent[400],
          ),
        );
      }
    }

    return ScheduleDataSource(courseScheduleList);
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      if (_calendarController.view == CalendarView.week) {
        _calendarController.view = CalendarView.day;
      } else if (_calendarController.view == CalendarView.month) {
        _calendarController.view = CalendarView.week;
      }
    } else if (details.targetElement == CalendarElement.appointment) {
      //FIXME: touch on appointmnet goes to first day of week
      if (_calendarController.view == CalendarView.week) {
        _calendarController.view = CalendarView.day;
      }
    } else if (details.targetElement == CalendarElement.viewHeader) {
      if (_calendarController.view == CalendarView.week) {
        _calendarController.view = CalendarView.day;
      } else if (_calendarController.view == CalendarView.day) {
        _calendarController.view = CalendarView.week;
      }
    }
  }

  /* void showInfoDialog({String title, String content}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: redColor),
                ),
              ),
            ],
          );
        });
  } */

  SpeedDialChild buildSpeedDialChild({IconData icon, String label, Function onTap}) {
    return SpeedDialChild(
      child: Icon(icon),
      backgroundColor: Colors.white,
      foregroundColor: redColor,
      label: label,
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(studentDocument.toString());
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          visible: true,
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          onOpen: () => print('OPENING DIAL'),
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: redColor,
          foregroundColor: Colors.white,
          elevation: 8.0,
          shape: CircleBorder(),
          children: [
            buildSpeedDialChild(
              icon: Icons.calendar_view_day,
              label: 'Daily View',
              onTap: () => _calendarController.view = CalendarView.day,
            ),
            buildSpeedDialChild(
              icon: Icons.view_week,
              label: 'Weekly View',
              onTap: () => _calendarController.view = CalendarView.week,
            ),
            buildSpeedDialChild(
              icon: Icons.calendar_today,
              label: 'Monthly View',
              onTap: () => _calendarController.view = CalendarView.month,
            ),
            buildSpeedDialChild(
              icon: Icons.today,
              label: 'Today',
              onTap: () {
                _calendarController.displayDate = DateTime.now();
                _calendarController.selectedDate = DateTime.now();
              },
            ),
          ],
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
                return e['grade'].toString().contains(Grades.O);
              }).toList();

              return StreamBuilder(
                stream: classScheduleRef.where('course_code', whereIn: getCourseCode(courseListPending)).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    List<Map<String, dynamic>> list = [];

                    snapshot.data.docs.map((e) {
                      list.add(e.data());
                    }).toList();

                    return SfCalendar(
                      headerStyle: CalendarHeaderStyle(
                        textAlign: TextAlign.center,
                        backgroundColor: redColor,
                        textStyle: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      todayHighlightColor: redColor,
                      todayTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      controller: _calendarController,
                      firstDayOfWeek: 1,
                      timeSlotViewSettings: TimeSlotViewSettings(startHour: 6, endHour: 19),
                      dataSource: _getCalendarDataSource(list, courseScheduleList),
                      onTap: (CalendarTapDetails details) {
                        calendarTapped(details);
                      },
                    );
                  }
                  return Text('Could not load data');
                },
              );
            }
            return Text('Could not load data');
          },
        ),
      ),
    );
  }
}
