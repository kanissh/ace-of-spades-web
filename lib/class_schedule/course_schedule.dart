import 'package:flutter/material.dart';

class CourseSchedule {
  CourseSchedule._({this.courseCode, this.from, this.to, this.background, this.isAllDay, this.recurrenceRule});

  String courseCode;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String recurrenceRule;

  static CourseSchedule createCourseSchedule({
    Map<String, dynamic> scheduleDocument,
    /*  Color backgroundColor */
  }) {
    return CourseSchedule._(
        courseCode: scheduleDocument['course_code'],
        from: scheduleDocument['start_time'].toDate(),
        to: scheduleDocument['end_time'].toDate(),
        isAllDay: scheduleDocument['isAllDay'],
        background: scheduleDocument['color'] == null
            ? Colors.blue
            : Color.fromARGB(
                scheduleDocument['color'][0],
                scheduleDocument['color'][1],
                scheduleDocument['color'][2],
                scheduleDocument['color'][3],
              ), //backgroundColor,
        recurrenceRule: scheduleDocument['recur']
            ? 'FREQ=WEEKLY;INTERVAL=1;BYDAY=${scheduleDocument['weekday']};UNTIL=${scheduleDocument['recur_until']}'
            : null);
  }
}
