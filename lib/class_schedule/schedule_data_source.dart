import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'course_schedule.dart';

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<CourseSchedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments[index].courseCode;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  String getRecurrenceRule(int index) {
    return appointments[index].recurrenceRule;
  }
}
