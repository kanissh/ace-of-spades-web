import 'package:ace_of_spades/ui_components/time_label.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import 'exam_schedule_object.dart';

class ExamScheduleTile extends StatelessWidget {
  final ExamScheduleObject _examScheduleObject;

  ExamScheduleTile({ExamScheduleObject examScheduleObject}) : this._examScheduleObject = examScheduleObject;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: borderColor, width: 0.5),
        ),
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 20, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _examScheduleObject.startTime.day.toString(),
                      style: TextStyle(
                        fontSize: 36,
                      ),
                    ),
                    Text(
                      DateFormat.E().format(_examScheduleObject.startTime).toUpperCase(),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: redColor),
                    ),
                  ],
                ),
                flex: 1,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _examScheduleObject.courseCode,
                      style: bodyText18b,
                    ),
                    Wrap(
                      children: [
                        Text(
                          DateFormat.yMMM().format(_examScheduleObject.startTime).toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Visibility(
                          visible: _examScheduleObject.desc != null,
                          child: buildTimeLabel(),
                        ),
                      ],
                    ),
                    _examScheduleObject.desc != null
                        ? Text(
                            _examScheduleObject.desc,
                            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                          )
                        : buildTimeLabel(),
                  ],
                ),
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TimeLabel buildTimeLabel() {
    return TimeLabel(
      time: DateFormat.Hm().format(_examScheduleObject.startTime) +
          ' - ' +
          DateFormat.Hm().format(_examScheduleObject.endTime),
    );
  }
}
